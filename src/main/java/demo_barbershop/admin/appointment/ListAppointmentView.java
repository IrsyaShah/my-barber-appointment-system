package demo_barbershop.admin.appointment;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;

@WebServlet("/admin/ListAppointmentView")
public class ListAppointmentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public ListAppointmentView() {
		super();
	}

	// handle request to display all appointment
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// create object to access appointment data
		AppointmentDAO dao = new AppointmentDAO();

		// get list of all appointment from database
		ArrayList<Appointment> appointmentList = dao.getAllAppointments();

		// store the service list in request scope to send
		request.setAttribute("appointments", appointmentList);

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		// forward request to manage appointment page to display appointment
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/manage_appointment.jsp");
		dispatcher.forward(request, response);
	}
}
