package demo_barbershop.admin.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/DeleteServiceView")
public class DeleteServiceView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public DeleteServiceView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int serviceId = Integer.parseInt(request.getParameter("service_id"));

		// use DAO to delete data in database
		ServiceDAO dao = new ServiceDAO();
		boolean deleted = dao.DeleteService(serviceId);

		if (deleted) {

			// get session object
			HttpSession session = request.getSession();

			// delete data and redirect to manage service with success message
			session.setAttribute("service_deleted", "Service deleted successfully!");
		} else {

			HttpSession session = request.getSession();
			session.setAttribute("service_error", "Failed to delete service!");
		}

		response.sendRedirect(request.getContextPath() + "/admin/ListServiceView");
	}
}
