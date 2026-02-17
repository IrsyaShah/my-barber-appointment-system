package demo_barbershop.admin.shift;

import java.io.IOException;
import java.time.*;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo_barbershop.admin.AdminDAO;
import demo_barbershop.admin.barber.Barber;
import demo_barbershop.admin.barber.BarberDAO;

@WebServlet("/admin/AddShiftView")
public class AddShiftView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// constructor
	public AddShiftView() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		BarberDAO barberDAO = new BarberDAO();
		ShiftDAO shiftDAO = new ShiftDAO();

		if ("load".equals(action)) {
			// Load barber info to display working days
			int barberId = Integer.parseInt(request.getParameter("barberId"));

			List<String> workingDays = barberDAO.getBarberWorkingDays(barberId);
			List<Barber> barberList = barberDAO.getActiveBarber();

			request.setAttribute("barbers", barberList);
			request.setAttribute("workingDays", workingDays);
			request.setAttribute("selectedBarberId", String.valueOf(barberId));
			request.setAttribute("allDays",
					List.of("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"));

			request.getRequestDispatcher("add_shift.jsp").forward(request, response);
			return;
		} else if ("add".equals(action)) {
			// Insert the new shift
			int barberId = Integer.parseInt(request.getParameter("barberId"));
			String dayName = request.getParameter("day_name");
			LocalTime startTime = LocalTime.parse(request.getParameter("start_time"));
			LocalTime finishTime = LocalTime.parse(request.getParameter("finish_time"));

			Shift sh = new Shift(0, barberId, dayName, startTime, finishTime);

			if (shiftDAO.ExitsDay(barberId, dayName)) {
				List<String> workingDays = barberDAO.getBarberWorkingDays(barberId);
				List<Barber> barberList = barberDAO.getActiveBarber();

				request.setAttribute("barbers", barberList);
				request.setAttribute("workingDays", workingDays);
				request.setAttribute("selectedBarberId", String.valueOf(barberId));
				request.setAttribute("allDays",
						List.of("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"));

				request.setAttribute("day_exists", "This barber already has a shift on " + dayName);
				doGet(request, response);
				return;
			}

			boolean inserted = shiftDAO.AddShift(sh);

			if (inserted) {
				request.getSession().setAttribute("shift_added", "Shift added successfully!");
				response.sendRedirect(request.getContextPath() + "/admin/ListShiftView");
			} else {
				request.setAttribute("error", "Failed to add shift.");
				doGet(request, response);
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		BarberDAO barberDAO = new BarberDAO();
		List<Barber> barberList = barberDAO.getActiveBarber();

		AdminDAO adminDAO = new AdminDAO();
		int count = adminDAO.getPendingCount();

		request.setAttribute("pendingCount", count);

		request.setAttribute("barbers", barberList);
		request.getRequestDispatcher("add_shift.jsp").forward(request, response);
	}
}
