package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Booking;
import util.DatabaseConnection;

public class BookingDAO {

    // Sửa hàm này để trả về int (ID của vé) thay vì boolean
    public int addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, flight_id, passenger_name, passenger_email, passenger_phone, num_passengers, total_amount, booking_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        // Quan trọng: Thêm Statement.RETURN_GENERATED_KEYS để lấy ID
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getFlightId());
            ps.setString(3, booking.getPassengerName());
            ps.setString(4, booking.getPassengerEmail());
            ps.setString(5, booking.getPassengerPhone());
            ps.setInt(6, booking.getNumPassengers());
            ps.setDouble(7, booking.getTotalAmount());
            ps.setString(8, "confirmed");

            int rows = ps.executeUpdate();
            
            // Nếu insert thành công, lấy ngay cái ID vừa tạo
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Trả về Booking ID (ví dụ: 101, 102...)
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0; // Trả về 0 nếu lỗi
    }

    // Các hàm khác giữ nguyên
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_date DESC")) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setFlightId(rs.getInt("flight_id"));
                b.setPassengerName(rs.getString("passenger_name"));
                b.setPassengerEmail(rs.getString("passenger_email"));
                b.setPassengerPhone(rs.getString("passenger_phone"));
                b.setNumPassengers(rs.getInt("num_passengers"));
                b.setTotalAmount(rs.getDouble("total_amount"));
                b.setBookingStatus(rs.getString("booking_status"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                list.add(b);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean cancelBooking(int bookingId) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE bookings SET booking_status = 'cancelled' WHERE booking_id = ?")) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}