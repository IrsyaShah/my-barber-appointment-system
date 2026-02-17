package demo_barbershop.customer;

import java.sql.*;
import java.util.ArrayList;

import demo_barbershop.DBConnection;
import demo_barbershop.PasswordUtil;

public class CustomerDAO {

	// get all customer
	public ArrayList<Customer> getAllCustomers() {
		String sql = "SELECT full_name, email, phone_num, address FROM customer";
		ArrayList<Customer> customers = new ArrayList<>();

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			// read each row from database
			while (rs.next()) {
				Customer c = new Customer();
				c.setFullName(rs.getString("full_name"));
				c.setEmail(rs.getString("email"));
				c.setPhoneNum(rs.getString("phone_num"));
				c.setAddress(rs.getString("address"));

				customers.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return customers;
	}

	// get customer by email for forgot password
	public Customer GetEmail(String email) {
		String sql = "SELECT * FROM customer WHERE email = ?";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// set email parameter
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();

			// if email found return customer object
			if (rs.next()) {
				return new Customer(rs.getInt("customer_id"), rs.getString("full_name"), rs.getString("email"),
						rs.getString("password"), rs.getString("phone_num"), rs.getString("address"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// update password using email for forgot password
	public boolean UpdateCustomerPassword(String email, String newPassword) {
		String sql = "UPDATE customer SET password = ? WHERE email = ?";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// hash password before saving
			ps.setString(1, PasswordUtil.hashPassword(newPassword));
			ps.setString(2, email);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// update password by customer id
	public boolean UpdatePassword(int customerId, String newPassword) {
		String sql = "UPDATE customer SET password = ? WHERE customer_id = ?";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// hash password before saving
			ps.setString(1, PasswordUtil.hashPassword(newPassword));
			ps.setInt(2, customerId);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// update customer profile details
	public boolean UpdateCustomer(Customer c) {
		String sql = "UPDATE customer SET full_name = ?, phone_num = ?, address = ? WHERE customer_id = ?";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// update customer data
			ps.setString(1, c.getFullName());
			ps.setString(2, c.getPhoneNum());
			ps.setString(3, c.getAddress());
			ps.setInt(4, c.getCustomerId());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// register new customer account
	public boolean RegisterAccount(Customer c) {
		String sql = "INSERT INTO customer(full_name, email, password, phone_num, address) VALUES (?, ?, ?, ?, ?)";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// insert customer data
			ps.setString(1, c.getFullName());
			ps.setString(2, c.getEmail());
			ps.setString(3, PasswordUtil.hashPassword(c.getPassword()));
			ps.setString(4, c.getPhoneNum());
			ps.setString(5, c.getAddress());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// login customer account
	public Customer login(String email, String password) {
		String sql = "SELECT * FROM customer WHERE email = ? AND password = ?";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// hash input password for login comparison
			ps.setString(1, email);
			ps.setString(2, PasswordUtil.hashPassword(password));

			ResultSet rs = ps.executeQuery();

			// if login success return customer object
			if (rs.next()) {
				return new Customer(rs.getInt("customer_id"), rs.getString("full_name"), rs.getString("email"),
						rs.getString("password"), rs.getString("phone_num"), rs.getString("address"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
