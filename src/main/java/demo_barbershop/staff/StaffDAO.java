package demo_barbershop.staff;

import java.sql.*;
import java.util.*;

import demo_barbershop.DBConnection;
import demo_barbershop.PasswordUtil;
import demo_barbershop.admin.appointment.Appointment;

@SuppressWarnings("unused")
public class StaffDAO {

	// display appointment date in calendar
	public Map<String, List<String>> getAppointmentDates(int barberId) {
		Map<String, List<String>> dateMap = new HashMap<>();
		dateMap.put("Pending", new ArrayList<>());
		dateMap.put("Confirmed", new ArrayList<>());
		dateMap.put("Completed", new ArrayList<>());

		String sql = "SELECT appointment_date, status FROM appointment WHERE barber_id = ? AND status IN ('Pending', 'Confirmed', 'Completed')";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				dateMap.get(rs.getString("status")).add(rs.getString("appointment_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dateMap;
	}
    
	// calculate complete total earning for the barber
	public double getTotalAllTimeEarnings(int barberId) {
		double total = 0;
		String sql = "SELECT SUM(r.total_amount) FROM receipt r "
				+ "JOIN appointment a ON r.appointment_id = a.appointment_id " + "WHERE a.barber_id = ? AND a.status = 'Completed'";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				total = rs.getDouble(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}
    
	// count pending and confirmed appointment for the barber
	public int getUpcomingCount(int barberId) {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM appointment WHERE barber_id = ? AND appointment_date >= CURRENT_DATE AND status IN ('Pending', 'Confirmed')";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
   
	// count total complete appointment for the barber
	public int getTotalBookings(int barberId) {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM appointment WHERE barber_id = ? AND status = 'Completed'";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// display popular service request from customer to the barber 
	public String getMostRequestedService(int barberId) {
		String serviceName = "None";
		String sql = "SELECT s.service_name, COUNT(aserv.service_id) AS count " + "FROM appointment_service aserv "
				+ "JOIN appointment a ON aserv.appointment_id = a.appointment_id "
				+ "JOIN service s ON aserv.service_id = s.service_id " + "WHERE a.barber_id = ? AND a.status = 'Completed' "
				+ "GROUP BY s.service_id ORDER BY count DESC LIMIT 1";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				serviceName = rs.getString("service_name");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return serviceName;
	}
    
	// display complete earning by year, month and day for the barber 
	public double getEarnings(int barberId, String period) {
		double earnings = 0;
		String dateFilter = "";
		if (period.equals("today"))
			dateFilter = "AND DATE(r.issued_date) = CURRENT_DATE";
		else if (period.equals("month"))
			dateFilter = "AND MONTH(r.issued_date) = MONTH(CURRENT_DATE) AND YEAR(r.issued_date) = YEAR(CURRENT_DATE)";
		else if (period.equals("year"))
			dateFilter = "AND YEAR(r.issued_date) = YEAR(CURRENT_DATE)";

		String sql = "SELECT SUM(r.total_amount) FROM receipt r "
				+ "JOIN appointment a ON r.appointment_id = a.appointment_id " + "WHERE a.barber_id = ? AND a.status = 'Completed' " + dateFilter;
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				earnings = rs.getDouble(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return earnings;
	}
    
	// display pending appointment notification for the barber
	public int getPendingCountByBarber(int barberId) {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM appointment WHERE barber_id = ? AND status = 'Pending'";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// login customer account
	public Staff login(String email, String staffId) {
		String sql = "SELECT * FROM barber WHERE email = ? AND barber_id = ? AND status = 'active'";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// hash input password for login comparison
			ps.setString(1, email);
			ps.setString(2, staffId);

			ResultSet rs = ps.executeQuery();

			// if login success return staff object
			if (rs.next()) {
				return new Staff(rs.getInt("barber_id"), rs.getString("full_name"), rs.getString("email"),
						rs.getString("phone_num"), rs.getString("address"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
