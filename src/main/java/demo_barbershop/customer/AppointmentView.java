package demo_barbershop.customer;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.admin.appointment.Appointment;
import demo_barbershop.admin.appointment.AppointmentDAO;

@WebServlet("/customer/AppointmentView")
public class AppointmentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public AppointmentView() {
		super();
	}

	// handle request to display customers own appointment
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Customer customer = (Customer) session.getAttribute("loggedInCustomer");

		if (customer == null) {
			response.sendRedirect("../login.jsp");
			return;
		}

		int customerId = customer.getCustomerId();

		AppointmentDAO dao = new AppointmentDAO();

		// ONLY get this customer's appointments
		ArrayList<Appointment> apptList = dao.getOwnAppointment(customerId);

		request.setAttribute("appointmentList", apptList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/view_appointment.jsp");
		dispatcher.forward(request, response);
	}
}
