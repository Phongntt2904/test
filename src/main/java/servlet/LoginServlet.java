package servlet;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private UserDAO userDAO;

	@Override
	public void init() throws ServletException {
		userDAO = new UserDAO();
	}

	// GET - Hiển thị trang đăng nhập
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	// POST - Xử lý đăng nhập
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// Validate input
		if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
			return;
		}

		// Kiểm tra đăng nhập
		User user = userDAO.login(username, password);

		if (user != null) {
			// Đăng nhập thành công
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			session.setAttribute("userId", user.getUserId());
			session.setAttribute("username", user.getUsername());
			session.setAttribute("fullName", user.getFullName());
			session.setAttribute("role", user.getRole());

			// Chuyển về trang chủ
			response.sendRedirect("index.jsp");
		} else {
			// Đăng nhập thất bại
			request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
	}
}