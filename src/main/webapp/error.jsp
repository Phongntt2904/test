<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng nhập - SkyBooking</title>
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
}

.login-container {
	background: white;
	border-radius: 30px;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
	overflow: hidden;
	max-width: 1000px;
	width: 100%;
	display: grid;
	grid-template-columns: 1fr 1fr;
	animation: slideUp 0.6s ease;
}

@
keyframes slideUp {from { opacity:0;
	transform: translateY(50px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.login-left {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	padding: 3rem;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	color: white;
	text-align: center;
}

.login-left h1 {
	font-size: 2.5rem;
	margin-bottom: 1rem;
}

.login-left p {
	font-size: 1.1rem;
	opacity: 0.9;
	margin-bottom: 2rem;
}

.login-illustration {
	font-size: 8rem;
	animation: float 3s ease-in-out infinite;
}

@
keyframes float { 0%, 100% {
	transform: translateY(0px);
}

50




%
{
transform




:




translateY


(




-20px




)


;
}
}
.login-right {
	padding: 3rem;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.form-title {
	font-size: 2rem;
	color: #1e293b;
	margin-bottom: 0.5rem;
}

.form-subtitle {
	color: #64748b;
	margin-bottom: 2rem;
}

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

.success-message {
	background: #d1fae5;
	border-left: 4px solid #10b981;
	color: #065f46;
	padding: 1rem;
	border-radius: 8px;
	margin-bottom: 1.5rem;
	display: flex;
	align-items: center;
	gap: 0.5rem;
}

.form-group {
	margin-bottom: 1.5rem;
}

.form-group label {
	display: block;
	font-weight: 600;
	margin-bottom: 0.5rem;
	color: #334155;
}

.form-group input {
	width: 100%;
	padding: 1rem;
	border: 2px solid #e2e8f0;
	border-radius: 12px;
	font-size: 1rem;
	transition: all 0.3s ease;
}

.form-group input:focus {
	outline: none;
	border-color: #667eea;
	box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.form-options {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 1.5rem;
}

.remember-me {
	display: flex;
	align-items: center;
	gap: 0.5rem;
}

.remember-me input[type="checkbox"] {
	width: 18px;
	height: 18px;
	cursor: pointer;
}

.forgot-password {
	color: #667eea;
	text-decoration: none;
	font-size: 0.9rem;
}

.forgot-password:hover {
	text-decoration: underline;
}

.btn-login {
	width: 100%;
	padding: 1rem;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	border: none;
	border-radius: 12px;
	font-size: 1.1rem;
	font-weight: 700;
	cursor: pointer;
	transition: all 0.3s ease;
}

.btn-login:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
}

.divider {
	display: flex;
	align-items: center;
	margin: 1.5rem 0;
}

.divider::before, .divider::after {
	content: '';
	flex: 1;
	height: 1px;
	background: #e2e8f0;
}

.divider span {
	padding: 0 1rem;
	color: #64748b;
	font-size: 0.9rem;
}

.register-link {
	text-align: center;
	color: #64748b;
}

.register-link a {
	color: #667eea;
	text-decoration: none;
	font-weight: 600;
}

.register-link a:hover {
	text-decoration: underline;
}

.back-home {
	text-align: center;
	margin-top: 1rem;
}

.back-home a {
	color: #667eea;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 0.5rem;
}

.back-home a:hover {
	text-decoration: underline;
}

@media ( max-width : 768px) {
	.login-container {
		grid-template-columns: 1fr;
	}
	.login-left {
		display: none;
	}
	.login-right {
		padding: 2rem;
	}
}
</style>
</head>
<body>
	<div class="login-container">
		<div class="login-left">
			<div class="login-illustration">✈️</div>
			<h1>Chào mừng trở lại!</h1>
			<p>Đăng nhập để tiếp tục đặt vé máy bay với SkyBooking</p>
		</div>

		<div class="login-right">
			<h2 class="form-title">Đăng nhập</h2>
			<p class="form-subtitle">Nhập thông tin để truy cập tài khoản của
				bạn</p>

			<c:if test="${not empty error}">
				<div class="error-message">
					<span>⚠️</span> <span>${error}</span>
				</div>
			</c:if>

			<c:if test="${not empty success}">
				<div class="success-message">
					<span>✓</span> <span>${success}</span>
				</div>
			</c:if>

			<form action="login" method="post">
				<div class="form-group">
					<label>Tên đăng nhập</label> <input type="text" name="username"
						placeholder="Nhập tên đăng nhập" required>
				</div>

				<div class="form-group">
					<label>Mật khẩu</label> <input type="password" name="password"
						placeholder="Nhập mật khẩu" required>
				</div>

				<div class="form-options">
					<label class="remember-me"> <input type="checkbox"
						name="remember"> <span>Ghi nhớ đăng nhập</span>
					</label> <a href="#" class="forgot-password">Quên mật khẩu?</a>
				</div>

				<button type="submit" class="btn-login">Đăng nhập</button>
			</form>

			<div class="divider">
				<span>hoặc</span>
			</div>

			<p class="register-link">
				Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a>
			</p>

			<div class="back-home">
				<a href="index.jsp">← Quay về trang chủ</a>
			</div>
		</div>
	</div>
</body>
</html>