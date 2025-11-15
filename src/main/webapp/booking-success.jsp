<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt vé thành công - SkyBooking</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            overflow: hidden; /* Tránh thanh cuộn khi máy bay bay */
        }

        .success-container {
            background: white;
            border-radius: 30px;
            padding: 3rem;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            text-align: center;
            animation: slideUp 0.6s ease;
            position: relative;
            z-index: 10;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-icon {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: white;
            margin: 0 auto 2rem;
            animation: scaleIn 0.5s ease 0.3s both;
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.3);
        }

        @keyframes scaleIn {
            0% { transform: scale(0); opacity: 0; }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); opacity: 1; }
        }

        .success-title {
            font-size: 2.5rem;
            color: #1e293b;
            margin-bottom: 1rem;
            font-weight: bold;
            animation: fadeIn 0.6s ease 0.5s both;
        }

        .success-message {
            font-size: 1.1rem;
            color: #64748b;
            margin-bottom: 2rem;
            line-height: 1.6;
            animation: fadeIn 0.6s ease 0.7s both;
        }

        .booking-id {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            padding: 1.5rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            border-left: 4px solid #3b82f6;
            animation: fadeIn 0.6s ease 0.9s both;
        }

        .booking-id-label {
            font-size: 0.9rem;
            color: #64748b;
            margin-bottom: 0.5rem;
        }

        .booking-id-value {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: 2px;
        }

        .info-box {
            background: #fef3c7;
            padding: 1.5rem;
            border-radius: 16px;
            border-left: 4px solid #f59e0b;
            margin-bottom: 2rem;
            text-align: left;
            animation: fadeIn 0.6s ease 1.1s both;
        }

        .info-box h4 { color: #92400e; margin-bottom: 0.8rem; font-size: 1.1rem; }
        .info-box ul { list-style: none; padding: 0; }
        .info-box li { color: #78350f; margin-bottom: 0.5rem; padding-left: 1.5rem; position: relative; }
        .info-box li::before { content: '✓'; position: absolute; left: 0; color: #f59e0b; font-weight: bold; }

        .action-buttons {
            display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;
            animation: fadeIn 0.6s ease 1.3s both;
        }

        .btn {
            padding: 1rem 2rem; border: none; border-radius: 12px; font-size: 1rem; font-weight: 600;
            cursor: pointer; transition: all 0.3s ease; text-decoration: none; display: inline-block;
        }

        .btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4); }

        .btn-secondary { background: white; color: #667eea; border: 2px solid #667eea; }
        .btn-secondary:hover { background: #667eea; color: white; transform: translateY(-2px); box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3); }

        /* Animation Keyframes */
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        /* Confetti */
        .confetti {
            position: fixed; width: 10px; height: 10px;
            animation: confetti-fall 3s linear forwards;
            z-index: 5;
        }
        @keyframes confetti-fall { to { transform: translateY(100vh) rotate(360deg); opacity: 0; } }

        /* Plane Animation */
        .plane-animation {
            position: fixed; font-size: 4rem;
            animation: flyAcross 6s linear infinite;
            z-index: 1; opacity: 0.8;
        }
        @keyframes flyAcross {
            0% { left: -150px; top: 20%; transform: rotate(10deg); }
            100% { left: 110vw; top: -10%; transform: rotate(10deg); }
        }
        
        @media (max-width: 768px) {
            .success-container { padding: 2rem; }
            .success-title { font-size: 2rem; }
            .booking-id-value { font-size: 2rem; }
        }
    </style>
</head>
<body>
    <div class="plane-animation">✈️</div>

    <div class="success-container">
        <div class="success-icon">✓</div>
        
        <h1 class="success-title">Đặt vé thành công!</h1>
        
        <p class="success-message">
            Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ của SkyBooking. 
            Thông tin đặt vé đã được gửi đến email của bạn.
        </p>

        <div class="booking-id">
            <div class="booking-id-label">Mã đặt vé của bạn:</div>
            <div class="booking-id-value">#${param.id}</div>
        </div>

        <div class="info-box">
            <h4>📧 Thông tin quan trọng:</h4>
            <ul>
                <li>Vui lòng kiểm tra email (hoặc mục Spam) để xem chi tiết vé</li>
                <li>Mang theo CMND/CCCD khi làm thủ tục</li>
                <li>Có mặt tại sân bay trước 90 phút</li>
                <li>Lưu mã đặt vé để tra cứu tại quầy</li>
            </ul>
        </div>

        <div class="action-buttons">
            <a href="index.jsp" class="btn btn-primary">Đặt vé mới</a>
            <a href="myBookings" class="btn btn-secondary">Xem lịch sử đặt vé</a>
        </div>
    </div>

    <script>
        // Hiệu ứng pháo giấy
        function createConfetti() {
            const colors = ['#667eea', '#764ba2', '#10b981', '#f59e0b', '#ef4444', '#3b82f6'];
            for (let i = 0; i < 60; i++) {
                setTimeout(() => {
                    const confetti = document.createElement('div');
                    confetti.className = 'confetti';
                    confetti.style.left = Math.random() * 100 + '%';
                    confetti.style.top = -10 + 'px';
                    confetti.style.background = colors[Math.floor(Math.random() * colors.length)];
                    confetti.style.animationDelay = Math.random() * 2 + 's';
                    document.body.appendChild(confetti);
                    
                    setTimeout(() => { confetti.remove(); }, 3000);
                }, i * 30);
            }
        }

        // Chạy hiệu ứng khi tải trang
        window.addEventListener('load', createConfetti);
    </script>
</body>
</html>