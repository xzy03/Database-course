package database;

import dao.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userLogin")
public class UserLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginName = request.getParameter("loginName");
        String password = request.getParameter("password");

        // 验证登录
        UserDAO userDAO=new UserDAO();
        User user = userDAO.login(loginName, password);
        if (user != null) {
            request.getSession().setAttribute("user", user);

            // 创建一个 Cookie 并设置其过期时间为7天
            Cookie loginCookie = new Cookie("userLogin", loginName);
            loginCookie.setMaxAge(7 * 24 * 60 * 60); // 7天
            response.addCookie(loginCookie);
            response.sendRedirect("userDashboard.jsp");
        } else {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<html><body><h3>用户名或密码错误</h3>");
            response.getWriter().println("<p>5 秒后自动返回 userlogin.jsp</p>");
            response.getWriter().println("<script>setTimeout(function(){window.location.href='userlogin.jsp';}, 5000);</script>");
            response.getWriter().println("</body></html>");
        }
    }
}

