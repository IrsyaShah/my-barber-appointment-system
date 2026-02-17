package demo_barbershop.admin.appointment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/DeleteAppointmentView")
public class DeleteAppointmentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public DeleteAppointmentView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));

		// use DAO to delete data in database
		AppointmentDAO dao = new AppointmentDAO();
		boolean deleted = dao.DeleteAppointment(appointmentId);

		if (deleted) {

			// get session object
			HttpSession session = request.getSession();

			// delete data and redirect to manage appointment with success message
			session.setAttribute("appointment_deleted", "Appointment deleted successfully!");
		} else {

			HttpSession session = request.getSession();
			session.setAttribute("appointment_error", "Failed to delete appointment!");
		}

		response.sendRedirect(request.getContextPath() + "/admin/ListAppointmentView");
	}
}
