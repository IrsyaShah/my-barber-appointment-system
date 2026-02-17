package demo_barbershop.staff;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.shift.Shift;
import demo_barbershop.admin.shift.ShiftDAO;

@WebServlet("/staff/ScheduleView")
public class ScheduleView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public ScheduleView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		Staff s = (Staff) session.getAttribute("loggedInStaff");

		if (s == null) {
			response.sendRedirect("../login.jsp");
			return;
		}

		// create object to access shift data
		ShiftDAO dao = new ShiftDAO();

		// get list of all shifts from database
		ArrayList<Shift> shiftList = dao.getOwnSchedule(s.getStaffId());

		// store the shift list in request scope to send
		request.setAttribute("shifts", shiftList);

		StaffDAO staffDAO = new StaffDAO();

		int count = staffDAO.getPendingCountByBarber(s.getStaffId());

		// Set only the count attribute
		request.setAttribute("pendingCount", count);

		// forward request to manage shift page to display shifts
		RequestDispatcher dispatcher = request.getRequestDispatcher("/staff/view_schedule.jsp");
		dispatcher.forward(request, response);
	}
}
