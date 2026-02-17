package demo_barbershop.admin.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;

@WebServlet("/admin/GetServiceView")
public class GetServiceView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public GetServiceView() {
		super();
	}

	// handle request to get service id
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int serviceId = Integer.parseInt(request.getParameter("service_id"));

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		// use DAO to retrieve data in database
		ServiceDAO dao = new ServiceDAO();
		Service service = dao.getServiceById(serviceId);

		// redirect to edit service page
		request.setAttribute("getservice", service);
		request.getRequestDispatcher("/admin/edit_service.jsp").forward(request, response);
	}
}
