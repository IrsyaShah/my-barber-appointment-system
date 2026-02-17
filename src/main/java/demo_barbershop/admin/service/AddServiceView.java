package demo_barbershop.admin.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.AdminDAO;

@WebServlet("/admin/AddServiceView")
public class AddServiceView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public AddServiceView() {
		super();
	}

	// handle request when admin add new service
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get admin input from service form
		String servicename = request.getParameter("service_name");
		String price_num = request.getParameter("price");
		double price = 0;

		// validate price is numeric
		try {
			price = Double.parseDouble(price_num);

			if (price < 0) {

				// if negative price show error message
				request.setAttribute("price_negative", "Price cannot be negative!");
				request.getRequestDispatcher("add_service.jsp").forward(request, response);
				return;
			}
		} catch (NumberFormatException e) {

			// if invalid price show error message
			request.setAttribute("price_error", "Enter a valid price!");
			request.getRequestDispatcher("add_service.jsp").forward(request, response);
			return;
		}

		// create new service object
		Service s = new Service(0, servicename, price);

		// use DAO to insert data in database
		ServiceDAO dao = new ServiceDAO();
		boolean inserted = dao.AddService(s);

		if (inserted) {

			// get session object
			HttpSession session = request.getSession();

			// insert data and redirect to manage service with success message
			session.setAttribute("service_added", "Service added successfully!");
			response.sendRedirect(request.getContextPath() + "/admin/ListServiceView");
		} else {
			// redirect back with error message
			request.setAttribute("service_error", "Service already exists!");
			request.getRequestDispatcher("add_service.jsp").forward(request, response);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);
	}
}
