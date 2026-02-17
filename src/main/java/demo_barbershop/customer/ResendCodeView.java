package demo_barbershop.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpSession;

@WebServlet("/ResendCodeView")
public class ResendCodeView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// email account and app password to send reset code
	private static final String FROM_EMAIL = "keraitbarbershop@gmail.com";
	private static final String APP_PASSWORD = "uwxd xdte tafq sjsy";

	// constructor
	public ResendCodeView() {
		super();
	}

	// handle GET request when customer click resent code
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// get the current session
		HttpSession session = request.getSession();

		// retrieve email from session
		String email = (String) session.getAttribute("getemail");

		// if session expired or email not found redirect with error
		if (email == null) {
			request.setAttribute("session_expired", "Email not found. Please try again.");
			request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
			return;
		}

		// generate a new random 6 digit for password reset
		Random rand = new Random();
		int code = 100000 + rand.nextInt(900000);

		// store new code and current time in session
		session.setAttribute("getcode", code);
		session.setAttribute("gettime", System.currentTimeMillis());

		try {
			// configure email server properties
			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");

			// create a mail session with authentication
			Session mailSession = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
				}
			});

			// compose the email message
			Message message = new MimeMessage(mailSession);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("Password Reset");
			message.setText("Your password reset code is: " + code + "\n\nThis code will expire in 5 minutes."
					+ "\nIf you did not request this, please ignore the email.");

			// send the email
			Transport.send(message);

			// redirect back to forgot password page with success message
			request.setAttribute("resent_code", "A new verfication code has been sent to your email.");
			request.setAttribute("email", email);
			request.getRequestDispatcher("forgot_password.jsp").forward(request, response);

		} catch (MessagingException e) {
			e.printStackTrace();

			// if sending fails redirect with error message
			request.setAttribute("send_fail", "Failed to send code. Please try again.");
			request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
		}
	}
}
