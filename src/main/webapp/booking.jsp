<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>


<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt vé - SkyBooking</title>
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
            max-width: 1200px;
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

        /* Progress Steps */
        .progress-steps {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .steps {
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            margin-bottom: 3rem;
        }

        .steps::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 0;
            right: 0;
            height: 3px;
            background: #e2e8f0;
            z-index: 0;
        }

        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 1;
            flex: 1;
        }

        .step-circle {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: white;
            border: 3px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #94a3b8;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }

        .step.active .step-circle {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: #667eea;
            color: white;
            transform: scale(1.1);
        }

        .step.completed .step-circle {
            background: #10b981;
            border-color: #10b981;
            color: white;
        }

        .step-label {
            font-size: 0.9rem;
            color: #64748b;
            font-weight: 600;
        }

        .step.active .step-label {
            color: #667eea;
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto 3rem;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 2rem;
        }

        /* Main Content */
        .main-content {
            animation: fadeInLeft 0.6s ease;
        }

        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-size: 1.5rem;
            color: #1e293b;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-icon {
            font-size: 1.8rem;
        }

        /* Form Groups */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #334155;
            font-size: 0.95rem;
        }

        .required {
            color: #ef4444;
        }

        .form-group input,
        .form-group select {
            padding: 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group input::placeholder {
            color: #cbd5e1;
        }

        /* Sidebar */
        .sidebar {
            animation: fadeInRight 0.6s ease;
        }

        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .summary-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            position: sticky;
            top: 100px;
        }

        .summary-title {
            font-size: 1.3rem;
            color: #1e293b;
            margin-bottom: 1.5rem;
            font-weight: 700;
        }

        .flight-summary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 1.5rem;
            border-radius: 16px;
            color: white;
            margin-bottom: 1.5rem;
        }

        .flight-route {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .flight-city {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .flight-arrow {
            font-size: 1.5rem;
        }

        .flight-info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.8rem;
            font-size: 0.95rem;
        }

        .flight-info-label {
            opacity: 0.9;
        }

        .flight-info-value {
            font-weight: 600;
        }

        .divider {
            height: 1px;
            background: rgba(255, 255, 255, 0.3);
            margin: 1rem 0;
        }

        /* Price Breakdown */
        .price-breakdown {
            margin-top: 1.5rem;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            color: #64748b;
        }

        .price-row.total {
            border-top: 2px solid #e2e8f0;
            padding-top: 1rem;
            margin-top: 1rem;
            font-size: 1.3rem;
            font-weight: bold;
            color: #1e293b;
        }

        .price-amount {
            color: #667eea;
            font-weight: 700;
        }

        /* Submit Button */
        .btn-submit {
            width: 100%;
            padding: 1.2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        /* Error Message */
        .error-message {
            background: #fee2e2;
            border-left: 4px solid #ef4444;
            color: #991b1b;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Info Box */
        .info-box {
            background: #dbeafe;
            border-left: 4px solid #3b82f6;
            color: #1e3a8a;
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        /* Passenger Counter */
        .passenger-counter {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
        }

        .counter-btn {
            width: 40px;
            height: 40px;
            border: 2px solid #667eea;
            background: white;
            color: #667eea;
            border-radius: 8px;
            font-size: 1.2rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .counter-btn:hover {
            background: #667eea;
            color: white;
        }

        .counter-value {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1e293b;
            min-width: 50px;
            text-align: center;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .container {
                grid-template-columns: 1fr;
            }

            .summary-card {
                position: static;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .header {
                padding: 1rem 1.5rem;
            }

            .steps {
                flex-wrap: wrap;
            }

            .step {
                flex: none;
                width: 33.333%;
                margin-bottom: 1rem;
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
        </div>
    </header>

    <!-- Progress Steps -->
    <div class="progress-steps">
        <div class="steps">
            <div class="step completed">
                <div class="step-circle">✓</div>
                <div class="step-label">Chọn chuyến bay</div>
            </div>
            <div class="step active">
                <div class="step-circle">2</div>
                <div class="step-label">Thông tin hành khách</div>
            </div>
            <div class="step">
                <div class="step-circle">3</div>
                <div class="step-label">Thanh toán</div>
            </div>
            <div class="step">
                <div class="step-circle">4</div>
                <div class="step-label">Hoàn thành</div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Main Content -->
        <div class="main-content">
            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    <span>⚠️</span>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Passenger Information Form -->
            <form action="bookFlight" method="post">
                <input type="hidden" name="flightId" value="${flight.flightId}">

                <div class="card">
                    <h2 class="card-title">
                        <span class="card-icon">👤</span>
                        Thông tin hành khách
                    </h2>

                    <div class="form-grid">
                        <div class="form-group full-width">
                            <label>Họ và tên <span class="required">*</span></label>
                            <input type="text" name="passengerName" required 
                                   placeholder="Nguyễn Văn A">
                        </div>

                        <div class="form-group">
                            <label>Email <span class="required">*</span></label>
                            <input type="email" name="passengerEmail" required 
                                   placeholder="example@email.com">
                        </div>

                        <div class="form-group">
                            <label>Số điện thoại <span class="required">*</span></label>
                            <input type="tel" name="passengerPhone" required 
                                   placeholder="0912345678">
                        </div>

                        <div class="form-group full-width">
                            <label>Số lượng hành khách <span class="required">*</span></label>
                            <div class="passenger-counter">
                                <button type="button" class="counter-btn" onclick="decreasePassengers()">−</button>
                                <input type="number" name="numPassengers" id="numPassengers" 
                                       class="counter-value" value="1" min="1" max="10" readonly>
                                <button type="button" class="counter-btn" onclick="increasePassengers()">+</button>
                            </div>
                        </div>
                    </div>

                    <div class="info-box">
                        💡 <strong>Lưu ý:</strong> Vui lòng kiểm tra kỹ thông tin trước khi xác nhận. 
                        Thông tin vé sẽ được gửi qua email và số điện thoại bạn cung cấp.
                    </div>
                </div>

                <div class="card">
                    <h2 class="card-title">
                        <span class="card-icon">💳</span>
                        Phương thức thanh toán
                    </h2>

                    <div class="form-group">
                        <label>Chọn phương thức <span class="required">*</span></label>
                        <select required>
                            <option value="">Chọn phương thức thanh toán</option>
                            <option value="credit">Thẻ tín dụng/Ghi nợ</option>
                            <option value="momo">Ví MoMo</option>
                            <option value="zalopay">ZaloPay</option>
                            <option value="bank">Chuyển khoản ngân hàng</option>
                        </select>
                    </div>
                </div>
            </form>
        </div>

        <!-- Sidebar Summary -->
        <div class="sidebar">
            <div class="summary-card">
                <h3 class="summary-title">Chi tiết đặt vé</h3>

                <div class="flight-summary">
                    <div class="flight-route">
                        <div class="flight-city">${flight.departureCity}</div>
                        <div class="flight-arrow">→</div>
                        <div class="flight-city">${flight.arrivalCity}</div>
                    </div>
                    <div class="divider"></div>
                    <div class="flight-info-item">
                        <span class="flight-info-label">Hãng bay:</span>
                        <span class="flight-info-value">${flight.airline}</span>
                    </div>
                    <div class="flight-info-item">
                        <span class="flight-info-label">Số hiệu:</span>
                        <span class="flight-info-value">${flight.flightNumber}</span>
                    </div>
                    <div class="flight-info-item">
                        <span class="flight-info-label">Khởi hành:</span>
                        <span class="flight-info-value">
                            <fmt:formatDate value="${flight.departureTime}" pattern="HH:mm, dd/MM/yyyy"/>
                        </span>
                    </div>
                    <div class="flight-info-item">
                        <span class="flight-info-label">Hạ cánh:</span>
                        <span class="flight-info-value">
                            <fmt:formatDate value="${flight.arrivalTime}" pattern="HH:mm, dd/MM/yyyy"/>
                        </span>
                    </div>
                </div>

                <div class="price-breakdown">
                    <div class="price-row">
                        <span>Giá vé (x<span id="passengerDisplay">1</span>)</span>
                        <span class="price-amount" id="basePrice">
                            <fmt:formatNumber value="${flight.price}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                        </span>
                    </div>
                    <div class="price-row">
                        <span>Thuế Và Phí</span>
                        <span class="price-amount">0₫</span>
                    </div>
                    <div class="price-row total">
                        <span>Tổng cộng</span>
                        <span class="price-amount" id="totalPrice">
                            <fmt:formatNumber value="${flight.price}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                        </span>
                    </div>
                </div>

                <button type="submit" class="btn-submit" onclick="submitBooking()">
                    Xác nhận đặt vé
                </button>
            </div>
        </div>
    </div>

    <script>
        const basePrice = ${flight.price};
        let currentPassengers = 1;

        function updatePrice() {
            const total = basePrice * currentPassengers;
            document.getElementById('passengerDisplay').textContent = currentPassengers;
            document.getElementById('totalPrice').textContent = 
                new Intl.NumberFormat('vi-VN').format(total) + '₫';
        }

        function increasePassengers() {
            if (currentPassengers < 10) {
                currentPassengers++;
                document.getElementById('numPassengers').value = currentPassengers;
                updatePrice();
            }
        }

        function decreasePassengers() {
            if (currentPassengers > 1) {
                currentPassengers--;
                document.getElementById('numPassengers').value = currentPassengers;
                updatePrice();
            }
        }

        function submitBooking() {
            document.querySelector('form').submit();
        }

        // Add smooth animations on load
        window.addEventListener('load', function() {
            document.querySelectorAll('.card').forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });
        });
    </script>
</body>
</html>