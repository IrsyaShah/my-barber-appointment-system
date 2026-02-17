package demo_barbershop.staff;

import java.util.List;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.appointment.Appointment;
import demo_barbershop.admin.appointment.AppointmentDAO;
import demo_barbershop.admin.service.Service;

@WebServlet("/staff/PaymentView")
public class PaymentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public PaymentView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));

		AppointmentDAO dao = new AppointmentDAO();
		Appointment appt = dao.getAppointmentById(appointmentId);
		List<Service> services = dao.getServicesForAppointment(appointmentId);

		// Calculate Total Amount
		double totalAmount = 0;
		for (Service s : services) {
			totalAmount += s.getPrice();
		}

		request.setAttribute("paymentAppt", appt);
		request.setAttribute("totalAmount", totalAmount);
		request.setAttribute("showPaymentModal", true);

		request.getRequestDispatcher("/staff/CustomerAppointmentView").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));
		double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
		String paymentMethod = request.getParameter("payment_method");

		AppointmentDAO dao = new AppointmentDAO();

		boolean success = dao.insertReceipt(appointmentId, paymentMethod, totalAmount);

		if (success) {
			request.getSession().setAttribute("payment_success", "Payment processed successfully!");
		} else {
			request.getSession().setAttribute("payment_error", "Payment failed!");
		}

		response.sendRedirect(request.getContextPath() + "/staff/CustomerAppointmentView");
	}
}
