package demo_barbershop.admin.barber;

import java.util.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.admin.service.ServiceDAO;

@WebServlet("/admin/UpdateBarberView")
public class UpdateBarberView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public UpdateBarberView() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get updated input from form
		int barberId = Integer.parseInt(request.getParameter("barber_id"));
		String fullname = request.getParameter("full_name");
		String email = request.getParameter("email");
		String phone_num = request.getParameter("phone_num");
		String address = request.getParameter("address");
		String status = request.getParameter("status");

		// update required fields
		Barber b = new Barber();
		b.setBarberId(barberId);
		b.setFullName(fullname);
		b.setEmail(email);
		b.setPhoneNum(phone_num);
		b.setAddress(address);
		b.setStatus(status);

		BarberDAO dao = new BarberDAO();
		String[] serviceIds = request.getParameterValues("serviceIds");

		// check email conflict
		if (dao.ExistsEmail(email, barberId)) {
			// Email exists for another barber
			request.setAttribute("getbarber", b);
			ServiceDAO serviceDAO = new ServiceDAO();
			request.setAttribute("serviceList", serviceDAO.getAllServices());

			// redirect back with error message
			Map<Integer, String> assignService = new HashMap<>();
			if (serviceIds != null) {
				for (String sid : serviceIds) {
					int id = Integer.parseInt(sid);
					assignService.put(id, request.getParameter("skillLevel_" + id));
				}
			}
			request.setAttribute("assignService", assignService);
			request.setAttribute("email_exists", "Email already exists!");
			request.getRequestDispatcher("edit_barber.jsp").forward(request, response);
			return;
		}

		boolean updated = dao.UpdateBarber(b, serviceIds, request);

		if (updated) {

			// get session object
			HttpSession session = request.getSession();

			// update data and redirect to manage barber with success message
			session.setAttribute("barber_updated", "Barber updated successfully!");
			response.sendRedirect(request.getContextPath() + "/admin/ListBarberView");
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);
	}
}
