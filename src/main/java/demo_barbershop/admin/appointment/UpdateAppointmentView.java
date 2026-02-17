package demo_barbershop.admin.appointment;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.barber.BarberDAO;

import java.util.*;

@WebServlet("/admin/UpdateAppointmentView")
public class UpdateAppointmentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateAppointmentView() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		BarberDAO barberDao = new BarberDAO();
		AppointmentDAO appointmentDao = new AppointmentDAO();

		// always load barbers
		request.setAttribute("barbers", barberDao.getBarber());

		String apptIdStr = request.getParameter("appointment_id");
		Appointment appt = null;

		if (apptIdStr != null && !apptIdStr.isEmpty()) {
			int appointmentId = Integer.parseInt(apptIdStr);
			appt = appointmentDao.getAppointmentById(appointmentId);
			request.setAttribute("getappointment", appt);
		}

		String action = request.getParameter("action");

		if ("load".equals(action)) {
			String barberIdStr = request.getParameter("barber_id");

			if (appt != null) {
				appt.setAppointmentDate(null);
				appt.setAppointmentFinish(null);
			}

			if (barberIdStr != null && !barberIdStr.isEmpty()) {
				int barberId = Integer.parseInt(barberIdStr);

				request.setAttribute("selectedBarberId", barberId);

				// working days
				request.setAttribute("workingDays", barberDao.getBarberWorkingDays(barberId));

				// shifts
				List<String[]> barberShifts = barberDao.getBarberShiftsDay(barberId);

				request.setAttribute("barberShifts", barberShifts);

				Map<String, List<String[]>> shiftsByDay = new HashMap<>();
				for (String[] shift : barberShifts) {
					String day_name = shift[0];
					shiftsByDay.computeIfAbsent(day_name, k -> new ArrayList<>()).add(shift);
				}

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
				request.setAttribute("services", barberDao.getBarberService(barberId));
			}
		} else if ("save".equals(action)) {

			DateTimeFormatter startFormatter = DateTimeFormatter.ofPattern("HH:mm");
			DateTimeFormatter finishFormatter = DateTimeFormatter.ofPattern("hh:mm a", Locale.ENGLISH);

			// get updated input from form
			int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));
			int barberId = Integer.parseInt(request.getParameter("barber_id"));
			String appointmentDateStr = request.getParameter("appointment_date");
			LocalTime appointmentStart = LocalTime.parse(request.getParameter("appointment_start"), startFormatter);
			LocalTime appointmentFinish = LocalTime.parse(request.getParameter("appointment_finish"), finishFormatter);
			String remarks = request.getParameter("remarks");
			String status = request.getParameter("status");

			HttpSession session = request.getSession();

			// convert date
			LocalDate appointmentDate = null;
			if (appointmentDateStr != null && !appointmentDateStr.isEmpty()) {
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
				appointmentDate = LocalDate.parse(appointmentDateStr, formatter);
			}

			// Get the day name from the selected date
			String dayName = appointmentDate.getDayOfWeek().name();
			dayName = dayName.charAt(0) + dayName.substring(1).toLowerCase();

			// Fetch shifts for this barber on that day
			List<String[]> barberShiftsForDay = appointmentDao.getBarberShifts(barberId, dayName);

			// If barber has no shift on that day
			if (barberShiftsForDay.isEmpty()) {
				session.setAttribute("check_date", "Barber is not available. Please choose another date.");
				response.sendRedirect(
						request.getContextPath() + "/admin/GetAppointmentView?appointment_id=" + appointmentId);
				return;
			}

			// Check if selected time fits within shift
			boolean isTimeValid = false;
			for (String[] shift : barberShiftsForDay) {
				LocalTime shiftStart = LocalTime.parse(shift[0]);
				LocalTime shiftEnd = LocalTime.parse(shift[1]);

				if (!appointmentStart.isBefore(shiftStart) && !appointmentFinish.isAfter(shiftEnd)) {
					isTimeValid = true;
					break;
				}
			}

			if (!isTimeValid) {
				session.setAttribute("check_date", "The selected time is not valid for the day.");
				response.sendRedirect(
						request.getContextPath() + "/admin/GetAppointmentView?appointment_id=" + appointmentId);
				return;
			}

			// Check if the selected time is already booked
			boolean isTimeConflict = appointmentDao.existBookTime(appointmentId, barberId, appointmentDate,
					appointmentStart, appointmentFinish);

			if (isTimeConflict) {
				session.setAttribute("check_date", "This time is already booked. Please choose another time.");
				response.sendRedirect(
						request.getContextPath() + "/admin/GetAppointmentView?appointment_id=" + appointmentId);
				return;
			}

			// update required fields
			Appointment appt_updated = new Appointment();
			appt_updated.setAppointmentId(appointmentId);
			appt_updated.setBarberId(barberId);
			appt_updated.setAppointmentDate(appointmentDate);
			appt_updated.setAppointmentStart(appointmentStart);
			appt_updated.setAppointmentFinish(appointmentFinish);
			appt_updated.setRemarks(remarks);
			appt_updated.setStatus(status);

			// services
			String[] serviceIds = request.getParameterValues("serviceIds");

			boolean updated = appointmentDao.UpdateAppointment(appt_updated, serviceIds);

			if (updated) {
				session.setAttribute("appointment_updated", "Appointment updated successfully!");

				response.sendRedirect(request.getContextPath() + "/admin/ListAppointmentView");
				return;
			}
		}

		request.getRequestDispatcher("edit_appointment.jsp").forward(request, response);
	}
}
