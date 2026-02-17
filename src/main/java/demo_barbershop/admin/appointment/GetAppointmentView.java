package demo_barbershop.admin.appointment;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.admin.barber.Barber;
import demo_barbershop.admin.barber.BarberDAO;
import demo_barbershop.admin.barber.BarberService;

@WebServlet("/admin/GetAppointmentView")
public class GetAppointmentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public GetAppointmentView() {
		super();
	}

	// handle request to get appointment id
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));

		// retrieve selected appointment
		AppointmentDAO appointmentdao = new AppointmentDAO();
		Appointment appointment = appointmentdao.getAppointmentById(appointmentId);

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();
		request.setAttribute("pendingCount", count);

		List<Integer> appointmentServiceIds = appointmentdao.getAppointmentServiceIds(appointmentId);

		// retrieve barber info
		BarberDAO barberDAO = new BarberDAO();
		List<Barber> barberList = barberDAO.getBarber();

		// retrieve barber services for the assigned barber
		List<BarberService> services = barberDAO.getBarberService(appointment.getBarberId());

		// list working days for the barber
		List<String> workingDays = barberDAO.getBarberWorkingDays(appointment.getBarberId());

		// get barber shifts
		List<String[]> barberShifts = barberDAO.getBarberShiftsDay(appointment.getBarberId());

		// generate start time slots based on shift start and finish
		List<String> timeSlots = new ArrayList<>();
		for (String[] shift : barberShifts) {
			String shiftStart = shift[1];
			String shiftFinish = shift[2];

			// generate 30-min interval slots
			String[] startParts = shiftStart.split(":");
			int startHour = Integer.parseInt(startParts[0]);
			int startMinute = Integer.parseInt(startParts[1]);

			String[] finishParts = shiftFinish.split(":");
			int finishHour = Integer.parseInt(finishParts[0]);
			int finishMinute = Integer.parseInt(finishParts[1]);

			while (startHour < finishHour || (startHour == finishHour && startMinute <= finishMinute - 30)) {
				String slot = String.format("%02d:%02d", startHour, startMinute);
				timeSlots.add(slot);

				startMinute += 30;
				if (startMinute >= 60) {
					startMinute -= 60;
					startHour += 1;
				}
			}
		}

		Map<String, List<String[]>> shiftsByDay = new HashMap<>();
		for (String[] shift : barberShifts) {
			String day_name = shift[0];
			shiftsByDay.computeIfAbsent(day_name, k -> new ArrayList<>()).add(shift);
		}

		List<String> allDays = List.of("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday");
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

		// set attributes
		request.setAttribute("getappointment", appointment);
		request.setAttribute("barbers", barberList);
		request.setAttribute("services", services);
		request.setAttribute("appointmentServiceIds", appointmentServiceIds);
		request.setAttribute("workingDays", workingDays);
		request.setAttribute("dayTimeSlots", dayTimeSlots);
		request.setAttribute("timeSlots", timeSlots);
		request.setAttribute("selectedStartTime", appointment.getAppointmentStart());
		request.getRequestDispatcher("/admin/edit_appointment.jsp").forward(request, response);
	}
}
