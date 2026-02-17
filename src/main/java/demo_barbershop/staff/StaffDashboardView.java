package demo_barbershop.staff;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/staff/StaffDashboardView")
public class StaffDashboardView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public StaffDashboardView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Staff s = (Staff) session.getAttribute("loggedInStaff");

		if (s == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		StaffDAO dao = new StaffDAO();
		int barberId = s.getStaffId();

		// Fetch all data from DAO into local variables first
		int pendingCount = dao.getPendingCountByBarber(barberId);
		int upcomingCount = dao.getUpcomingCount(barberId);
		int totalBookings = dao.getTotalBookings(barberId);
		String mostRequested = dao.getMostRequestedService(barberId);

		double todayEarnings = dao.getEarnings(barberId, "today");
		double monthEarnings = dao.getEarnings(barberId, "month");
		double yearEarnings = dao.getEarnings(barberId, "year");
		double allTime = dao.getTotalAllTimeEarnings(barberId);
		Map<String, List<String>> apptDates = dao.getAppointmentDates(barberId);

		// Perform calculations using the local variables
		int earningPercentage = (yearEarnings > 0) ? (int) ((monthEarnings / yearEarnings) * 100) : 0;

		// set the attributes for the JSP
		request.setAttribute("pendingCount", pendingCount);
		request.setAttribute("upcomingCount", upcomingCount);
		request.setAttribute("totalBookings", totalBookings);
		request.setAttribute("mostRequested", mostRequested);
		request.setAttribute("todayEarnings", todayEarnings);
		request.setAttribute("monthEarnings", monthEarnings);
		request.setAttribute("yearEarnings", yearEarnings);
		request.setAttribute("totalAllEarnings", allTime);
		request.setAttribute("earningPercentage", earningPercentage);
		request.setAttribute("apptDates", apptDates);

		// Ensure this path matches your JSP filename exactly
		request.getRequestDispatcher("/staff/index.jsp").forward(request, response);
	}
}
