package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.FlightDAO;
import model.Flight;

@WebServlet("/searchFlights")
public class SearchFlightServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String date = request.getParameter("date");

        if (from == null) from = "";
        if (to == null) to = "";

        FlightDAO dao = new FlightDAO();
        // Gọi hàm 3 tham số (đã khớp với DAO mới)
        List<Flight> flights = dao.searchFlights(from, to, date);

        request.setAttribute("flights", flights); // Sửa thành "flights" cho khớp JSP của bạn (cũ là flightList)
        request.setAttribute("from", from);
        request.setAttribute("to", to);
        request.setAttribute("date", date);
        request.getRequestDispatcher("/search-results.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}