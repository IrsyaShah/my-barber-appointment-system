package demo_barbershop.admin.shift;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/DeleteShiftView")
public class DeleteShiftView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public DeleteShiftView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int shiftId = Integer.parseInt(request.getParameter("shift_id"));

		// use DAO to delete data in database
		ShiftDAO dao = new ShiftDAO();

		// get session object
		HttpSession session = request.getSession();
		
	    // block from delete if shift has pending/confirmed appointments
	    boolean hasActiveAppt = dao.hasAppointments(shiftId);
	    if (hasActiveAppt) {
	        session.setAttribute("shift_error", "This barber still has appointments for this shift.");
	        response.sendRedirect(request.getContextPath() + "/admin/ListShiftView");
	        return;
	    }
	    
		boolean deleted = dao.DeleteShift(shiftId);

		if (deleted) {

			// delete data and redirect to manage shift with success message
			session.setAttribute("shift_deleted", "Shift deleted successfully!");
		} else {
			session.setAttribute("shift_error", "Failed to delete shift!");
		}

		response.sendRedirect(request.getContextPath() + "/admin/ListShiftView");
	}
}
