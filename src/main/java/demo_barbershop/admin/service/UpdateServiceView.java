package demo_barbershop.admin.service;

import javax.servlet.http.HttpSession;

import demo_barbershop.admin.AdminDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/UpdateServiceView")
public class UpdateServiceView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public UpdateServiceView() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get updated input from form
		int serviceId = Integer.parseInt(request.getParameter("service_id"));
		String servicename = request.getParameter("service_name");
		String price_num = request.getParameter("price");
		double price = 0;

		// validate price is numeric
		try {
			price = Double.parseDouble(price_num);

			if (price < 0) {

				// if negative price show error message
				request.setAttribute("price_negative", "Price cannot be negative!");
				request.getRequestDispatcher("edit_service.jsp").forward(request, response);
				return;
			}
		} catch (NumberFormatException e) {

			// if invalid price show error message
			request.setAttribute("price_error", "Enter a valid price!");
			request.getRequestDispatcher("edit_service.jsp").forward(request, response);
			return;
		}

		// update required fields
		Service s = new Service();
		s.setServiceId(serviceId);
		s.setServiceName(servicename);
		s.setPrice(price);

		// update service details in database using DAO
		ServiceDAO dao = new ServiceDAO();
		boolean updated = dao.UpdateService(s);

		if (updated) {

			// get session object
			HttpSession session = request.getSession();

			// update data and redirect to manage service with success message
			session.setAttribute("service_updated", "Service updated successfully!");
			response.sendRedirect(request.getContextPath() + "/admin/ListServiceView");
		} else {

			// redirect back with error message
			request.setAttribute("getservice", s);
			request.setAttribute("service_error", "Service already exists!");
			request.getRequestDispatcher("edit_service.jsp").forward(request, response);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);
	}
}
