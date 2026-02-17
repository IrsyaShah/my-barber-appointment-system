package demo_barbershop.admin.service;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;

@WebServlet("/admin/ListServiceView")
public class ListServiceView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public ListServiceView() {
		super();
	}

	// handle request to display all services
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// create object to access service data
		ServiceDAO dao = new ServiceDAO();

		// get list of all services from database
		ArrayList<Service> serviceList = dao.getAllServices();

		// store the service list in request scope to send
		request.setAttribute("services", serviceList);

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		// forward request to manage service page to display services
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/manage_service.jsp");
		dispatcher.forward(request, response);
	}
}
