package demo_barbershop.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.appointment.AppointmentDAO;

@WebServlet("/customer/CancelAppointmentView")
public class CancelAppointmentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CancelAppointmentView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Get the session and the logged-in customer object
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedInCustomer");

		// Ensure user is logged in
		if (customer == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		// Get the Appointment ID from the request parameter
		String appointmentIdStr = request.getParameter("appointment_id");

		if (appointmentIdStr != null && !appointmentIdStr.isEmpty()) {
			try {
				int appointmentId = Integer.parseInt(appointmentIdStr);
				int customerId = customer.getCustomerId(); // Get ID from session object

				// Call DAO to perform update
				AppointmentDAO dao = new AppointmentDAO();
				boolean success = dao.cancelAppointment(appointmentId, customerId);

				// Provide feedback
				if (success) {
					session.setAttribute("appointment_cancel", "Appointment cancelled successfully!");
				} else {
					session.setAttribute("appointment_error", "Failed to cancel appointment!");
				}

			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		// Redirect back to the appointment list page
		response.sendRedirect(request.getContextPath() + "/customer/AppointmentView");
	}
}
