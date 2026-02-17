package demo_barbershop.admin.customer;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.customer.Customer;
import demo_barbershop.customer.CustomerDAO;

@WebServlet("/admin/ListCustomerView")
public class ListCustomerView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public ListCustomerView() {
		super();
	}

	// handle request to display all customers
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// create object to access customer data
		CustomerDAO dao = new CustomerDAO();

		// get list of all customers from database
		ArrayList<Customer> customerList = dao.getAllCustomers();

		// store the customer list in request scope to send
		request.setAttribute("customers", customerList);

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		// forward request to view customer page to display customers
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/view_customer.jsp");
		dispatcher.forward(request, response);
	}
}
