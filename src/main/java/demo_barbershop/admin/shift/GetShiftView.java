package demo_barbershop.admin.shift;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.admin.barber.Barber;
import demo_barbershop.admin.barber.BarberDAO;

@WebServlet("/admin/GetShiftView")
public class GetShiftView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public GetShiftView() {
		super();
	}

	// handle request to get shift id
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int shiftId = Integer.parseInt(request.getParameter("shift_id"));

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		// retrieve selected shift
		ShiftDAO shiftdao = new ShiftDAO();
		Shift shift = shiftdao.getShiftById(shiftId);

		// retrieve barber info
		BarberDAO barberDAO = new BarberDAO();
		Barber barber = barberDAO.getBarberById(shift.getBarberId());

		// list all days
		List<String> allDays = Arrays.asList("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday",
				"Sunday");

		// list working days for the barber
		List<String> workingDays = barberDAO.getBarberWorkingDays(barber.getBarberId());

		// redirect to edit shift page
		request.setAttribute("getshift", shift);
		request.setAttribute("allDays", allDays);
		request.setAttribute("workingDays", workingDays);
		request.setAttribute("barber", barber);
		request.getRequestDispatcher("/admin/edit_shift.jsp").forward(request, response);
	}
}
