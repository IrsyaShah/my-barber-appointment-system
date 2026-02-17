package demo_barbershop.admin;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/AdminDashboardView")
public class AdminDashboardView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminDashboardView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();

		if (session.getAttribute("loggedInAdmin") == null) {
			response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
			return;
		}

		AdminDAO dao = new AdminDAO();

		// set attribute
		request.setAttribute("pendingCount", dao.getPendingCount());
		request.setAttribute("stats", dao.getDashboardStats());

		List<Integer> monthlyData = dao.getMonthlyAppointmentCounts();

		// Calculate Average
		double sum = 0;
		for (int val : monthlyData)
			sum += val;
		int average = (int) Math.round(sum / 12.0);

		request.setAttribute("monthlyData", monthlyData);
		request.setAttribute("monthlyAverage", average);

		List<Map<String, Object>> sellData = dao.getSellOverview();
		List<String> sellLabels = new ArrayList<>();
		List<Integer> sellQty = new ArrayList<>();
		List<Double> sellRevenue = new ArrayList<>();

		for (Map<String, Object> data : sellData) {
			sellLabels.add((String) data.get("name"));
			sellQty.add((Integer) data.get("sold"));
			sellRevenue.add((Double) data.get("revenue"));
		}

		request.setAttribute("sellLabels", sellLabels);
		request.setAttribute("sellQty", sellQty);
		request.setAttribute("sellRevenue", sellRevenue);

		Map<String, Integer> serviceDist = dao.getServiceDistribution();
		request.setAttribute("serviceLabels", serviceDist.keySet());
		request.setAttribute("serviceValues", serviceDist.values());
		request.setAttribute("statusCounts", dao.getAppointmentStatusCounts());
		request.setAttribute("recentAppointments", dao.getRecentAppointments());

		// Forward to the JSP
		request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
	}
}
