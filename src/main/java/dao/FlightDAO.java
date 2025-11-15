package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Flight;
import util.DatabaseConnection;

public class FlightDAO {

    // Helper: Map dữ liệu từ SQL vào đối tượng Flight
    private Flight mapRow(ResultSet rs) throws SQLException {
        Flight f = new Flight();
        f.setFlightId(rs.getInt("flight_id"));
        f.setFlightNumber(rs.getString("flight_number"));
        f.setAirline(rs.getString("airline"));
        f.setDepartureCity(rs.getString("departure_city"));
        f.setArrivalCity(rs.getString("arrival_city"));
        f.setDepartureTime(rs.getTimestamp("departure_time"));
        f.setArrivalTime(rs.getTimestamp("arrival_time"));
        f.setPrice(rs.getDouble("price"));
        f.setAvailableSeats(rs.getInt("available_seats"));
        f.setTotalSeats(rs.getInt("total_seats"));
        try {
            f.setImageUrl(rs.getString("image_url"));
        } catch (Exception e) {
            f.setImageUrl("images/default.jpg"); // Tránh lỗi nếu chưa có cột ảnh
        }
        return f;
    }

    // ==========================================
    // 1. ĐÂY LÀ HÀM BẠN ĐANG THIẾU (SEARCH 3 THAM SỐ)
    // ==========================================
    public List<Flight> searchFlights(String from, String to, String date) {
        List<Flight> list = new ArrayList<>();
        
        // Tạo câu SQL động: Luôn tìm theo Nơi đi & Nơi đến
        StringBuilder sql = new StringBuilder("SELECT * FROM flights WHERE departure_city LIKE ? AND arrival_city LIKE ?");
        
        // Nếu người dùng có chọn ngày thì thêm điều kiện ngày
        if (date != null && !date.isEmpty()) {
            sql.append(" AND DATE(departure_time) = ?");
        }
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            ps.setString(1, "%" + from + "%");
            ps.setString(2, "%" + to + "%");
            
            // Nếu có ngày thì set tham số thứ 3
            if (date != null && !date.isEmpty()) {
                ps.setString(3, date);
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Hàm trừ ghế (Cho BookFlightServlet)
    public boolean updateAvailableSeats(int flightId, int seatsToDeduct) {
        String sql = "UPDATE flights SET available_seats = available_seats - ? WHERE flight_id = ? AND available_seats >= ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seatsToDeduct);
            ps.setInt(2, flightId);
            ps.setInt(3, seatsToDeduct);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3. Lấy theo ID (Cho trang đặt vé)
    public Flight getFlightById(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM flights WHERE flight_id=?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 4. Lấy tất cả (Cho Admin Dashboard)
    public List<Flight> getAllFlights() {
        List<Flight> list = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM flights ORDER BY flight_id DESC")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 5. Thêm chuyến bay (Admin)
    public boolean insertFlight(Flight f) {
        String sql = "INSERT INTO flights (flight_number, airline, departure_city, arrival_city, departure_time, arrival_time, price, available_seats, total_seats, image_url) VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, f.getFlightNumber()); ps.setString(2, f.getAirline());
            ps.setString(3, f.getDepartureCity()); ps.setString(4, f.getArrivalCity());
            ps.setTimestamp(5, f.getDepartureTime()); ps.setTimestamp(6, f.getArrivalTime());
            ps.setDouble(7, f.getPrice()); ps.setInt(8, f.getAvailableSeats());
            ps.setInt(9, f.getTotalSeats()); ps.setString(10, f.getImageUrl());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 6. Cập nhật (Admin)
    public boolean updateFlight(Flight f) {
        String sql = "UPDATE flights SET flight_number=?, airline=?, departure_city=?, arrival_city=?, departure_time=?, arrival_time=?, price=?, available_seats=?, image_url=? WHERE flight_id=?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, f.getFlightNumber()); ps.setString(2, f.getAirline());
            ps.setString(3, f.getDepartureCity()); ps.setString(4, f.getArrivalCity());
            ps.setTimestamp(5, f.getDepartureTime()); ps.setTimestamp(6, f.getArrivalTime());
            ps.setDouble(7, f.getPrice()); ps.setInt(8, f.getAvailableSeats());
            ps.setString(9, f.getImageUrl()); ps.setInt(10, f.getFlightId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 7. Xóa (Admin)
    public boolean deleteFlight(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM flights WHERE flight_id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}