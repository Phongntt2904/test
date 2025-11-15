<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vé của tôi - SkyBooking</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        /* Header */
        .header {
            background: white;
            padding: 1.2rem 3rem;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.8rem;
            font-weight: bold;
            color: #2563eb;
            text-decoration: none;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-name {
            color: #1e293b;
            font-weight: 600;
        }

        .btn-logout {
            padding: 0.6rem 1.2rem;
            background: #ef4444;
            color: white;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-logout:hover {
            background: #dc2626;
            transform: translateY(-2px);
        }

        /* Container */
        .container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .page-title {
            font-size: 2.5rem;
            color: #1e293b;
            margin-bottom: 2rem;
            text-align: center;
        }

        /* Messages */
        .message {
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .message.success {
            background: #d1fae5;
            border-left: 4px solid #10b981;
            color: #065f46;
        }

        .message.error {
            background: #fee2e2;
            border-left: 4px solid #ef4444;
            color: #991b1b;
        }

        /* Booking List */
        .bookings-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .booking-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            display: grid;
            grid-template-columns: 100px 1fr 200px;
            gap: 2rem;
            align-items: center;
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
        }

        /* Status Badge */
        .status-badge {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .status-badge.confirmed {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        }

        .status-badge.pending {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
        }

        .status-badge.cancelled {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        }

        /* Booking Details */
        .booking-details {
            flex: 1;
        }

        .booking-id {
            font-size: 0.9rem;
            color: #64748b;
            margin-bottom: 0.5rem;
        }

        .booking-route {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1e293b;
            margin-bottom: 1rem;
        }

        .booking-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 0.8rem;
        }

        .info-item {
            display: flex;
            gap: 0.5rem;
            color: #64748b;
            font-size: 0.95rem;
        }

        .info-label {
            font-weight: 600;
        }

        /* Booking Actions */
        .booking-actions {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .booking-amount {
            text-align: center;
            margin-bottom: 1rem;
        }

        .amount-label {
            font-size: 0.9rem;
            color: #64748b;
            margin-bottom: 0.3rem;
        }

        .amount-value {
            font-size: 1.8rem;
            font-weight: bold;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .btn-action {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }

        .btn-view {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-cancel {
            background: transparent;
            color: #ef4444;
            border: 2px solid #ef4444;
        }

        .btn-cancel:hover {
            background: #ef4444;
            color: white;
            transform: translateY(-2px);
        }

        .btn-cancel:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Empty State */
        .empty-state {
            background: white;
            padding: 4rem 2rem;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
        }

        .empty-icon {
            font-size: 6rem;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            font-size: 1.8rem;
            color: #1e293b;
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: #64748b;
            margin-bottom: 2rem;
        }

        .btn-search {
            display: inline-block;
            padding: 1rem 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .booking-card {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .status-badge {
                margin: 0 auto;
            }

            .booking-info {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .header {
                padding: 1rem 1.5rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .booking-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <a href="index.jsp" class="logo">
                <span>✈️</span>
                <span>SkyBooking</span>
            </a>
            <div class="user-menu">
                <c:if test="${not empty sessionScope.fullName}">
                    <span class="user-name">👋 ${sessionScope.fullName}</span>
                    <a href="logout" class="btn-logout">Đăng xuất</a>
                </c:if>
                <c:if test="${empty sessionScope.fullName}">
                    <a href="login.jsp" class="btn-logout" style="background: #667eea;">Đăng nhập</a>
                </c:if>
            </div>
        </div>
    </header>

    <div class="container">
        <h1 class="page-title">Vé đã đặt của tôi</h1>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="message success">
                <span>✓</span>
                <span>${message}</span>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="message error">
                <span>⚠️</span>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Booking List -->
        <c:choose>
            <c:when test="${not empty bookings}">
                <div class="bookings-list">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="booking-card">
                            <!-- Status Badge -->
                            <div class="status-badge ${booking.bookingStatus}">
                                <c:choose>
                                    <c:when test="${booking.bookingStatus == 'confirmed'}">✓</c:when>
                                    <c:when test="${booking.bookingStatus == 'pending'}">⏳</c:when>
                                    <c:when test="${booking.bookingStatus == 'cancelled'}">✗</c:when>
                                </c:choose>
                            </div>

                            <!-- Booking Details -->
                            <div class="booking-details">
                                <div class="booking-id">
                                    Mã đặt vé: #${booking.bookingId}
                                </div>
                                <div class="booking-route">
                                    ${booking.passengerName}
                                </div>
                                <div class="booking-info">
                                    <div class="info-item">
                                        <span class="info-label">📧 Email:</span>
                                        <span>${booking.passengerEmail}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">📞 SĐT:</span>
                                        <span>${booking.passengerPhone}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">👥 Hành khách:</span>
                                        <span>${booking.numPassengers} người</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">📅 Ngày đặt:</span>
                                        <span>
                                            <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">📊 Trạng thái:</span>
                                        <span>
                                            <c:choose>
                                                <c:when test="${booking.bookingStatus == 'confirmed'}">
                                                    <span style="color: #10b981;">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${booking.bookingStatus == 'pending'}">
                                                    <span style="color: #f59e0b;">Chờ xác nhận</span>
                                                </c:when>
                                                <c:when test="${booking.bookingStatus == 'cancelled'}">
                                                    <span style="color: #ef4444;">Đã hủy</span>
                                                </c:when>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <!-- Booking Actions -->
                            <div class="booking-actions">
                                <div class="booking-amount">
                                    <div class="amount-label">Tổng tiền</div>
                                    <div class="amount-value">
                                        <fmt:formatNumber value="${booking.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                                    </div>
                                </div>
                                <a href="#" class="btn-action btn-view">Chi tiết</a>
                                <c:if test="${booking.bookingStatus == 'confirmed'}">
                                    <form action="cancelBooking" method="post" onsubmit="return confirm('Bạn có chắc muốn hủy vé này?');">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <button type="submit" class="btn-action btn-cancel">Hủy vé</button>
                                    </form>
                                </c:if>
                                <c:if test="${booking.bookingStatus != 'confirmed'}">
                                    <button class="btn-action btn-cancel" disabled>
                                        ${booking.bookingStatus == 'cancelled' ? 'Đã hủy' : 'Chờ xác nhận'}
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📭</div>
                    <h3>Chưa có vé nào</h3>
                    <p>Bạn chưa đặt vé nào. Hãy tìm kiếm và đặt chuyến bay đầu tiên của bạn!</p>
                    <a href="index.jsp" class="btn-search">Tìm chuyến bay</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Add stagger animation to booking cards
        const bookingCards = document.querySelectorAll('.booking-card');
        bookingCards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
        });
    </script>
</body>
</html>