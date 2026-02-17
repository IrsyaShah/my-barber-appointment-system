package demo_barbershop.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/customer/LoginCustomerView")
public class LoginCustomerView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public LoginCustomerView() {
		super();
	}

	// handle request when customer submit login form
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get email and password entered by user
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		// redirect to specific page after login
		String redirectURL = request.getParameter("redirect");

		// Check login credentials using DAO
		CustomerDAO dao = new CustomerDAO();

		// returns customer object if login successful
		Customer c = dao.login(email, password);

		// if login is successful
		if (c != null) {

			// create session and store login customer object
			HttpSession session = request.getSession();
			session.setAttribute("loggedInCustomer", c);

			// set session 20 minutes
			session.setMaxInactiveInterval(1200);

			// redirect user to the book appointment page or homepage
			if (redirectURL != null && !redirectURL.isEmpty()) {
				response.sendRedirect(redirectURL);
			} else {
				response.sendRedirect("../index.jsp");
			}
		} else {
			// redirect back to login page with error message
			request.getSession().setAttribute("invalid", "Invalid email or password");
			response.sendRedirect("../login.jsp");
		}
	}
}
