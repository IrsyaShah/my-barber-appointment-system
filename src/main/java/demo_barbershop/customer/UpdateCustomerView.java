package demo_barbershop.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/customer/UpdateCustomerView")
public class UpdateCustomerView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public UpdateCustomerView() {
		super();
	}

	// handle request when customer update profile
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
		String fullName = request.getParameter("full_name");
		String phone_num = request.getParameter("phone_num");
		String address = request.getParameter("address");

		// update required fields
		c.setFullName(fullName);
		c.setPhoneNum(phone_num);

		// update address only if it is not empty
		if (address != null && !address.trim().isEmpty()) {
			c.setAddress(address);
		}

		// update customer profile in database using DAO
		CustomerDAO dao = new CustomerDAO();
		boolean updated = dao.UpdateCustomer(c);

		if (updated) {
			// update session object and redirect to view account page
			session.setAttribute("loggedInCustomer", c);
			request.setAttribute("acc_updated", "Account updated successfully!");
			request.getRequestDispatcher("edit_account.jsp").forward(request, response);
		}
	}
}
