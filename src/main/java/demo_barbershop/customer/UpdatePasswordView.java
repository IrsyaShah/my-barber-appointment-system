package demo_barbershop.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.PasswordUtil;

@WebServlet("/customer/UpdatePasswordView")
public class UpdatePasswordView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public UpdatePasswordView() {
		super();
	}

	// handle request when customer change password
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get current session
		HttpSession session = request.getSession();
		Customer c = (Customer) session.getAttribute("loggedInCustomer");

		// Ensure user is logged in
		if (c == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		// get updated input from form
		String currentPassword = request.getParameter("current_password");
		String newPassword = request.getParameter("password");
		String confirmPassword = request.getParameter("confirm_password");

		// password at least 8 characters one special character
		String passwordPattern = "^(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?]).{8,}$";

		// if password is weak redirect with error message
		if (newPassword == null || !newPassword.matches(passwordPattern)) {
			request.setAttribute("weak_password", "Password must be at least 8 characters.");
			request.getRequestDispatcher("edit_account.jsp").forward(request, response);
			return;
		}

		// hash the current password entered by customer
		String hashedCurrentPassword = PasswordUtil.hashPassword(currentPassword);

		// if current password matches with database
		if (!c.getPassword().equals(hashedCurrentPassword)) {
			request.setAttribute("current_mismatch", "Current password is not correct.");
			request.getRequestDispatcher("edit_account.jsp").forward(request, response);
			return;
		}

		// if new password and confirm password do not match redirect with error message
		if (!newPassword.equals(confirmPassword)) {
			request.setAttribute("password_mismatch", "Passwords do not match.");
			request.getRequestDispatcher("edit_account.jsp").forward(request, response);
			return;
		}

		// hash new password
		c.setPassword(PasswordUtil.hashPassword(newPassword));

		// update password in database using DAO
		CustomerDAO dao = new CustomerDAO();
		boolean success = dao.UpdatePassword(c.getCustomerId(), newPassword);

		if (success) {
			// update session object and redirect to login page
			session.setAttribute("loggedInCustomer", c);
			request.setAttribute("pass_updated", "Password updated successfully!");
			request.getRequestDispatcher("edit_account.jsp").forward(request, response);
		}
	}
}
