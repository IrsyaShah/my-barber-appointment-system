package demo_barbershop.admin.barber;

import java.sql.*;
import java.util.*;
import javax.servlet.http.*;

import demo_barbershop.DBConnection;
import demo_barbershop.PasswordUtil;

@SuppressWarnings("unused")
public class BarberDAO {

	// display shift for the selected barber
	public List<String[]> getBarberShiftsDay(int barberId) {
		List<String[]> shifts = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(
						"SELECT day_name, shift_start, shift_finish FROM shift WHERE barber_id = ?")) {

			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				shifts.add(new String[] { rs.getString("day_name"), rs.getString("shift_start"),
						rs.getString("shift_finish") });
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return shifts;
	}
    
	// retrieve shift for the appointment 
	public List<String[]> getBarberShifts(int barberId) {
		List<String[]> shifts = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn
						.prepareStatement("SELECT shift_start, shift_finish FROM shift WHERE barber_id = ?")) {
			ps.setInt(1, barberId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				shifts.add(new String[] { rs.getString("shift_start"), rs.getString("shift_finish") });
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return shifts;
	}
    
	// retreive days of the barber working
	public List<String> getBarberWorkingDays(int barberId) {
		List<String> days = new ArrayList<>();

		try (Connection conn = DBConnection.getConnection()) {
			String sql = "SELECT DISTINCT day_name FROM shift WHERE barber_id = ?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, barberId);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				days.add(rs.getString("day_name"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return days;
	}

	// generate a 6-digit number
	public int generateRandomBarberID() {
		int randomNum = (int) (Math.random() * 900000) + 100000;
		return randomNum;
	}

	// register new barber account
	public int RegisterAccount(Barber b) {
		String sql = "INSERT INTO barber(barber_id, full_name, email, phone_num, address, status) VALUES (?, ?, ?, ?, ?, ?)";

		// generate random barber ID
		int barberID = generateRandomBarberID();
		b.setBarberId(barberID);

		// connect to database and execute query
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			// insert barber data
			ps.setInt(1, b.getBarberId());
			ps.setString(2, b.getFullName());
			ps.setString(3, b.getEmail());
			ps.setString(4, b.getPhoneNum());
			ps.setString(5, b.getAddress());
			ps.setString(6, b.getStatus());

			// return barber ID
			if (ps.executeUpdate() > 0) {
				return barberID;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// assign skill level for each service for barber
	public void AssignSkill(BarberService bs) {
		String sql = "INSERT INTO barber_service (barber_id, service_id, skill_level) VALUES (?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, bs.getBarberId());
			ps.setInt(2, bs.getServiceId());
			ps.setString(3, bs.getSkillLevel());

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// get all barber along with skill level
	public ArrayList<Barber> getAllBarbers() {

		String sql = "SELECT b.barber_id, b.full_name, b.email, b.phone_num, b.address, b.status, "
				+ "s.service_name, bs.skill_level " + "FROM barber b "
				+ "LEFT JOIN barber_service bs ON b.barber_id = bs.barber_id "
				+ "LEFT JOIN service s ON bs.service_id = s.service_id " + "ORDER BY b.status";

		Map<Integer, Barber> barberMap = new LinkedHashMap<>();

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				int barberId = rs.getInt("barber_id");

				Barber b = barberMap.get(barberId);
				if (b == null) {
					b = new Barber();
					b.setBarberId(barberId);
					b.setFullName(rs.getString("full_name"));
					b.setEmail(rs.getString("email"));
					b.setPhoneNum(rs.getString("phone_num"));
					b.setAddress(rs.getString("address"));
					b.setStatus(rs.getString("status"));
					barberMap.put(barberId, b);
				}

				if (rs.getString("service_name") != null) {
					BarberService bs = new BarberService();
					bs.setServiceName(rs.getString("service_name"));
					bs.setSkillLevel(rs.getString("skill_level"));
					b.getServices().add(bs);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ArrayList<>(barberMap.values());
	}

	// get barber by id
	public Barber getBarberById(int barberId) {
		Barber b = null;

		try {
			// connect to database and execute query
			Connection con = DBConnection.getConnection();
			String sql = "SELECT * FROM barber WHERE barber_id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, barberId);

			ResultSet rs = ps.executeQuery();

			// read data from database
			if (rs.next()) {
				b = new Barber();
				b.setBarberId(rs.getInt("barber_id"));
				b.setFullName(rs.getString("full_name"));
				b.setEmail(rs.getString("email"));
				b.setPhoneNum(rs.getString("phone_num"));
				b.setAddress(rs.getString("address"));
				b.setStatus(rs.getString("status"));
			}

			// get assigned services
			String sqlServices = "SELECT bs.service_id, s.service_name, bs.skill_level " + "FROM barber_service bs "
					+ "JOIN service s ON bs.service_id = s.service_id " + "WHERE bs.barber_id = ?";
			PreparedStatement ps2 = con.prepareStatement(sqlServices);
			ps2.setInt(1, barberId);
			ResultSet rs2 = ps2.executeQuery();

			while (rs2.next()) {
				BarberService bs = new BarberService();
				bs.setBarberId(b.getBarberId());
				bs.setServiceId(rs2.getInt("service_id"));
				bs.setServiceName(rs2.getString("service_name"));
				bs.setSkillLevel(rs2.getString("skill_level"));
				b.getServices().add(bs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return b;
	}

	// get barber service
	public List<BarberService> getBarberService(int barberId) {
		List<BarberService> list = new ArrayList<>();

		// connect to database and execute query
		try (Connection con = DBConnection.getConnection()) {

			String sql = "SELECT bs.service_id, s.service_name, s.price, bs.skill_level " + "FROM barber_service bs "
					+ "JOIN service s ON bs.service_id = s.service_id " + "WHERE bs.barber_id = ?";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, barberId);

			ResultSet rs = ps.executeQuery();

			// read data from database
			while (rs.next()) {
				BarberService bs = new BarberService();
				bs.setServiceId(rs.getInt("service_id"));
				bs.setServiceName(rs.getString("service_name"));
				bs.setSkillLevel(rs.getString("skill_level"));
				bs.setPrice(rs.getDouble("price"));

				list.add(bs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// update barber and services details
	public boolean UpdateBarber(Barber barber, String[] serviceIds, HttpServletRequest request) {
		String updatebarbesql = "UPDATE barber SET full_name=?, email=?, phone_num=?, address=?, status=? WHERE barber_id=?";
		String deleteservicesql = "DELETE FROM barber_service WHERE barber_id=?";
		String addservicesql = "INSERT INTO barber_service (barber_id, service_id, skill_level) VALUES (?,?,?)";

		try (Connection con = DBConnection.getConnection()) {

			// start transaction
			con.setAutoCommit(false);

			// update barber details
			try (PreparedStatement ps = con.prepareStatement(updatebarbesql)) {
				ps.setString(1, barber.getFullName());
				ps.setString(2, barber.getEmail());
				ps.setString(3, barber.getPhoneNum());
				ps.setString(4, barber.getAddress());
				ps.setString(5, barber.getStatus());
				ps.setInt(6, barber.getBarberId());
				ps.executeUpdate();
			}

			// delete existing services
			try (PreparedStatement ps = con.prepareStatement(deleteservicesql)) {
				ps.setInt(1, barber.getBarberId());
				ps.executeUpdate();
			}

			// insert new selected services
			if (serviceIds != null) {
				try (PreparedStatement ps = con.prepareStatement(addservicesql)) {
					for (String sid : serviceIds) {
						int serviceId = Integer.parseInt(sid);
						String skill = request.getParameter("skillLevel_" + serviceId);

						if (skill != null && !skill.isEmpty()) {
							ps.setInt(1, barber.getBarberId());
							ps.setInt(2, serviceId);
							ps.setString(3, skill);
							ps.addBatch();
						}
					}
					ps.executeBatch();
				}
			}

			// commit
			con.commit();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// check exists email in database
	public boolean ExistsEmail(String email, int barberId) {
		String sql = "SELECT COUNT(*) FROM barber WHERE email=? AND barber_id<>?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, email);
			ps.setInt(2, barberId);

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

	// get all active barber with no shift yet for dropdown
	public List<Barber> getActiveBarber() {
		List<Barber> list = new ArrayList<>();
		String sql = "SELECT barber_id, full_name FROM barber WHERE status='active' ORDER BY full_name";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Barber b = new Barber();
				b.setBarberId(rs.getInt("barber_id"));
				b.setFullName(rs.getString("full_name"));
				list.add(b);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// get all active barber and has shift for dropdown
	public List<Barber> getBarber() {
		List<Barber> list = new ArrayList<>();
		String sql = "SELECT b.barber_id, b.full_name " + "FROM barber b " + "WHERE b.status = 'active' "
				+ "AND EXISTS (SELECT 1 FROM shift s WHERE s.barber_id = b.barber_id) " + "ORDER BY b.full_name";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Barber b = new Barber();
				b.setBarberId(rs.getInt("barber_id"));
				b.setFullName(rs.getString("full_name"));
				list.add(b);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}
