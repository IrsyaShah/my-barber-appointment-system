package demo_barbershop.admin;

import java.sql.*;
import java.util.*;

import demo_barbershop.DBConnection;
import demo_barbershop.PasswordUtil;

@SuppressWarnings("unused")
public class AdminDAO {

	// retrieve pending appointment
	public int getPendingCount() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM appointment WHERE status = 'Pending'";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
    
	// display result in graph and chart for admin dashboard
	public Map<String, Object> getDashboardStats() {
		Map<String, Object> stats = new HashMap<>();
		try (Connection conn = DBConnection.getConnection()) {
			// Total Revenue
			PreparedStatement ps1 = conn.prepareStatement("SELECT SUM(total_amount) FROM receipt");
			ResultSet rs1 = ps1.executeQuery();
			stats.put("totalRevenue", rs1.next() ? rs1.getDouble(1) : 0.0);

			// Active Barbers
			PreparedStatement ps2 = conn.prepareStatement("SELECT COUNT(*) FROM barber WHERE status = 'active'");
			ResultSet rs2 = ps2.executeQuery();
			stats.put("activeBarbers", rs2.next() ? rs2.getInt(1) : 0);

			// Completed Appointments
			PreparedStatement ps3 = conn
					.prepareStatement("SELECT COUNT(*) FROM appointment WHERE status = 'Completed'");
			ResultSet rs3 = ps3.executeQuery();
			stats.put("completedAppts", rs3.next() ? rs3.getInt(1) : 0);

			// Most Popular Service Name
			PreparedStatement ps4 = conn.prepareStatement(
					"SELECT s.service_name FROM service s " +
					"JOIN appointment_service aserv ON s.service_id = aserv.service_id " +
					"JOIN appointment a ON aserv.appointment_id = a.appointment_id " + 
					"WHERE a.status = 'Completed' " + 
					"GROUP BY s.service_id ORDER BY COUNT(*) DESC LIMIT 1");
			ResultSet rs4 = ps4.executeQuery();
			stats.put("popularService", rs4.next() ? rs4.getString(1) : "None");

			// Total Haircuts 
			PreparedStatement ps5 = conn.prepareStatement(
					"SELECT COUNT(*) FROM appointment_service aserv JOIN appointment a ON aserv.appointment_id = a.appointment_id WHERE a.status = 'Completed'");
			ResultSet rs5 = ps5.executeQuery();
			stats.put("totalHaircuts", rs5.next() ? rs5.getInt(1) : 0);

			// Monthly Appointments 
			PreparedStatement ps6 = conn.prepareStatement(
					"SELECT COUNT(*) FROM appointment " +
					"WHERE MONTH(appointment_date) = MONTH(CURDATE()) " +
					"AND YEAR(appointment_date) = YEAR(CURDATE()) " +
					"AND status = 'Completed'");
			ResultSet rs6 = ps6.executeQuery();
			stats.put("monthlyAppointments", rs6.next() ? rs6.getInt(1) : 0);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return stats;
	}
    
	// display monthly appointment in vertical bar chart 
	public List<Integer> getMonthlyAppointmentCounts() {
		List<Integer> counts = new ArrayList<>(Collections.nCopies(12, 0));

		String sql = "SELECT MONTH(appointment_date) as month, COUNT(*) as count " + "FROM appointment "
				+ "WHERE YEAR(appointment_date) = YEAR(CURDATE()) AND status = 'Completed' "
				+ "GROUP BY month";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				counts.set(rs.getInt("month") - 1, rs.getInt("count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return counts;
	}
    
	// display service distribution in pie chart
	public Map<String, Integer> getServiceDistribution() {
		Map<String, Integer> data = new LinkedHashMap<>();
		String sql = "SELECT s.service_name, COUNT(aserv.service_id) as count " + "FROM service s "
				+ "JOIN appointment_service aserv ON s.service_id = aserv.service_id "
				+ "JOIN appointment a ON aserv.appointment_id = a.appointment_id " + "WHERE a.status = 'Completed' "
				+ "GROUP BY s.service_id " + "ORDER BY count DESC LIMIT 5";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				data.put(rs.getString("service_name"), rs.getInt("count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Fallback, if no data last month, show empty but initialized
		if (data.isEmpty())
			data.put("No Data", 0);

		return data;
	}
    
	// display sell overview in horizontal bar chart
	public List<Map<String, Object>> getSellOverview() {
		List<Map<String, Object>> list = new ArrayList<>();
		String sql = "SELECT s.service_name, COUNT(aserv.service_id) as total_sold, SUM(s.price) as total_revenue "
				+ "FROM service s " + "JOIN appointment_service aserv ON s.service_id = aserv.service_id "
				+ "JOIN appointment a ON aserv.appointment_id = a.appointment_id "
				+ "WHERE a.status = 'Completed' AND YEAR(a.appointment_date) = YEAR(CURDATE()) "
				+ "GROUP BY s.service_id " + "ORDER BY total_sold DESC LIMIT 6";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("name", rs.getString("service_name"));
				map.put("sold", rs.getInt("total_sold"));
				map.put("revenue", rs.getDouble("total_revenue"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
    
	// display total status for each appointment 
	public Map<String, Integer> getAppointmentStatusCounts() {
		Map<String, Integer> counts = new HashMap<>();
		counts.put("Pending", 0);
		counts.put("Confirmed", 0);
		counts.put("Completed", 0);
		counts.put("Cancelled", 0);

		String sql = "SELECT status, COUNT(*) as total FROM appointment GROUP BY status";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				counts.put(rs.getString("status"), rs.getInt("total"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return counts;
	}

	// display recent appointments 
	public List<Map<String, Object>> getRecentAppointments() {
		List<Map<String, Object>> list = new ArrayList<>();
		String sql = "SELECT a.appointment_date, a.appointment_start, a.status, "
				+ "c.full_name as customer_name, b.full_name as barber_name " + "FROM appointment a "
				+ "JOIN customer c ON a.customer_id = c.customer_id " + "JOIN barber b ON a.barber_id = b.barber_id "
				+ "ORDER BY a.appointment_date DESC, a.appointment_start DESC LIMIT 5";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("date", rs.getDate("appointment_date"));
				map.put("time", rs.getTime("appointment_start"));
				map.put("status", rs.getString("status"));
				map.put("customer", rs.getString("customer_name"));
				map.put("barber", rs.getString("barber_name"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
