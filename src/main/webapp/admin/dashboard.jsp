<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.FlightDAO, model.Flight, java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Load dữ liệu
    FlightDAO dao = new FlightDAO();
    request.setAttribute("listFlights", dao.getAllFlights());
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - SkyBooking</title>
    <style>
        /* --- COPY STYLE TỪ LOGIN.JSP SANG --- */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); /* Màu tím chủ đạo */
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        
        /* Container chính */
        .admin-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header */
        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        h2 { color: #333; margin: 0; }

        /* Nút bấm */
        .btn {
            padding: 10px 20px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
            display: inline-block;
            border: none;
            cursor: pointer;
        }

        .btn-add {
            background: linear-gradient(to right, #10b981, #059669);
            color: white;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }

        .btn-logout {
            background: #f3f4f6;
            color: #666;
        }
        
        .btn-edit { background: #3b82f6; color: white; padding: 5px 15px; font-size: 0.9em; }
        .btn-delete { background: #ef4444; color: white; padding: 5px 15px; font-size: 0.9em; }

        .btn:hover { transform: translateY(-2px); filter: brightness(1.1); }

        /* Bảng dữ liệu */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th {
            background: #f8f9fa;
            color: #666;
            font-weight: 600;
            padding: 15px;
            text-align: left;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
            color: #444;
        }

        tr:hover { background-color: #f9fafb; }

        .flight-img {
            width: 80px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .status-badge {
            background: #e0e7ff; color: #4338ca;
            padding: 5px 10px; border-radius: 20px; font-size: 0.8em; font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <div class="admin-header">
            <div>
                <h2>✈️ Quản Lý Chuyến Bay</h2>
                <p style="color: #777;">Xin chào, Admin</p>
            </div>
            <div>
                <a href="../index.jsp" class="btn btn-logout">Về trang chủ</a>
                <a href="add-flight.jsp" class="btn btn-add">+ Thêm Chuyến Bay</a>
            </div>
        </div>

        <c:if test="${not empty param.msg}">
            <div style="background: #d1fae5; color: #065f46; padding: 15px; border-radius: 10px; margin-bottom: 20px;">
                ✅ Thao tác thành công!
            </div>
        </c:if>

        <table>
            <thead>
                <tr>
                    <th>Ảnh</th>
                    <th>Số hiệu</th>
                    <th>Hãng bay</th>
                    <th>Lịch trình</th>
                    <th>Ngày giờ</th>
                    <th>Giá vé</th>
                    <th>Ghế</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="f" items="${listFlights}">
                    <tr>
                        <td><img src="../${f.imageUrl}" class="flight-img" onerror="this.src='../images/default.png'"></td>
                        <td><span class="status-badge">${f.flightNumber}</span></td>
                        <td>${f.airline}</td>
                        <td><b>${f.departureCity}</b> ➝ <b>${f.arrivalCity}</b></td>
                        <td>
                            <div style="font-size: 0.9em;">Đi: ${f.departureTime}</div>
                            <div style="font-size: 0.9em; color: #888;">Đến: ${f.arrivalTime}</div>
                        </td>
                        <td style="color: #d97706; font-weight: bold;">${f.price} ₫</td>
                        <td>${f.availableSeats}/${f.totalSeats}</td>
                        <td>
                            <a href="flight-manager?action=edit&id=${f.flightId}" class="btn btn-edit">Sửa</a>
                            <a href="flight-manager?action=delete&id=${f.flightId}" class="btn btn-delete" onclick="return confirm('Xóa chuyến bay này sẽ xóa luôn các vé đã đặt. Tiếp tục?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>