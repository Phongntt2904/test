package servlet;

import dao.BookingDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cancelBooking")
public class CancelBookingServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    
    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            
            boolean success = bookingDAO.cancelBooking(bookingId);
            
            if (success) {
                request.setAttribute("message", "Hủy vé thành công!");
            } else {
                request.setAttribute("error", "Hủy vé thất bại!");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        // Chuyển về trang danh sách booking
        response.sendRedirect("myBookings");
    }
}
