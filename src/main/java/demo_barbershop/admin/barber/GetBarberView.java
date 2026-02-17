package demo_barbershop.admin.barber;

import java.util.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.admin.service.Service;
import demo_barbershop.admin.service.ServiceDAO;

@WebServlet("/admin/GetBarberView")
public class GetBarberView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public GetBarberView() {
		super();
	}

	// handle request to get barber id
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int barberId = Integer.parseInt(request.getParameter("barber_id"));

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		// retrieve selected barber
		BarberDAO dao = new BarberDAO();
		Barber barber = dao.getBarberById(barberId);

		// retrieve all services
		ServiceDAO serviceDAO = new ServiceDAO();
		List<Service> serviceList = serviceDAO.getAllServices();

		// retrieve assigned services
		List<BarberService> assignedServices = dao.getBarberService(barberId);

		Map<Integer, String> assignService = new HashMap<>();
		for (BarberService bs : assignedServices) {
			assignService.put(bs.getServiceId(), bs.getSkillLevel());
		}

		// redirect to edit barber page
		request.setAttribute("getbarber", barber);
		request.setAttribute("serviceList", serviceList);
		request.setAttribute("assignService", assignService);
		request.getRequestDispatcher("/admin/edit_barber.jsp").forward(request, response);
	}
}
