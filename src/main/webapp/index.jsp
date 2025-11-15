<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty param.lang}"><c:set var="lang" value="${param.lang}" scope="session"/></c:if>
<c:if test="${empty sessionScope.lang}"><c:set var="lang" value="vi" scope="session"/></c:if>
<fmt:setLocale value="${sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
<meta charset="UTF-8">
<title><fmt:message key="brand.name"/></title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<style>
    /* GLOBAL */
    body { font-family: 'Poppins', sans-serif; margin: 0; background-color: #f0f2f5; color: #333; }
    
    /* HEADER */
    .header { 
        position: fixed; top: 0; left: 0; right: 0;
        background: rgba(255,255,255,0.98); 
        padding: 0 40px; /* Giảm padding trên dưới để header gọn */
        height: 80px;
        display: flex; justify-content: space-between; align-items: center; 
        z-index: 1000; box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
        box-sizing: border-box;
    }

    .logo { 
        font-weight: 800; font-size: 1.6rem; color: #4f46e5; text-decoration: none; 
        display: flex; align-items: center; gap: 8px; 
    }

    .right-nav { display: flex; align-items: center; gap: 20px; height: 100%; }

    /* --- SỬA LỖI DROPDOWN BIẾN MẤT NHANH --- */
    .lang-dropdown { 
        position: relative; 
        height: 100%; /* Kéo dài chiều cao để dễ hover */
        display: flex; 
        align-items: center;
    }

    .dropbtn {
        background-color: transparent; border: 1px solid #e5e7eb;
        padding: 6px 12px; border-radius: 20px;
        cursor: pointer; display: flex; align-items: center; gap: 8px;
        transition: 0.3s; font-weight: 500; font-size: 0.9rem;
    }
    .dropbtn:hover { background-color: #f9fafb; border-color: #4f46e5; }
    .current-flag { width: 24px; height: 16px; object-fit: cover; border-radius: 3px; }

    /* Menu xổ xuống */
    .dropdown-content {
        display: none;
        position: absolute;
        right: 0;
        top: 60px; /* Đẩy xuống một chút */
        background-color: #fff;
        min-width: 150px;
        box-shadow: 0px 10px 30px rgba(0,0,0,0.15);
        z-index: 2000;
        border-radius: 12px;
        overflow: hidden;
        border: 1px solid #f0f0f0;
        
        /* Mẹo sửa lỗi: Thêm lớp đệm vô hình để chuột không bị trượt ra ngoài */
        padding-top: 5px; 
    }

    /* Logic hover chuẩn */
    .lang-dropdown:hover .dropdown-content { display: block; animation: fadeIn 0.2s; }

    .dropdown-content a {
        color: #333; padding: 12px 15px; text-decoration: none;
        display: flex; align-items: center; gap: 10px;
        font-size: 0.9rem; transition: 0.2s; border-bottom: 1px solid #f9fafb;
    }
    .dropdown-content a:hover { background-color: #f0fdf4; color: #166534; }
    .list-flag { width: 20px; height: 14px; object-fit: cover; border-radius: 2px; }

    /* USER LINKS */
    .user-links { display: flex; align-items: center; gap: 15px; }
    .user-links a { text-decoration: none; font-weight: 600; color: #333; font-size: 0.95rem; }
    .btn-login { color: #4f46e5 !important; }
    .btn-register { background: #4f46e5; color: white !important; padding: 10px 25px; border-radius: 30px; transition: 0.3s; }
    .btn-register:hover { background: #4338ca; transform: translateY(-2px); }

    /* HERO */
    .hero { margin-top: 80px; padding: 40px 20px; background: linear-gradient(135deg, #667eea, #764ba2); color: white; text-align: center; min-height: 80vh; display: flex; flex-direction: column; justify-content: center; align-items: center; }
    .hero h1 { font-size: 3.5rem; margin: 0 0 10px 0; text-shadow: 0 4px 10px rgba(0,0,0,0.2); }
    .hero p { font-size: 1.3rem; opacity: 0.9; }

    /* SEARCH BOX - SỬA LỖI ĐÈ NHAU */
    .search-box { 
        background: white; padding: 35px; border-radius: 20px; 
        box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25); 
        margin-top: 50px; max-width: 1100px; width: 100%; text-align: left; 
    }
    
    .search-form { 
        display: grid; 
        /* Chia 4 cột đều nhau, khoảng cách rộng ra */
        grid-template-columns: 1.5fr 1.5fr 1fr 0.8fr; 
        gap: 25px; 
        align-items: end; /* Căn đáy để nút và input thẳng hàng */
    }
    
    .full-width-btn { grid-column: span 4; margin-top: 20px; }
    
    .form-group label { display: block; color: #4b5563; font-weight: 600; margin-bottom: 10px; font-size: 0.95rem; }
    
    /* Input box-sizing để không bị tràn */
    .form-group input, .form-group select { 
        width: 100%; padding: 14px; border: 2px solid #e2e8f0; border-radius: 12px; 
        font-size: 1rem; outline: none; transition: 0.3s; 
        box-sizing: border-box; background: white; color: #333;
    }
    .form-group input:focus, .form-group select:focus { border-color: #4f46e5; box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1); }
    
    .btn-search { width: 100%; background: linear-gradient(to right, #4f46e5, #6366f1); color: white; border: none; padding: 16px; border-radius: 12px; font-weight: bold; cursor: pointer; font-size: 1.1rem; transition: transform 0.2s; }
    .btn-search:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(79, 70, 229, 0.4); }

    .footer { background: #1f2937; color: white; text-align: center; padding: 40px; margin-top: auto; }
    
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    @media (max-width: 1000px) { .search-form { grid-template-columns: 1fr 1fr; } .full-width-btn { grid-column: span 2; } }
    @media (max-width: 600px) { .search-form { grid-template-columns: 1fr; } .full-width-btn { grid-column: span 1; } }
</style>
</head>
<body>

    <header class="header">
        <a href="index.jsp" class="logo">✈️ <fmt:message key="brand.name"/></a>
        
        <div class="right-nav">
            <div class="lang-dropdown">
                <button class="dropbtn">
                    <c:choose>
                        <c:when test="${sessionScope.lang == 'en'}"><img src="https://flagcdn.com/w40/us.png" class="current-flag"> English</c:when>
                        <c:when test="${sessionScope.lang == 'ko'}"><img src="https://flagcdn.com/w40/kr.png" class="current-flag"> 한국어</c:when>
                        <c:otherwise><img src="https://flagcdn.com/w40/vn.png" class="current-flag"> Tiếng Việt</c:otherwise>
                    </c:choose>
                    <span style="font-size:10px">▼</span>
                </button>
                
                <div class="dropdown-content">
                    <a href="?lang=vi"><img src="https://flagcdn.com/w40/vn.png" class="list-flag"> Vietnamese</a>
                    <a href="?lang=en"><img src="https://flagcdn.com/w40/us.png" class="list-flag"> English</a>
                    <a href="?lang=ko"><img src="https://flagcdn.com/w40/kr.png" class="list-flag"> Korean</a>
                </div>
            </div>

            <div class="user-links">
                <c:if test="${empty sessionScope.user}">
                    <a href="login.jsp" class="btn-login"><fmt:message key="nav.login"/></a>
                    <a href="register.jsp" class="btn-register"><fmt:message key="nav.register"/></a>
                </c:if>

                <c:if test="${not empty sessionScope.user}">
                    <span><fmt:message key="nav.welcome"/>, ${sessionScope.user.fullName}</span>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <a href="dashboard.jsp" style="color:#d97706; border:1px solid #d97706; padding:5px 12px; border-radius:15px">🛡️ <fmt:message key="nav.admin"/></a>
                    </c:if>
                    <a href="myBookings"><fmt:message key="nav.my_ticket"/></a>
                    <a href="logout" style="color:red"><fmt:message key="nav.logout"/></a>
                </c:if>
            </div>
        </div>
    </header>

    <section class="hero">
        <h1><fmt:message key="hero.title"/></h1>
        <p><fmt:message key="hero.subtitle"/></p>

        <div class="search-box">
            <h3 style="color:#333; margin-top:0; margin-bottom: 25px; display:flex; align-items:center; gap:10px">
                🔍 <fmt:message key="search.title"/>
            </h3>
            
            <form action="searchFlights" method="get" class="search-form">
                
                <div class="form-group">
                    <label>🛫 <fmt:message key="search.from"/></label>
                    <select name="from" required>
                        <option value="" disabled selected>-- Select --</option>
                        <option value="Hà Nội (HAN)">Ha Noi (HAN)</option>
                        <option value="TP.HCM (SGN)">TP.HCM (SGN)</option>
                        <option value="Đà Nẵng (DAD)">Da Nang (DAD)</option>
                        <option value="Phú Quốc (PQC)">Phu Quoc (PQC)</option>
                        <option value="Nha Trang (CXR)">Nha Trang (CXR)</option>
                        <option value="Đà Lạt (DLI)">Da Lat (DLI)</option>
                        <option value="Hải Phòng (HPH)">Hai Phong (HPH)</option>
                        <option value="Cần Thơ (VCA)">Can Tho (VCA)</option>
                        <option value="Vinh (VII)">Vinh (VII)</option>
                        <option value="Huế (HUI)">Hue (HUI)</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>🛬 <fmt:message key="search.to"/></label>
                     <select name="to" required>
                        <option value="" disabled selected>-- Select --</option>
                        <option value="TP.HCM (SGN)">TP.HCM (SGN)</option>
                        <option value="Hà Nội (HAN)">Ha Noi (HAN)</option>
                        <option value="Đà Nẵng (DAD)">Da Nang (DAD)</option>
                        <option value="Phú Quốc (PQC)">Phu Quoc (PQC)</option>
                        <option value="Nha Trang (CXR)">Nha Trang (CXR)</option>
                        <option value="Đà Lạt (DLI)">Da Lat (DLI)</option>
                        <option value="Hải Phòng (HPH)">Hai Phong (HPH)</option>
                        <option value="Cần Thơ (VCA)">Can Tho (VCA)</option>
                        <option value="Vinh (VII)">Vinh (VII)</option>
                        <option value="Huế (HUI)">Hue (HUI)</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>📅 <fmt:message key="search.date"/></label>
                    <input type="date" name="date" required>
                </div>

                <div class="form-group">
                    <label>👥 <fmt:message key="search.passengers"/></label>
                    <select name="passengers">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5+</option>
                    </select>
                </div>

                <div class="full-width-btn">
                    <button type="submit" class="btn-search"><fmt:message key="search.btn"/></button>
                </div>
            </form>
        </div>
    </section>

    <section style="padding: 60px 20px; max-width: 1200px; margin: 0 auto;">
        <h2 style="text-align: center; margin-bottom: 40px; color: #1f2937; font-size: 2rem;"><fmt:message key="feat.title"/></h2>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 30px;">
            <div style="background: white; padding: 30px; border-radius: 15px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                <div style="font-size: 2.5rem; margin-bottom: 15px;">💰</div>
                <h3><fmt:message key="feat.price.title"/></h3>
                <p><fmt:message key="feat.price.desc"/></p>
            </div>
            <div style="background: white; padding: 30px; border-radius: 15px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                <div style="font-size: 2.5rem; margin-bottom: 15px;">⚡</div>
                <h3><fmt:message key="feat.fast.title"/></h3>
                <p><fmt:message key="feat.fast.desc"/></p>
            </div>
            <div style="background: white; padding: 30px; border-radius: 15px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                <div style="font-size: 2.5rem; margin-bottom: 15px;">🔒</div>
                <h3><fmt:message key="feat.secure.title"/></h3>
                <p><fmt:message key="feat.secure.desc"/></p>
            </div>
            <div style="background: white; padding: 30px; border-radius: 15px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                <div style="font-size: 2.5rem; margin-bottom: 15px;">🎧</div>
                <h3><fmt:message key="feat.support.title"/></h3>
                <p><fmt:message key="feat.support.desc"/></p>
            </div>
        </div>
    </section>

    <footer class="footer"><fmt:message key="footer.text"/></footer>
    
    <script>
        const dateInput = document.querySelector('input[type="date"]');
        if(dateInput) {
            const today = new Date().toISOString().split('T')[0];
            dateInput.setAttribute('min', today);
            dateInput.value = today;
        }
    </script>
</body>
</html>