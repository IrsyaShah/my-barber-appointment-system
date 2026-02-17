package demo_barbershop.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RegisterCustomerView")
public class RegisterCustomerView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public RegisterCustomerView() {
		super();
	}

	// handle request when customer submit registration form
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get customer input from registration form
		String fullName = request.getParameter("full_name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirm_password");
		String phone_num = request.getParameter("phone_num");
		String address = request.getParameter("address");

		// password at least 8 characters one special character
		String passwordPattern = "^(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?]).{8,}$";

		// if password is weak redirect with error message
		if (password == null || !password.matches(passwordPattern)) {
			request.setAttribute("weak_password", "Password must be at least 8 characters.");
			request.getRequestDispatcher("register.jsp").forward(request, response);
			return;
		}

		// if password and confirm password do not match redirect with error message
		if (!password.equals(confirmPassword)) {
			request.setAttribute("password_mismatch", "Passwords do not match.");
			request.getRequestDispatcher("register.jsp").forward(request, response);
			return;
		}

		// create new customer object
		Customer c = new Customer(0, fullName, email, password, phone_num, address);

		// use DAO to register account in database
		CustomerDAO dao = new CustomerDAO();
		boolean success = dao.RegisterAccount(c);

		if (success) {

			// get session object
			HttpSession session = request.getSession();

			// if registration successful redirect to login page
			session.setAttribute("acc_created", "Account created successfully!");
			response.sendRedirect("login.jsp");
		} else {
			// if registration fails redirect with error message
			request.setAttribute("email_exists", "Email already exists. Please use different email.");
			request.getRequestDispatcher("register.jsp").forward(request, response);
		}
	}
}
