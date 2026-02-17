package demo_barbershop;

import java.sql.*;

public class DBConnection {

	private static final String URL = "jdbc:mysql://localhost:3306/demo_balbarbershop";
	private static final String USER = "root";
	private static final String PASS = "";

	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(URL, USER, PASS);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
