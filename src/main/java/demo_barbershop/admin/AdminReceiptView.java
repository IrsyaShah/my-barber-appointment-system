package demo_barbershop.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demo_barbershop.receipt.Receipt;
import demo_barbershop.receipt.ReceiptDAO;

@WebServlet("/admin/AdminReceiptView")
public class AdminReceiptView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminReceiptView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idParam = request.getParameter("id");

		if (idParam != null) {
			int appointmentId = Integer.parseInt(idParam);
			ReceiptDAO dao = new ReceiptDAO();
			Receipt receipt = dao.getReceiptByAppointmentId(appointmentId);

			if (receipt != null) {
				request.setAttribute("receipt", receipt);
				request.getRequestDispatcher("/admin/view_receipt.jsp").forward(request, response);
			} else {

				// get session object
				HttpSession session = request.getSession();

				session.setAttribute("receipt_error", "Receipt failed to display");
				response.sendRedirect(request.getContextPath() + "/admin/ListAppointmentView");
			}
		}
	}
}
