package demo_barbershop.admin.appointment;

import java.util.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.sql.Date;
import javax.servlet.http.*;

import demo_barbershop.DBConnection;
import demo_barbershop.PasswordUtil;
import demo_barbershop.admin.barber.Barber;
import demo_barbershop.admin.barber.BarberService;
import demo_barbershop.admin.service.Service;
import demo_barbershop.admin.shift.Shift;

@SuppressWarnings("unused")
public class AppointmentDAO {

	// customer complete the appointment and get a receipt 
	public boolean insertReceipt(int appointmentId, String paymentName, double totalAmount) {
		boolean success = false;
		String sql = "INSERT INTO receipt (appointment_id, payment_name, total_amount, issued_date) VALUES (?, ?, ?, NOW())";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, appointmentId);
			ps.setString(2, paymentName);
			ps.setDouble(3, totalAmount);

			int rows = ps.executeUpdate();

			if (rows > 0) {
				String updateAppt = "UPDATE appointment SET status = 'Completed' WHERE appointment_id = ?";
				try (java.sql.PreparedStatement ps2 = conn.prepareStatement(updateAppt)) {
					ps2.setInt(1, appointmentId);
					ps2.executeUpdate();
				}
				success = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return success;
	}

	// update appointment status
	public boolean updateAppointmentStatus(int appointmentId, String status) {
		boolean updated = false;
		String sql = "UPDATE appointment SET status = ? WHERE appointment_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, appointmentId);
			updated = ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updated;
	}

	// list all appointment service
	public List<Service> getServicesForAppointment(int appointmentId) {
		List<Service> services = new ArrayList<>();
		String sql = "SELECT s.service_id, s.service_name, s.price " + "FROM service s "
				+ "JOIN appointment_service aps ON s.service_id = aps.service_id " + "WHERE aps.appointment_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, appointmentId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Service s = new Service();
				s.setServiceId(rs.getInt("service_id"));
				s.setServiceName(rs.getString("service_name"));
				s.setPrice(rs.getDouble("price"));
				services.add(s);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return services;
	}
    
	// display customer appointment for each selected barber
	public ArrayList<Appointment> getCustomerAppointment(int staffId) {
		String sql = "SELECT appt.appointment_id, appt.appointment_date, "
				+ "appt.appointment_start, appt.appointment_finish, " + "appt.remarks, appt.status, "
				+ "c.full_name AS customer_name, " + "s.service_id, s.service_name, s.price " + "FROM appointment appt "
				+ "JOIN customer c ON appt.customer_id = c.customer_id "
				+ "JOIN appointment_service aps ON appt.appointment_id = aps.appointment_id "
				+ "JOIN service s ON aps.service_id = s.service_id " + "WHERE appt.barber_id = ? "
				+ "ORDER BY appt.appointment_date DESC, appt.appointment_start DESC";

		Map<Integer, Appointment> map = new LinkedHashMap<>();

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, staffId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int apptId = rs.getInt("appointment_id");

				Appointment appt = map.get(apptId);
				if (appt == null) {
					appt = new Appointment();
					appt.setAppointmentId(apptId);
					appt.setCustomerName(rs.getString("customer_name"));
					appt.setAppointmentDate(rs.getDate("appointment_date").toLocalDate());
					appt.setAppointmentStart(rs.getTime("appointment_start").toLocalTime());
					appt.setAppointmentFinish(rs.getTime("appointment_finish").toLocalTime());
					appt.setRemarks(rs.getString("remarks"));
					appt.setStatus(rs.getString("status"));

					map.put(apptId, appt);
				}

				// Create and add service to the appointment's service list
				AppointmentService svc = new AppointmentService();
				svc.setServiceId(rs.getInt("service_id"));
				svc.setServiceName(rs.getString("service_name"));
				svc.setPrice(rs.getDouble("price"));

				appt.getServices().add(svc);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ArrayList<>(map.values());
	}
    
	// customer cancel the appointment
	public boolean cancelAppointment(int appointmentId, int customerId) {

		String sql = "UPDATE appointment " + "SET status = 'Cancelled' " + "WHERE appointment_id = ? "
				+ "AND customer_id = ? " + "AND status = 'Pending'";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, appointmentId);
			ps.setInt(2, customerId);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
    
	// display customer their own appointment
	public ArrayList<Appointment> getOwnAppointment(int customerId) {

		String sql = "SELECT appt.appointment_id, appt.appointment_date, "
				+ "appt.appointment_start, appt.appointment_finish, " + "appt.remarks, appt.status, "
				+ "s.service_id, s.service_name, s.price " + "FROM appointment appt "
				+ "JOIN appointment_service aps ON appt.appointment_id = aps.appointment_id "
				+ "JOIN service s ON aps.service_id = s.service_id " + "WHERE appt.customer_id = ? "
				+ "ORDER BY appt.appointment_date DESC, appt.appointment_start DESC";

		Map<Integer, Appointment> map = new LinkedHashMap<>();

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, customerId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int apptId = rs.getInt("appointment_id");

				Appointment appt = map.get(apptId);
				if (appt == null) {
					appt = new Appointment();
					appt.setAppointmentId(apptId);
					appt.setAppointmentDate(rs.getDate("appointment_date").toLocalDate());
					appt.setAppointmentStart(rs.getTime("appointment_start").toLocalTime());
					appt.setAppointmentFinish(rs.getTime("appointment_finish").toLocalTime());
					appt.setRemarks(rs.getString("remarks"));
					appt.setStatus(rs.getString("status"));

					map.put(apptId, appt);
				}

				AppointmentService svc = new AppointmentService();
				svc.setServiceId(rs.getInt("service_id"));
				svc.setServiceName(rs.getString("service_name"));
				svc.setPrice(rs.getDouble("price"));

				appt.getServices().add(svc);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ArrayList<>(map.values());
	}

	// check appointment exculde itself
	public boolean existBookTime(int appointmentId, int barberId, LocalDate date, LocalTime start, LocalTime finish) {

		String sql = "SELECT COUNT(*) FROM appointment " + "WHERE barber_id = ? " + "AND appointment_date = ? "
				+ "AND appointment_start < ? " + "AND appointment_finish > ? " + "AND appointment_id <> ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, barberId);
			ps.setDate(2, java.sql.Date.valueOf(date));
			ps.setTime(3, java.sql.Time.valueOf(finish));
			ps.setTime(4, java.sql.Time.valueOf(start));
			ps.setInt(5, appointmentId);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// get service id for an appointment
	public List<Integer> getAppointmentServiceIds(int appointmentId) {

		List<Integer> serviceIds = new ArrayList<>();

		String sql = "SELECT service_id FROM appointment_service WHERE appointment_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, appointmentId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				serviceIds.add(rs.getInt("service_id"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return serviceIds;
	}

	// update appointment and its services
	public boolean UpdateAppointment(Appointment appt, String[] serviceIds) {
		String updateAppointmentSql = "UPDATE appointment SET barber_id = ?, appointment_date = ?, appointment_start = ?, "
				+ "appointment_finish = ?, " + "remarks = ?, " + "status = ? " + "WHERE appointment_id = ?";

		String deleteServiceSql = "DELETE FROM appointment_service WHERE appointment_id = ?";

		String insertServiceSql = "INSERT INTO appointment_service (appointment_id, service_id) VALUES (?, ?)";

		Connection conn = null;

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);

			// UPDATE appointment
			PreparedStatement psUpdate = conn.prepareStatement(updateAppointmentSql);

			psUpdate.setInt(1, appt.getBarberId());

			if (appt.getAppointmentDate() != null) {
				psUpdate.setDate(2, Date.valueOf(appt.getAppointmentDate()));
			} else {
				psUpdate.setNull(2, Types.DATE);
			}

			if (appt.getAppointmentStart() != null) {
				psUpdate.setTime(3, Time.valueOf(appt.getAppointmentStart()));
			} else {
				psUpdate.setNull(3, Types.TIME);
			}

			if (appt.getAppointmentFinish() != null) {
				psUpdate.setTime(4, Time.valueOf(appt.getAppointmentFinish()));
			} else {
				psUpdate.setNull(4, Types.TIME);
			}

			psUpdate.setString(5, appt.getRemarks());
			psUpdate.setString(6, appt.getStatus());
			psUpdate.setInt(7, appt.getAppointmentId());

			int affected = psUpdate.executeUpdate();
			if (affected == 0) {
				conn.rollback();
				return false;
			}

			// DELETE old services
			PreparedStatement psDelete = conn.prepareStatement(deleteServiceSql);

			psDelete.setInt(1, appt.getAppointmentId());
			psDelete.executeUpdate();

			// INSERT new services
			if (serviceIds != null && serviceIds.length > 0) {

				PreparedStatement psInsert = conn.prepareStatement(insertServiceSql);

				for (String serviceIdStr : serviceIds) {
					int serviceId = Integer.parseInt(serviceIdStr);

					psInsert.setInt(1, appt.getAppointmentId());
					psInsert.setInt(2, serviceId);
					psInsert.addBatch();
				}

				psInsert.executeBatch();
			}

			conn.commit();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (conn != null)
					conn.rollback();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} finally {
			try {
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}

	// get appointment by id
	public Appointment getAppointmentById(int appointmentId) {
		Appointment appt = null;

		String sql = "SELECT appt.appointment_id, appt.customer_id, c.full_name AS customer_name, c.phone_num AS phone_number, "
				+ "appt.barber_id, b.full_name AS barber_name, appt.appointment_date, "
				+ "appt.appointment_start, appt.appointment_finish, appt.remarks, appt.status "
				+ "FROM appointment appt " + "JOIN customer c ON appt.customer_id = c.customer_id "
				+ "JOIN barber b ON appt.barber_id = b.barber_id " + "WHERE appt.appointment_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, appointmentId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				appt = new Appointment();
				appt.setAppointmentId(rs.getInt("appointment_id"));
				appt.setCustomerId(rs.getInt("customer_id"));
				appt.setCustomerName(rs.getString("customer_name"));
				appt.setPhoneNum(rs.getString("phone_number"));
				appt.setBarberId(rs.getInt("barber_id"));
				appt.setBarberName(rs.getString("barber_name"));
				appt.setAppointmentDate(rs.getDate("appointment_date").toLocalDate());
				appt.setAppointmentStart(rs.getTime("appointment_start").toLocalTime());
				appt.setAppointmentFinish(rs.getTime("appointment_finish").toLocalTime());
				appt.setRemarks(rs.getString("remarks"));
				appt.setStatus(rs.getString("status"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return appt;
	}

	// delete appointment details
	public boolean DeleteAppointment(int appointmentId) {
		String sql = "DELETE FROM appointment WHERE appointment_id = ?";

		// connect to database and execute query
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			// delete appointment data
			ps.setInt(1, appointmentId);
			int rows = ps.executeUpdate();

			return rows > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// get all appointment along with service
	public ArrayList<Appointment> getAllAppointments() {

		String sql = "SELECT appt.appointment_id, c.full_name AS customer_name, c.phone_num AS phone_number, b.barber_id, b.full_name AS barber_name, appt.appointment_date, appt.appointment_start, "
				+ "appt.appointment_finish, appt.remarks, s.service_id, s.service_name, s.price, appt.status "
				+ "FROM appointment appt " + "JOIN customer c ON appt.customer_id = c.customer_id "
				+ "JOIN barber b ON appt.barber_id = b.barber_id "
				+ "JOIN appointment_service appts ON appt.appointment_id = appts.appointment_id "
				+ "JOIN service s ON appts.service_id = s.service_id "
				+ "ORDER BY appt.appointment_date DESC, appt.appointment_start DESC";

		Map<Integer, Appointment> appointmentMap = new LinkedHashMap<>();

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				int appointmentId = rs.getInt("appointment_id");

				Appointment appt = appointmentMap.get(appointmentId);
				if (appt == null) {
					appt = new Appointment();

					appt.setAppointmentId(appointmentId);
					appt.setCustomerName(rs.getString("customer_name"));
					appt.setPhoneNum(rs.getString("phone_number"));
					appt.setBarberId(rs.getInt("barber_id"));
					appt.setBarberName(rs.getString("barber_name"));
					appt.setAppointmentDate(rs.getDate("appointment_date").toLocalDate());
					appt.setAppointmentStart(rs.getTime("appointment_start").toLocalTime());
					appt.setAppointmentFinish(rs.getTime("appointment_finish").toLocalTime());
					appt.setRemarks(rs.getString("remarks"));
					appt.setStatus(rs.getString("status"));

					appointmentMap.put(appointmentId, appt);
				}

				AppointmentService appts = new AppointmentService();
				appts.setAppointmentId(appointmentId);
				appts.setServiceId(rs.getInt("service_id"));
				appts.setServiceName(rs.getString("service_name"));
				appts.setPrice(rs.getDouble("price"));

				appt.getServices().add(appts);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ArrayList<>(appointmentMap.values());
	}

	// check available date
	public List<String[]> getBarberShifts(int barberId, String dayName) {
		List<String[]> shifts = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(
						"SELECT shift_start, shift_finish FROM shift WHERE barber_id = ? AND day_name = ?")) {
			ps.setInt(1, barberId);
			ps.setString(2, dayName);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				shifts.add(new String[] { rs.getString("shift_start"), rs.getString("shift_finish") });
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return shifts;
	}

	// check exist time for that day
	public boolean existTime(int barberId, LocalDate date, LocalTime start, LocalTime finish) {
		String sql = "SELECT COUNT(*) FROM appointment " + "WHERE barber_id = ? AND appointment_date = ? "
				+ "AND ((appointment_start < ? AND appointment_finish > ?) "
				+ "OR (appointment_start >= ? AND appointment_start < ?))";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, barberId);
			ps.setDate(2, java.sql.Date.valueOf(date));
			ps.setTime(3, java.sql.Time.valueOf(finish));
			ps.setTime(4, java.sql.Time.valueOf(start));
			ps.setTime(5, java.sql.Time.valueOf(start));
			ps.setTime(6, java.sql.Time.valueOf(finish));

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// make a new appointment and assign selected service to the appointment
	public boolean AddAppointment(Appointment appt, String[] serviceIds) {
		String insertAppointmentSql = "INSERT INTO appointment "
				+ "(customer_id, barber_id, appointment_date, appointment_start, appointment_finish, remarks, status) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

		String insertAppointmentServiceSql = "INSERT INTO appointment_service (appointment_id, service_id) VALUES (?, ?)";

		Connection conn = null;

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);

			// 1️⃣ Insert appointment
			PreparedStatement psAppt = conn.prepareStatement(insertAppointmentSql, Statement.RETURN_GENERATED_KEYS);

			psAppt.setInt(1, appt.getCustomerId());
			psAppt.setInt(2, appt.getBarberId());
			psAppt.setDate(3, Date.valueOf(appt.getAppointmentDate()));
			psAppt.setTime(4, Time.valueOf(appt.getAppointmentStart()));
			psAppt.setTime(5, Time.valueOf(appt.getAppointmentFinish()));
			psAppt.setString(6, appt.getRemarks());
			psAppt.setString(7, appt.getStatus());

			int affected = psAppt.executeUpdate();
			if (affected == 0) {
				conn.rollback();
				return false;
			}

			// Get generated appointment_id
			int appointmentId;
			ResultSet rs = psAppt.getGeneratedKeys();
			if (rs.next()) {
				appointmentId = rs.getInt(1);
			} else {
				conn.rollback();
				return false;
			}

			// Insert appointment_service
			PreparedStatement psService = conn.prepareStatement(insertAppointmentServiceSql);

			for (String serviceIdStr : serviceIds) {
				int serviceId = Integer.parseInt(serviceIdStr);

				psService.setInt(1, appointmentId);
				psService.setInt(2, serviceId);
				psService.addBatch();
			}

			psService.executeBatch();

			// COMMIT
			conn.commit();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (conn != null)
					conn.rollback();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} finally {
			try {
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}
    
	// create a new appointment by admin
	public boolean NewAppointment(String fullName, String phoneNum, Appointment appt, String[] serviceIds) {

		String insertCustomerSql = "INSERT INTO customer (full_name, phone_num) VALUES (?, ?)";

		String insertAppointmentSql = "INSERT INTO appointment "
				+ "(customer_id, barber_id, appointment_date, appointment_start, appointment_finish, remarks, status) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

		String insertAppointmentServiceSql = "INSERT INTO appointment_service (appointment_id, service_id) VALUES (?, ?)";

		Connection conn = null;

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);

			// INSERT CUSTOMER
			PreparedStatement psCustomer = conn.prepareStatement(insertCustomerSql, Statement.RETURN_GENERATED_KEYS);

			psCustomer.setString(1, fullName);
			psCustomer.setString(2, phoneNum);

			psCustomer.executeUpdate();

			ResultSet rsCustomer = psCustomer.getGeneratedKeys();
			if (!rsCustomer.next()) {
				conn.rollback();
				return false;
			}

			int customerId = rsCustomer.getInt(1);

			// INSERT APPOINTMENT
			PreparedStatement psAppt = conn.prepareStatement(insertAppointmentSql, Statement.RETURN_GENERATED_KEYS);

			psAppt.setInt(1, customerId);
			psAppt.setInt(2, appt.getBarberId());
			psAppt.setDate(3, Date.valueOf(appt.getAppointmentDate()));
			psAppt.setTime(4, Time.valueOf(appt.getAppointmentStart()));
			psAppt.setTime(5, Time.valueOf(appt.getAppointmentFinish()));
			psAppt.setString(6, appt.getRemarks());
			psAppt.setString(7, appt.getStatus());

			psAppt.executeUpdate();

			ResultSet rsAppt = psAppt.getGeneratedKeys();
			if (!rsAppt.next()) {
				conn.rollback();
				return false;
			}

			int appointmentId = rsAppt.getInt(1);

			// INSERT SERVICES
			PreparedStatement psService = conn.prepareStatement(insertAppointmentServiceSql);

			for (String serviceIdStr : serviceIds) {
				psService.setInt(1, appointmentId);
				psService.setInt(2, Integer.parseInt(serviceIdStr));
				psService.addBatch();
			}

			psService.executeBatch();

			// COMMIT
			conn.commit();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (conn != null)
					conn.rollback();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} finally {
			try {
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}
}
