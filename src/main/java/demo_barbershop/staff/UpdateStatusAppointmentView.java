package demo_barbershop.staff;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.appointment.AppointmentDAO;

@WebServlet("/staff/UpdateStatusAppointmentView")
public class UpdateStatusAppointmentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public UpdateStatusAppointmentView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));
		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		AppointmentDAO dao = new AppointmentDAO();

		// Check if the user clicked the direct confirm button
		if ("confirm".equals(action)) {

			boolean updated = dao.updateAppointmentStatus(appointmentId, "Confirmed");

			if (updated) {
				session.setAttribute("status_updated", "Appointment confirmed successfully!");
			} else {
				session.setAttribute("status_error", "Failed to confirm appointment.");
			}

			// Redirect back to the main list
			response.sendRedirect(request.getContextPath() + "/staff/CustomerAppointmentView");

		}
	}
}
