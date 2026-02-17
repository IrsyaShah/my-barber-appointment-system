package demo_barbershop.staff;

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

@WebServlet("/staff/CustomerAppointmentView")
public class CustomerAppointmentView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public CustomerAppointmentView() {
		super();
	}

	// handle request to display customers appointment
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		Staff s = (Staff) session.getAttribute("loggedInStaff");

		if (s == null) {
			response.sendRedirect("../login.jsp");
			return;
		}

		int staffId = s.getStaffId();

		AppointmentDAO dao = new AppointmentDAO();

		// only get this staff's appointments
		ArrayList<Appointment> apptList = dao.getCustomerAppointment(staffId);

		StaffDAO staffDAO = new StaffDAO();

		int count = staffDAO.getPendingCountByBarber(s.getStaffId());

		// Set only the count attribute
		request.setAttribute("pendingCount", count);

		request.setAttribute("appointmentList", apptList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/staff/view_appointment.jsp");
		dispatcher.forward(request, response);
	}
}
