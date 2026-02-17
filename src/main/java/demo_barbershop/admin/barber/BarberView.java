package demo_barbershop.admin.barber;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.admin.service.Service;
import demo_barbershop.admin.service.ServiceDAO;

@WebServlet("/admin/BarberView")
public class BarberView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public BarberView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// create object to access service data
		ServiceDAO serviceDAO = new ServiceDAO();
		
		// get list of all services from database
		List<Service> serviceList = serviceDAO.getAllServices();

		// store the service list in request scope to send
		request.setAttribute("serviceList", serviceList);
		
		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		request.getRequestDispatcher("/admin/add_barber.jsp").forward(request, response);
	}
}
