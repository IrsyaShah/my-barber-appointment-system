package demo_barbershop.staff;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/staff/LoginStaffView")
public class LoginStaffView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public LoginStaffView() {
		super();
	}

	// handle request when staff submit login form
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get staff id and password entered by staff
		String email = request.getParameter("email");
		String staffId = request.getParameter("staffId");

		// Check login credentials using DAO
		StaffDAO dao = new StaffDAO();

		// returns staff object if login successful
		Staff s = dao.login(email, staffId);

		// if login is successful
		if (s != null) {

			// create session and store login staff object
			HttpSession session = request.getSession();
			session.setAttribute("loggedInStaff", s);

			// set session 20 minutes
			session.setMaxInactiveInterval(1200);

			// redirect staff to the homepage
			response.sendRedirect(request.getContextPath() + "/staff/StaffDashboardView");

		} else {
			// redirect back to login page with error message
			request.getSession().setAttribute("invalid", "Invalid email or password");
			response.sendRedirect("../login.jsp");
		}
	}
}
