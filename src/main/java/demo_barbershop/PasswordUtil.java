package demo_barbershop;

import java.security.*;

public class PasswordUtil {

	// Prevent instantiation
	private PasswordUtil() {
	}

	public static String hashPassword(String password) {
		if (password == null)
			return null;

		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] hashedBytes = md.digest(password.getBytes("UTF-8"));

			StringBuilder sb = new StringBuilder();
			for (byte b : hashedBytes) {
				sb.append(String.format("%02x", b));
			}
			return sb.toString();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
