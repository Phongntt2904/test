package filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import model.User;

// --- QUAN TRỌNG: Chỉ cần chặn thư mục admin ---
@WebFilter("/admin/*")
public class AdminFilter implements Filter {
    
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Nếu không phải admin -> Đẩy về trang login (Dùng ../ để thoát ra khỏi thư mục admin)
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=AccessDenied");
        } else {
            chain.doFilter(req, res);
        }
    }

    public void init(FilterConfig f) {}
    public void destroy() {}
}