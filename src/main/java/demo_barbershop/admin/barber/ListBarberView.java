package demo_barbershop.admin.barber;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;

@WebServlet("/admin/ListBarberView")
public class ListBarberView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public ListBarberView() {
		super();
	}

	// handle request to display all barbers
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// create object to access barber data
		BarberDAO dao = new BarberDAO();

		// get list of all barbers from database
		ArrayList<Barber> barberList = dao.getAllBarbers();

		// store the barbers list in request scope to send
		request.setAttribute("barbers", barberList);

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		// forward request to manage barber page to display barbers
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/manage_barber.jsp");
		dispatcher.forward(request, response);
	}
}
