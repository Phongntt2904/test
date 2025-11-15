<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả tìm kiếm - SkyBooking</title>
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

        .logo-icon {
            font-size: 2rem;
        }

        /* Container */
        .container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        /* Search Info */
        .search-info {
            background: white;
            padding: 1.5rem 2rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: slideIn 0.5s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .search-info h2 {
            color: #1e293b;
            font-size: 1.5rem;
        }

        .search-info p {
            color: #64748b;
            margin-top: 0.5rem;
        }

        .modify-search {
            padding: 0.8rem 1.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .modify-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        /* Flights List */
        .flights-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .flight-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            display: grid;
            grid-template-columns: 200px 1fr 200px;
            gap: 2rem;
            align-items: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
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

        .flight-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
        }

        .flight-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
        }

        /* Airline Info */
        .airline-info {
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
        }

        .airline-logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .airline-name {
            font-weight: 700;
            font-size: 1.2rem;
            color: #1e293b;
        }

        .flight-number {
            color: #64748b;
            font-size: 0.9rem;
        }

        /* Flight Details */
        .flight-details {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 2rem;
        }

        .flight-time {
            text-align: center;
            flex: 1;
        }

        .time {
            font-size: 2rem;
            font-weight: bold;
            color: #1e293b;
            display: block;
        }

        .location {
            color: #64748b;
            font-size: 1rem;
            margin-top: 0.3rem;
        }

        .flight-route {
            flex: 1;
            text-align: center;
            position: relative;
        }

        .route-line {
            height: 2px;
            background: #e2e8f0;
            position: relative;
            margin: 1rem 0;
        }

        .route-line::before {
            content: '✈️';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 1.5rem;
            animation: flyPlane 2s ease-in-out infinite;
        }

        @keyframes flyPlane {
            0%, 100% {
                left: 20%;
            }
            50% {
                left: 80%;
            }
        }

        .duration {
            color: #64748b;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        /* Booking Section */
        .booking-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
        }

        .price {
            font-size: 2rem;
            font-weight: bold;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .price-label {
            color: #64748b;
            font-size: 0.85rem;
        }

        .seats-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #10b981;
            font-size: 0.9rem;
            padding: 0.5rem 1rem;
            background: #ecfdf5;
            border-radius: 20px;
        }

        .btn-book {
            width: 100%;
            padding: 1rem 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-book:active {
            transform: translateY(0);
        }

        /* No Results */
        .no-results {
            background: white;
            padding: 4rem 2rem;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
        }

        .no-results-icon {
            font-size: 5rem;
            margin-bottom: 1rem;
            animation: swing 2s ease-in-out infinite;
        }

        @keyframes swing {
            0%, 100% {
                transform: rotate(0deg);
            }
            25% {
                transform: rotate(10deg);
            }
            75% {
                transform: rotate(-10deg);
            }
        }

        .no-results h3 {
            color: #1e293b;
            font-size: 1.8rem;
            margin-bottom: 1rem;
        }

        .no-results p {
            color: #64748b;
            margin-bottom: 2rem;
        }

        /* Filter Section */
        .filter-section {
            background: white;
            padding: 1.5rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
        }

        .filter-title {
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 1rem;
        }

        .filter-options {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 0.6rem 1.2rem;
            background: #f1f5f9;
            border: 2px solid transparent;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .filter-btn:hover {
            background: #e2e8f0;
        }

        .filter-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .flight-card {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .flight-details {
                flex-direction: column;
                gap: 1rem;
            }

            .booking-section {
                flex-direction: row;
                justify-content: space-between;
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .header {
                padding: 1rem 1.5rem;
            }

            .search-info {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .flight-card {
                padding: 1.5rem;
            }

            .time {
                font-size: 1.5rem;
            }

            .price {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <a href="index.jsp" class="logo">
                <span class="logo-icon">✈️</span>
                <span>SkyBooking</span>
            </a>
        </div>
    </header>

    <div class="container">
        <!-- Search Info -->
        <div class="search-info">
            <div>
                <h2>Kết quả tìm kiếm chuyến bay</h2>
                <p>🛫 ${from} → ${to} | 📅 ${date}</p>
            </div>
            <a href="index.jsp" class="modify-search">Thay đổi tìm kiếm</a>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-title">Sắp xếp theo:</div>
            <div class="filter-options">
                <button class="filter-btn active">Giá thấp nhất</button>
                <button class="filter-btn">Thời gian bay</button>
                <button class="filter-btn">Khởi hành sớm nhất</button>
                <button class="filter-btn">Khởi hành muộn nhất</button>
            </div>
        </div>

        <!-- Flights List -->
        <c:choose>
            <c:when test="${not empty flights}">
                <div class="flights-list">
                    <c:forEach var="flight" items="${flights}">
                        <div class="flight-card">
                            <!-- Airline Info -->
                            <div class="airline-info">
                                <div class="airline-logo">✈️</div>
                                <div>
                                    <div class="airline-name">${flight.airline}</div>
                                    <div class="flight-number">${flight.flightNumber}</div>
                                </div>
                            </div>

                            <!-- Flight Details -->
                            <div class="flight-details">
                                <div class="flight-time">
                                    <span class="time">
                                        <fmt:formatDate value="${flight.departureTime}" pattern="HH:mm"/>
                                    </span>
                                    <div class="location">${flight.departureCity}</div>
                                </div>

                                <div class="flight-route">
                                    <div class="route-line"></div>
                                    <div class="duration">
                                        <fmt:formatDate value="${flight.departureTime}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>

                                <div class="flight-time">
                                    <span class="time">
                                        <fmt:formatDate value="${flight.arrivalTime}" pattern="HH:mm"/>
                                    </span>
                                    <div class="location">${flight.arrivalCity}</div>
                                </div>
                            </div>

                            <!-- Booking Section -->
                            <div class="booking-section">
                                <div style="text-align: center;">
                                    <div class="price">
                                        <fmt:formatNumber value="${flight.price}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                                    </div>
                                    <div class="price-label">/ hành khách</div>
                                </div>
                                <div class="seats-info">
                                    <span>✓</span>
                                    <span>Còn ${flight.availableSeats} chỗ</span>
                                </div>
                                <a href="bookFlight?flightId=${flight.flightId}" class="btn-book">
                                    Đặt vé ngay
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-results">
                    <div class="no-results-icon">😔</div>
                    <h3>Không tìm thấy chuyến bay phù hợp</h3>
                    <p>Rất tiếc, không có chuyến bay nào phù hợp với tiêu chí tìm kiếm của bạn</p>
                    <a href="index.jsp" class="modify-search">Tìm kiếm lại</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Filter buttons functionality
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Add stagger animation to flight cards
        const flightCards = document.querySelectorAll('.flight-card');
        flightCards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
        });
    </script>
</body>
</html>