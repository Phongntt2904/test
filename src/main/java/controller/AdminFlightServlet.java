package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.FlightDAO;
import model.Flight;

// --- QUAN TRỌNG: Mapping phải có /admin/ ---
@WebServlet("/admin/flight-manager")
@MultipartConfig
public class AdminFlightServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        FlightDAO dao = new FlightDAO();
        
        if ("delete".equals(action)) {
            dao.deleteFlight(Integer.parseInt(request.getParameter("id")));
            response.sendRedirect("dashboard.jsp?msg=Deleted");
        } else if ("edit".equals(action)) {
            Flight f = dao.getFlightById(Integer.parseInt(request.getParameter("id")));
            request.setAttribute("flight", f);
            request.getRequestDispatcher("edit-flight.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            Part filePart = request.getPart("image");
            String imageUrl = request.getParameter("oldImage");
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Lưu ảnh ra thư mục gốc (thoát ra khỏi admin bằng getParent hoặc lưu thẳng vào root)
                String savePath = getServletContext().getRealPath("/") + "images"; 
                File dir = new File(savePath);
                if (!dir.exists()) dir.mkdir();
                
                filePart.write(savePath + File.separator + fileName);
                imageUrl = "images/" + fileName;
            }

            Flight f = new Flight();
            f.setFlightNumber(request.getParameter("flightNumber"));
            f.setAirline(request.getParameter("airline"));
            f.setDepartureCity(request.getParameter("departureCity"));
            f.setArrivalCity(request.getParameter("arrivalCity"));
            
            String dep = request.getParameter("departureTime");
            String arr = request.getParameter("arrivalTime");
            if (dep.contains("T")) dep = dep.replace("T", " ") + ":00";
            if (arr.contains("T")) arr = arr.replace("T", " ") + ":00";
            
            f.setDepartureTime(Timestamp.valueOf(dep));
            f.setArrivalTime(Timestamp.valueOf(arr));
            
            f.setPrice(Double.parseDouble(request.getParameter("price")));
            f.setAvailableSeats(Integer.parseInt(request.getParameter("availableSeats")));
            f.setTotalSeats(100);
            f.setImageUrl(imageUrl);

            FlightDAO dao = new FlightDAO();
            String action = request.getParameter("action");
            
            if ("add".equals(action)) {
                dao.insertFlight(f);
            } else if ("update".equals(action)) {
                f.setFlightId(Integer.parseInt(request.getParameter("id")));
                dao.updateFlight(f);
            }
            
            response.sendRedirect("dashboard.jsp?msg=Success");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=Fail");
        }
    }
}