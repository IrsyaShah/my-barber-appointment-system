package demo_barbershop.admin.appointment;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.admin.barber.Barber;
import demo_barbershop.admin.barber.BarberDAO;
import demo_barbershop.admin.barber.BarberService;

@WebServlet("/admin/NewAppointmentView")
public class NewAppointmentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public NewAppointmentView() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		BarberDAO barberDao = new BarberDAO();
		AppointmentDAO appointmentDao = new AppointmentDAO();

		// Always load barbers
		List<Barber> barberList = barberDao.getBarber();
		request.setAttribute("barbers", barberList);

		try {

			// load barber details
			if ("load".equals(action)) {

				int barberId = Integer.parseInt(request.getParameter("barberId"));
				request.setAttribute("selectedBarberId", barberId);

				// shifts
				List<String[]> barberShifts = barberDao.getBarberShiftsDay(barberId);
				request.setAttribute("barberShifts", barberShifts);

				Map<String, List<String[]>> shiftsByDay = new HashMap<>();
				for (String[] shift : barberShifts) {
					String day_name = shift[0];
					shiftsByDay.computeIfAbsent(day_name, k -> new ArrayList<>()).add(shift);
				}

				// working days
				List<String> workingDays = barberDao.getBarberWorkingDays(barberId);
				request.setAttribute("workingDays", workingDays);

				Map<String, String> dayTimeMap = new HashMap<>();
				for (String day : workingDays) {
					for (String[] shift : barberShifts) {
						String timeRange = shift[0].substring(0, 5) + " - " + shift[1].substring(0, 5);
						dayTimeMap.put(day, timeRange);
					}
				}

				request.setAttribute("dayTimeMap", dayTimeMap);

				List<String> allDays = List.of("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday",
						"Sunday");
				request.setAttribute("allDays", allDays);

				DateTimeFormatter valueFormatter = DateTimeFormatter.ofPattern("HH:mm");
				DateTimeFormatter labelFormatter = DateTimeFormatter.ofPattern("hh:mm a", Locale.ENGLISH);

				Map<String, List<String[]>> dayTimeSlots = new LinkedHashMap<>();

				// time slots
				for (String day : allDays) {

					List<String[]> slots = new ArrayList<>();

					if (shiftsByDay.containsKey(day)) {
						for (String[] shift : shiftsByDay.get(day)) {

							LocalTime start = LocalTime.parse(shift[1]);
							LocalTime end = LocalTime.parse(shift[2]);

							while (start.isBefore(end)) {
								slots.add(new String[] { start.format(valueFormatter), start.format(labelFormatter) });
								start = start.plusMinutes(30);
							}
						}
					}

					dayTimeSlots.put(day, slots);
				}

				request.setAttribute("dayTimeSlots", dayTimeSlots);

				// services
				List<BarberService> services = barberDao.getBarberService(barberId);
				request.setAttribute("services", services);

				request.getRequestDispatcher("add_appointment.jsp").forward(request, response);
				return;
			}

			// book appointment details
			if ("book".equals(action)) {

				DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a", Locale.ENGLISH);

				String fullName = request.getParameter("full_name");
				String phoneNum = request.getParameter("phone_num");
				int barberId = Integer.parseInt(request.getParameter("barberId"));
				String[] serviceIds = request.getParameterValues("serviceIds");
				DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
				LocalDate date = LocalDate.parse(request.getParameter("appointment_date"), df);
				LocalTime start = LocalTime.parse(request.getParameter("appointment_start"));
				LocalTime finish = LocalTime.parse(request.getParameter("appointment_finish"), timeFormatter);
				String remarks = request.getParameter("remarks");

				HttpSession session = request.getSession();

				// Get the day name from the selected date
				String dayName = date.getDayOfWeek().name();
				dayName = dayName.charAt(0) + dayName.substring(1).toLowerCase();

				// Fetch shifts for this barber on that day
				List<String[]> barberShiftsForDay = appointmentDao.getBarberShifts(barberId, dayName);

				// If barber has no shift on that day
				if (barberShiftsForDay.isEmpty()) {
					session.setAttribute("check_date", "Barber is not available. Please choose another date.");
					response.sendRedirect(request.getContextPath() + "/admin/NewAppointmentView");
					return;
				}

				// Check if selected time fits within shift
				boolean isTimeValid = false;
				for (String[] shift : barberShiftsForDay) {
					LocalTime shiftStart = LocalTime.parse(shift[0]);
					LocalTime shiftEnd = LocalTime.parse(shift[1]);

					if (!start.isBefore(shiftStart) && !finish.isAfter(shiftEnd)) {
						isTimeValid = true;
						break;
					}
				}

				if (!isTimeValid) {
					session.setAttribute("check_date", "The selected time is not valid for the day.");
					response.sendRedirect(request.getContextPath() + "/admin/NewAppointmentView");
					return;
				}

				// Check if the selected time is already booked
				boolean isTimeConflict = appointmentDao.existTime(barberId, date, start, finish);
				if (isTimeConflict) {
					session.setAttribute("check_date", "This time is already booked. Please choose another time.");
					response.sendRedirect(request.getContextPath() + "/admin/NewAppointmentView");
					return;
				}

				Appointment appt = new Appointment(0, 0, barberId, date, start, finish, remarks, "Pending");

				boolean inserted = appointmentDao.NewAppointment(fullName, phoneNum, appt, serviceIds);

				if (inserted) {
					response.sendRedirect(request.getContextPath() + "/admin/ListAppointmentView");
				} else {
					request.setAttribute("error", "Booking failed.");
					request.getRequestDispatcher("add_appointment.jsp").forward(request, response);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Invalid booking data.");
			request.getRequestDispatcher("add_appointment.jsp").forward(request, response);
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BarberDAO dao = new BarberDAO();
		List<Barber> barberList = dao.getBarber();
		request.setAttribute("barbers", barberList);

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		// forward to JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("add_appointment.jsp");
		dispatcher.forward(request, response);
	}

}
