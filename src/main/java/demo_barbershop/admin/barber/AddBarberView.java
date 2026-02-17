package demo_barbershop.admin.barber;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.admin.service.Service;
import demo_barbershop.admin.service.ServiceDAO;

@WebServlet("/admin/AddBarberView")
public class AddBarberView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public AddBarberView() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get admin input from barber form
		int barber_id = Integer.parseInt(request.getParameter("barber_id"));
		String fullname = request.getParameter("full_name");
		String email = request.getParameter("email");
		String phonenum = request.getParameter("phone_num");
		String address = request.getParameter("address");

		// create new barber object
		Barber b = new Barber(barber_id, fullname, email, phonenum, address, "active");

		// use DAO to register account in database
		BarberDAO dao = new BarberDAO();

		// Insert barber first and get generated ID if needed
		int barberId = dao.RegisterAccount(b);

		if (barberId != -1) {

			// now insert barber services
			String[] serviceIds = request.getParameterValues("serviceIds");

			if (serviceIds != null) {
				for (String serviceIdStr : serviceIds) {
					int serviceId = Integer.parseInt(serviceIdStr);

					// read selected skill for this service
					String skill = request.getParameter("skillLevel_" + serviceId);

					if (skill != null && !skill.isEmpty()) {
						BarberService bs = new BarberService(barberId, serviceId, skill);
						dao.AssignSkill(bs);
					}
				}
			}

			// get session object
			HttpSession session = request.getSession();

			// if registration successful redirect to manage barber page
			session.setAttribute("acc_created", "Account created successfully!");
			response.sendRedirect(request.getContextPath() + "/admin/ListBarberView");
		} else {

			// if registration fails redirect with error message
			request.setAttribute("email_exists", "Email already exists!");
			doGet(request, response);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ServiceDAO serviceDAO = new ServiceDAO();
		List<Service> serviceList = serviceDAO.getAllServices();

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		request.setAttribute("serviceList", serviceList);
		request.getRequestDispatcher("/admin/add_barber.jsp").forward(request, response);
	}
}
