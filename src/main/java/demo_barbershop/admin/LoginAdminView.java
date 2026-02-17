package demo_barbershop.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/LoginAdminView")
public class LoginAdminView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Hardcoded credentials
	private static final Admin ADMIN = new Admin("admin", "admin123", "Administrator");

	public LoginAdminView() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usernameInput = request.getParameter("username");
		String passwordInput = request.getParameter("password");

		// Compare input against our hardcoded Admin object
		if (ADMIN.getUsername().equals(usernameInput) && ADMIN.getPassword().equals(passwordInput)) {

			HttpSession session = request.getSession();

			// set session 20 minutes
			session.setMaxInactiveInterval(1200);

			// Store the whole OBJECT in the session
			session.setAttribute("loggedInAdmin", ADMIN);

			response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardView");
		} else {
			response.sendRedirect("index.jsp?error=invalid");
		}
	}
}
