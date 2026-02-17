package demo_barbershop.admin.shift;

import java.time.*;
import java.util.Arrays;
import java.util.List;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.admin.barber.Barber;
import demo_barbershop.admin.barber.BarberDAO;

@WebServlet("/admin/UpdateShiftView")
public class UpdateShiftView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public UpdateShiftView() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get updated input from form
		int shiftId = Integer.parseInt(request.getParameter("shift_id"));
		int barberId = Integer.parseInt(request.getParameter("barber_id"));
		String dayname = request.getParameter("day_name");
		LocalTime startTime = LocalTime.parse(request.getParameter("start_time"));
		LocalTime finishTime = LocalTime.parse(request.getParameter("finish_time"));

		// update required fields
		Shift sh = new Shift();

		sh.setShiftId(shiftId);
		sh.setBarberId(barberId);
		sh.setDayName(dayname);
		sh.setShiftStart(startTime);
		sh.setShiftFinish(finishTime);

		ShiftDAO dao = new ShiftDAO();

		BarberDAO barberDAO = new BarberDAO();
		Barber barber = barberDAO.getBarberById(barberId);
		
		// block from update if shift has pending/confirmed appointments
		if (dao.checkAppointments(shiftId)) {
		    request.setAttribute("day_exists", "This barber still has appointments for this shift.");

		    List<String> allDays = Arrays.asList("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday");
		    List<String> workingDays = barberDAO.getBarberWorkingDays(barber.getBarberId());

		    request.setAttribute("barber", barber);
		    request.setAttribute("allDays", allDays);
		    request.setAttribute("workingDays", workingDays);

		    // keep current shift details on page
		    request.setAttribute("getshift", dao.getShiftById(shiftId));

		    request.getRequestDispatcher("edit_shift.jsp").forward(request, response);
		    return;
		}

		// check each barber for the same day
		if (dao.ExistsShiftDay(barberId, dayname, shiftId)) {

			// list all days
			List<String> allDays = Arrays.asList("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday");

			// list working days for the barber
			List<String> workingDays = barberDAO.getBarberWorkingDays(barber.getBarberId());

			// barber already has another shift on this day
			request.setAttribute("day_exists", "This barber already has a shift on " + dayname);
			
			request.setAttribute("barber", barber);
			request.setAttribute("allDays", allDays);
			request.setAttribute("workingDays", workingDays);
			request.getRequestDispatcher("edit_shift.jsp").forward(request, response);
			return;
		}

		boolean updated = dao.UpdateShift(sh);

		if (updated) {

			// get session object
			HttpSession session = request.getSession();

			// update data and redirect to manage shift with success message
			session.setAttribute("shift_updated", "Shift updated successfully!");
			response.sendRedirect(request.getContextPath() + "/admin/ListShiftView");
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);
	}
}
