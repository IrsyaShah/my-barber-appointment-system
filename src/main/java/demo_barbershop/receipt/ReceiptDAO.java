package demo_barbershop.receipt;

import java.sql.*;
import java.util.*;

import demo_barbershop.DBConnection;
import demo_barbershop.admin.appointment.AppointmentService;

public class ReceiptDAO {

	// display the receipt
	public Receipt getReceiptByAppointmentId(int appointmentId) {
		Receipt r = null;
		String sql = "SELECT r.receipt_id, r.appointment_id, r.payment_name, r.total_amount, r.issued_date, "
				+ "a.appointment_date, a.appointment_start, a.appointment_finish, a.remarks, "
				+ "c.full_name AS customer_name, b.full_name AS barber_name, b.phone_num AS barber_phone "
				+ "FROM receipt r " + "JOIN appointment a ON r.appointment_id = a.appointment_id "
				+ "JOIN customer c ON a.customer_id = c.customer_id " + "JOIN barber b ON a.barber_id = b.barber_id "
				+ "WHERE r.appointment_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, appointmentId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				r = new Receipt();
				r.setReceiptId(rs.getInt("receipt_id"));
				r.setPaymentName(rs.getString("payment_name"));
				r.setTotalAmount(rs.getDouble("total_amount"));
				r.setIssuedDate(rs.getTimestamp("issued_date"));
				r.setCustomerName(rs.getString("customer_name"));
				r.setBarberName(rs.getString("barber_name"));
				r.setBarberPhone(rs.getString("barber_phone"));
				r.setAppointmentDate(rs.getDate("appointment_date").toLocalDate());
				r.setStartTime(rs.getTime("appointment_start").toLocalTime());
				r.setFinishTime(rs.getTime("appointment_finish").toLocalTime());
				r.setRemarks(rs.getString("remarks"));

				// Get Services for this appointment
				r.setServices(getServicesForAppointment(appointmentId));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return r;
	}

	// Helper method to get services
	public List<AppointmentService> getServicesForAppointment(int appointmentId) {
		List<AppointmentService> services = new ArrayList<>();
		String sql = "SELECT s.service_name, s.price FROM service s "
				+ "JOIN appointment_service aserv ON s.service_id = aserv.service_id "
				+ "WHERE aserv.appointment_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, appointmentId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				AppointmentService as = new AppointmentService();
				as.setServiceName(rs.getString("service_name"));
				as.setPrice(rs.getDouble("price"));
				services.add(as);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return services;
	}
}
