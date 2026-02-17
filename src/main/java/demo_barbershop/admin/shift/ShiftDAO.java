package demo_barbershop.admin.shift;

import java.sql.*;
import java.util.*;
import javax.servlet.http.*;

import demo_barbershop.DBConnection;
import demo_barbershop.PasswordUtil;
import demo_barbershop.admin.barber.Barber;
import demo_barbershop.admin.service.Service;

@SuppressWarnings("unused")
public class ShiftDAO {
	
	// block update if current shift has appointments
	public boolean checkAppointments(int shiftId) {
	    Shift oldShift = getShiftById(shiftId);
	    if (oldShift == null) return false;

	    String sql =
	        "SELECT COUNT(*) FROM appointment " +
	        "WHERE barber_id = ? " +
	        "  AND status IN ('Pending', 'Confirmed') " +
	        "  AND DAYNAME(appointment_date) = ? " +
	        "  AND appointment_start < ? " +
	        "  AND appointment_finish > ?";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, oldShift.getBarberId());
	        ps.setString(2, oldShift.getDayName());
	        ps.setTime(3, java.sql.Time.valueOf(oldShift.getShiftFinish()));
	        ps.setTime(4, java.sql.Time.valueOf(oldShift.getShiftStart()));

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) return rs.getInt(1) > 0;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	
	// check if a shift has pending or confirmed appointment
	public boolean hasAppointments(int shiftId) {
	    Shift sh = getShiftById(shiftId);
	    if (sh == null) return false;

	    String sql =
	        "SELECT COUNT(*) " +
	        "FROM appointment " +
	        "WHERE barber_id = ? " +
	        "  AND status IN ('Pending', 'Confirmed') " +
	        "  AND DAYNAME(appointment_date) = ? " +
	        "  AND appointment_start < ? " +    
	        "  AND appointment_finish > ?";      

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, sh.getBarberId());
	        ps.setString(2, sh.getDayName());
	        ps.setTime(3, java.sql.Time.valueOf(sh.getShiftFinish()));
	        ps.setTime(4, java.sql.Time.valueOf(sh.getShiftStart()));

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt(1) > 0;
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	// get staff schedule
	public ArrayList<Shift> getOwnSchedule(int barberId) {
		ArrayList<Shift> shifts = new ArrayList<>();
		String sql = "SELECT * FROM shift WHERE barber_id = ? "
				+ "ORDER BY FIELD(day_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Shift sh = new Shift();
				sh.setShiftId(rs.getInt("shift_id"));
				sh.setBarberId(rs.getInt("barber_id"));
				sh.setDayName(rs.getString("day_name"));
				sh.setShiftStart(rs.getTime("shift_start").toLocalTime());
				sh.setShiftFinish(rs.getTime("shift_finish").toLocalTime());
				shifts.add(sh);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return shifts;
	}

	// get shift by id
	public Shift getShiftById(int shiftId) {
		Shift sh = null;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement("SELECT * FROM shift WHERE shift_id = ?")) {

			ps.setInt(1, shiftId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				sh = new Shift();
				sh.setShiftId(rs.getInt("shift_id"));
				sh.setBarberId(rs.getInt("barber_id"));
				sh.setDayName(rs.getString("day_name"));
				sh.setShiftStart(rs.getTime("shift_start").toLocalTime());
				sh.setShiftFinish(rs.getTime("shift_finish").toLocalTime());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return sh;
	}

	// check each barber for the same day
	public boolean ExitsDay(int barberId, String dayName) {
		String sql = "SELECT COUNT(*) FROM shift WHERE barber_id = ? AND day_name = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, barberId);
			ps.setString(2, dayName);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// check if barber already has a shift on that day
	public boolean ExistsShiftDay(int barberId, String dayName, int shiftId) {
		String sql = "SELECT COUNT(*) FROM shift WHERE barber_id = ? AND day_name = ? AND shift_id <> ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, barberId);
			ps.setString(2, dayName);
			ps.setInt(3, shiftId);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					int count = rs.getInt(1);
					return count > 0;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	// add new shift
	public boolean AddShift(Shift sh) {
		String sql = "INSERT INTO shift(barber_id, day_name, shift_start, shift_finish) VALUES (?, ?, ?, ?)";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// insert shift data
			ps.setInt(1, sh.getBarberId());
			ps.setString(2, sh.getDayName());
			ps.setTime(3, Time.valueOf(sh.getShiftStart()));
			ps.setTime(4, Time.valueOf(sh.getShiftFinish()));

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// update shift details
	public boolean UpdateShift(Shift sh) {
		String sql = "UPDATE shift SET barber_id = ?, day_name = ?, shift_start = ?, shift_finish = ? WHERE shift_id = ?";

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// update shift data
			ps.setInt(1, sh.getBarberId());
			ps.setString(2, sh.getDayName());
			ps.setTime(3, Time.valueOf(sh.getShiftStart()));
			ps.setTime(4, Time.valueOf(sh.getShiftFinish()));
			ps.setInt(5, sh.getShiftId());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// delete shift details
	public boolean DeleteShift(int shiftId) {
		String sql = "DELETE FROM shift WHERE shift_id = ?";

		// connect to database and execute query
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			// delete shift data
			ps.setInt(1, shiftId);
			int rows = ps.executeUpdate();

			return rows > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// get all shift
	public ArrayList<Shift> getAllShifts() {

		String sql = "SELECT sh.* " + "FROM shift sh " + "JOIN barber b ON sh.barber_id = b.barber_id "
				+ "ORDER BY sh.barber_id, sh.day_name";

		ArrayList<Shift> shifts = new ArrayList<>();

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Shift sh = new Shift();
				sh.setShiftId(rs.getInt("shift_id"));
				sh.setBarberId(rs.getInt("barber_id"));
				sh.setDayName(rs.getString("day_name"));
				sh.setShiftStart(rs.getTime("shift_start").toLocalTime());
				sh.setShiftFinish(rs.getTime("shift_finish").toLocalTime());

				shifts.add(sh);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return shifts;
	}
}
