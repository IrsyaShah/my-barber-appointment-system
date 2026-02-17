package demo_barbershop.admin.service;

import java.sql.*;
import java.util.ArrayList;

import demo_barbershop.DBConnection;

public class ServiceDAO {

	// get service by id
	public Service getServiceById(int serviceId) {
		Service s = null;

		try {
			// connect to database and execute query
			Connection con = DBConnection.getConnection();
			String sql = "SELECT * FROM service WHERE service_id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, serviceId);

			ResultSet rs = ps.executeQuery();

			// read data from database
			if (rs.next()) {
				s = new Service();
				s.setServiceId(rs.getInt("service_id"));
				s.setServiceName(rs.getString("service_name"));
				s.setPrice(rs.getDouble("price"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return s;
	}

	// get all service
	public ArrayList<Service> getAllServices() {
		String sql = "SELECT service_id, service_name, price FROM service";
		ArrayList<Service> services = new ArrayList<>();

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			// read each row from database
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

	// get all service for barber dropdown
	public ArrayList<Service> getService() {
		String sql = "SELECT service_id, service_name FROM service";
		ArrayList<Service> services = new ArrayList<>();

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			// read each row from database
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

	// add new service
	public boolean AddService(Service s) {
		String sql = "INSERT INTO service(service_name, price) VALUES (?, ?)";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// insert service data
			ps.setString(1, s.getServiceName());
			ps.setDouble(2, s.getPrice());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// update service details
	public boolean UpdateService(Service s) {
		String sql = "UPDATE service SET service_name = ?, price = ? WHERE service_id = ?";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// update service data
			ps.setString(1, s.getServiceName());
			ps.setDouble(2, s.getPrice());
			ps.setInt(3, s.getServiceId());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// delete service details
	public boolean DeleteService(int serviceId) {
		String sql = "DELETE FROM service WHERE service_id = ?";

		// connect to database and execute query
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			// delete service data
			ps.setInt(1, serviceId);
			int rows = ps.executeUpdate();

			return rows > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
}
