package demo_barbershop.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ResetPasswordView")
public class ResetPasswordView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public ResetPasswordView() {
		super();
	}

	// handle request when customer submits new password
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get reset code and new password from form
		String code = request.getParameter("code");
		String newPassword = request.getParameter("password");
		String confirmPassword = request.getParameter("confirm_password");

		// store the reset code and email in session
		HttpSession session = request.getSession();
		Object sessionCode = session.getAttribute("getcode");
		String email = (String) session.getAttribute("getemail");

		// time code was generated
		Long time = (Long) session.getAttribute("gettime");
		long now = System.currentTimeMillis();

		// check if code has expired in 5 minutes
		if (time == null || now - time > 5 * 60 * 1000) {
			// remove session if expired
			session.removeAttribute("getemail");
			session.removeAttribute("getcode");
			session.removeAttribute("gettime");

			// redirect back forgot password page with error message
			request.setAttribute("expired_code", "Code has expired. Please request a new one.");
			request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
			return;
		}

		// password at least 8 characters one special character
		String passwordPattern = "^(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?]).{8,}$";

		// if password is weak redirect with error message
		if (newPassword == null || !newPassword.matches(passwordPattern)) {
			request.setAttribute("weak_password", "Password must be at least 8 characters.");
			request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
			return;
		}

		// if password and confirm password do not match redirect with error message
		if (!newPassword.equals(confirmPassword)) {
			request.setAttribute("password_mismatch", "Passwords do not match.");
			request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
			return;
		}

		// check if entered code matches the code in session
		if (code.equals(sessionCode.toString())) {

			// update password in database using DAO
			CustomerDAO dao = new CustomerDAO();
			dao.UpdateCustomerPassword(email, newPassword);

			// remove session after successful reset
			session.removeAttribute("getcode");
			session.removeAttribute("getemail");

			// get session object
			session = request.getSession();

			// if reset password successful redirect to login page
			session.setAttribute("change_pass", "Password reset successfully!");
			response.sendRedirect("login.jsp");
		} else {
			// if code is incorrect redirect with error message
			request.setAttribute("wrong_code", "Incorrect code entered. Please try again.");
			request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
		}
	}
}
