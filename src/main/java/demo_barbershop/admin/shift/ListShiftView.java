package demo_barbershop.admin.shift;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;

@WebServlet("/admin/ListShiftView")
public class ListShiftView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public ListShiftView() {
		super();
	}

	// handle request to display all shifts
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// create object to access shift data
		ShiftDAO dao = new ShiftDAO();

		// get list of all shifts from database
		ArrayList<Shift> shiftList = dao.getAllShifts();

		// store the shift list in request scope to send
		request.setAttribute("shifts", shiftList);

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		// forward request to manage shift page to display shifts
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/manage_shift.jsp");
		dispatcher.forward(request, response);
	}
}
