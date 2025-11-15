<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty param.lang}"><c:set var="lang" value="${param.lang}" scope="session"/></c:if>
<c:if test="${empty sessionScope.lang}"><c:set var="lang" value="vi" scope="session"/></c:if>
<fmt:setLocale value="${sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><fmt:message key="auth.register.title"/> - SkyBooking</title>
<style>
/* --- CSS GỐC --- */
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh; padding: 2rem;
}
.register-container {
    background: white; border-radius: 30px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    max-width: 600px; margin: 0 auto; padding: 3rem;
    animation: slideUp 0.6s ease;
}
@keyframes slideUp { from { opacity:0; transform: translateY(50px); } to { opacity: 1; transform: translateY(0); } }

.register-header { text-align: center; margin-bottom: 2rem; }
.register-icon { font-size: 4rem; margin-bottom: 1rem; }
.form-title { font-size: 2rem; color: #1e293b; margin-bottom: 0.5rem; }
.form-subtitle { color: #64748b; }
.error-message { background: #fee2e2; border-left: 4px solid #ef4444; color: #991b1b; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; }

.form-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1.5rem; }
.form-group { margin-bottom: 1.5rem; }
.form-group.full-width { grid-column: 1/-1; }
.form-group label { display: block; font-weight: 600; margin-bottom: 0.5rem; color: #334155; }
.required { color: #ef4444; }
.form-group input { width: 100%; padding: 1rem; border: 2px solid #e2e8f0; border-radius: 12px; font-size: 1rem; transition: all 0.3s ease; }
.form-group input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1); }

.password-strength { height: 4px; background: #e2e8f0; border-radius: 2px; margin-top: 0.5rem; overflow: hidden; }
.password-strength-bar { height: 100%; width: 0%; transition: all 0.3s ease; }
.password-strength-bar.weak { width: 33%; background: #ef4444; }
.password-strength-bar.medium { width: 66%; background: #f59e0b; }
.password-strength-bar.strong { width: 100%; background: #10b981; }

.btn-register { width: 100%; padding: 1rem; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 12px; font-size: 1.1rem; font-weight: 700; cursor: pointer; transition: all 0.3s ease; margin-top: 1rem; }
.btn-register:hover { transform: translateY(-2px); box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4); }

.terms { text-align: center; margin-top: 1rem; font-size: 0.9rem; color: #64748b; }
.terms a { color: #667eea; text-decoration: none; }
.terms a:hover { text-decoration: underline; }

.login-link { text-align: center; margin-top: 1.5rem; color: #64748b; }
.login-link a { color: #667eea; text-decoration: none; font-weight: 600; }
.login-link a:hover { text-decoration: underline; }

@media (max-width: 768px) { .register-container { padding: 2rem; } .form-grid { grid-template-columns: 1fr; } }

/* NÚT NGÔN NGỮ CỐ ĐỊNH */
.lang-fixed { position: fixed; top: 20px; left: 20px; z-index: 9999; }
.lang-dropdown { position: relative; display: inline-block; }
.dropbtn {
    background: rgba(255, 255, 255, 0.25); color: white;
    padding: 8px 15px; border-radius: 30px; border: 1px solid rgba(255,255,255,0.4);
    cursor: pointer; display: flex; align-items: center; gap: 8px;
    font-weight: 600; font-family: 'Segoe UI', sans-serif; backdrop-filter: blur(4px);
    transition: 0.3s;
}
.dropbtn:hover { background: rgba(255, 255, 255, 0.4); }
.dropdown-content {
    display: none; position: absolute; top: 110%; left: 0;
    background: white; min-width: 140px; border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2); overflow: hidden;
}
.lang-dropdown:hover .dropdown-content { display: block; animation: fadeIn 0.3s; }
.dropdown-content a {
    display: flex; align-items: center; gap: 10px; padding: 10px 15px;
    color: #333; text-decoration: none; font-size: 0.9rem; transition: 0.2s;
}
.dropdown-content a:hover { background: #f3f4f6; color: #667eea; }
.flag-icon { width: 22px; height: 15px; object-fit: cover; border-radius: 3px; }
@keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
</style>
</head>
<body>

    <div class="lang-fixed">
        <div class="lang-dropdown">
            <button class="dropbtn">
                <c:choose>
                    <c:when test="${sessionScope.lang == 'en'}"><img src="https://flagcdn.com/w40/us.png" class="flag-icon"> English ▾</c:when>
                    <c:when test="${sessionScope.lang == 'ko'}"><img src="https://flagcdn.com/w40/kr.png" class="flag-icon"> 한국어 ▾</c:when>
                    <c:otherwise><img src="https://flagcdn.com/w40/vn.png" class="flag-icon"> Tiếng Việt ▾</c:otherwise>
                </c:choose>
            </button>
            <div class="dropdown-content">
                <a href="?lang=vi"><img src="https://flagcdn.com/w40/vn.png" class="flag-icon"> Tiếng Việt</a>
                <a href="?lang=en"><img src="https://flagcdn.com/w40/us.png" class="flag-icon"> English</a>
                <a href="?lang=ko"><img src="https://flagcdn.com/w40/kr.png" class="flag-icon"> 한국어</a>
            </div>
        </div>
    </div>

    <div class="register-container">
        <div class="register-header">
            <div class="register-icon">🚀</div>
            <h2 class="form-title"><fmt:message key="auth.register.title"/></h2>
            <p class="form-subtitle"><fmt:message key="auth.register.subtitle"/></p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">⚠️ ${error}</div>
        </c:if>

        <form action="register" method="post">
            <div class="form-grid">
                <div class="form-group full-width">
                    <label><fmt:message key="auth.fullname"/> <span class="required">*</span></label>
                    <input type="text" name="fullName" placeholder="<fmt:message key='auth.fullname'/>" required>
                </div>

                <div class="form-group">
                    <label><fmt:message key="auth.username"/> <span class="required">*</span></label>
                    <input type="text" name="username" placeholder="<fmt:message key='auth.username'/>" required>
                </div>

                <div class="form-group">
                    <label><fmt:message key="auth.email"/> <span class="required">*</span></label>
                    <input type="email" name="email" placeholder="example@email.com" required>
                </div>

                <div class="form-group full-width">
                    <label><fmt:message key="auth.phone"/></label>
                    <input type="tel" name="phone" placeholder="<fmt:message key='auth.phone'/>">
                </div>

                <div class="form-group">
                    <label><fmt:message key="auth.password"/> <span class="required">*</span></label>
                    <input type="password" name="password" id="password" placeholder="<fmt:message key='auth.password'/>" required onkeyup="checkPasswordStrength()">
                    <div class="password-strength"><div class="password-strength-bar" id="strengthBar"></div></div>
                </div>

                <div class="form-group">
                    <label><fmt:message key="auth.confirm_pass"/> <span class="required">*</span></label>
                    <input type="password" name="confirmPassword" placeholder="<fmt:message key='auth.confirm_pass'/>" required>
                </div>
            </div>

            <button type="submit" class="btn-register"><fmt:message key="auth.btn.register"/></button>

            <p class="terms">
                <fmt:message key="auth.terms.text"/> 
                <a href="#"><fmt:message key="auth.terms.service"/></a> 
                <fmt:message key="auth.terms.and"/> 
                <a href="#"><fmt:message key="auth.terms.privacy"/></a>
            </p>
        </form>

        <p class="login-link">
            <fmt:message key="auth.have_account"/>
            <a href="login.jsp"><fmt:message key="auth.login_now"/></a>
        </p>
    </div>
    
    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('strengthBar');
            let strength = 0;
            if (password.length >= 8) strength++;
            if (password.match(/[a-z]+/)) strength++;
            if (password.match(/[A-Z]+/)) strength++;
            if (password.match(/[0-9]+/)) strength++;
            if (password.match(/[$@#&!]+/)) strength++;
            strengthBar.className = 'password-strength-bar';
            if (strength <= 2) strengthBar.classList.add('weak');
            else if (strength <= 4) strengthBar.classList.add('medium');
            else strengthBar.classList.add('strong');
        }
    </script>
</body>
</html>