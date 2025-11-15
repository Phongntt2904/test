package controller;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.BookingDAO;
import dao.FlightDAO;
import model.Booking;
import model.Flight;
import model.User;

@WebServlet("/bookFlight")
public class BookFlightServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("flightId");
        if (idStr != null) {
            FlightDAO dao = new FlightDAO();
            Flight f = dao.getFlightById(Integer.parseInt(idStr));
            request.setAttribute("flight", f);
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int flightId = Integer.parseInt(request.getParameter("flightId"));
            int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
            String passengerName = request.getParameter("passengerName");
            String passengerEmail = request.getParameter("passengerEmail");
            String passengerPhone = request.getParameter("passengerPhone");

            FlightDAO flightDAO = new FlightDAO();
            Flight flight = flightDAO.getFlightById(flightId);

            if (flight != null && flight.getAvailableSeats() >= numPassengers) {
                double totalPrice = flight.getPrice() * numPassengers;

                Booking booking = new Booking();
                booking.setUserId(user.getUserId());
                booking.setFlightId(flightId);
                booking.setPassengerName(passengerName);
                booking.setPassengerEmail(passengerEmail);
                booking.setPassengerPhone(passengerPhone);
                booking.setNumPassengers(numPassengers);
                booking.setTotalAmount(totalPrice);
                booking.setBookingStatus("confirmed");

                BookingDAO bookingDAO = new BookingDAO();
                
                // 1. SỬA LỖI NULL: Lấy ID trả về từ hàm addBooking
                int bookingId = bookingDAO.addBooking(booking); 

                if (bookingId > 0) {
                    flightDAO.updateAvailableSeats(flightId, numPassengers);
                    
                    // 2. GỬI EMAIL ĐẸP (HTML Template)
                    try {
                        String emailContent = createBeautifulEmail(bookingId, flight, booking, user);
                        util.EmailUtility.sendEmail(user.getEmail(), "Vé Máy Bay Điện Tử - Mã vé #" + bookingId, emailContent);
                    } catch (Exception ex) {
                        System.out.println("Lỗi gửi mail nhưng vé vẫn đặt thành công");
                        ex.printStackTrace();
                    }

                    // Truyền ID sang trang success để hiển thị (không bị #null nữa)
                    // Dùng sendRedirect kèm tham số để tránh lỗi form resubmission
                    response.sendRedirect("booking-success.jsp?id=" + bookingId);
                } else {
                     response.sendRedirect("booking.jsp?error=Fail");
                }
            } else {
                response.sendRedirect("booking.jsp?error=Full");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // --- HÀM TẠO NỘI DUNG EMAIL HTML ĐẸP ---
    private String createBeautifulEmail(int bookingId, Flight flight, Booking booking, User user) {
        NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        String priceStr = nf.format(booking.getTotalAmount());
        
        // CSS Inline để đảm bảo hiển thị tốt trên mọi trình duyệt mail
        return "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 10px; overflow: hidden;'>"
             + "  <div style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 20px; text-align: center; color: white;'>"
             + "    <h1 style='margin: 0;'>SkyBooking</h1>"
             + "    <p style='margin: 5px 0 0;'>Xác nhận đặt vé thành công</p>"
             + "  </div>"
             + "  <div style='padding: 20px; background-color: #ffffff;'>"
             + "    <p>Xin chào <b>" + user.getFullName() + "</b>,</p>"
             + "    <p>Cảm ơn bạn đã lựa chọn SkyBooking. Dưới đây là thông tin vé điện tử của bạn:</p>"
             + "    "
             + "    <div style='background-color: #f8f9fa; border-radius: 8px; padding: 15px; margin: 20px 0; border-left: 5px solid #667eea;'>"
             + "      <h2 style='color: #667eea; margin-top: 0;'>MÃ VÉ: #" + bookingId + "</h2>"
             + "      <p><strong>Hành khách:</strong> " + booking.getPassengerName() + "</p>"
             + "      <p><strong>Chuyến bay:</strong> " + flight.getFlightNumber() + " (" + flight.getAirline() + ")</p>"
             + "      <p><strong>Hành trình:</strong> " + flight.getDepartureCity() + " ➝ " + flight.getArrivalCity() + "</p>"
             + "      <p><strong>Ngày giờ:</strong> " + flight.getDepartureTime() + "</p>"
             + "      <p><strong>Tổng tiền:</strong> <span style='color: #d32f2f; font-weight: bold; font-size: 1.2em;'>" + priceStr + "</span></p>"
             + "    </div>"
             + "    "
             + "    <p style='color: #666; font-size: 0.9em;'>Vui lòng có mặt tại sân bay trước 90 phút để làm thủ tục. Xuất trình email này tại quầy check-in.</p>"
             + "  </div>"
             + "  <div style='background-color: #f1f1f1; padding: 15px; text-align: center; font-size: 0.8em; color: #888;'>"
             + "    &copy; 2024 SkyBooking System. Mọi thắc mắc vui lòng liên hệ hotline 1900-xxxx."
             + "  </div>"
             + "</div>";
    }
}