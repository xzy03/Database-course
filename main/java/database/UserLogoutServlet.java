package database;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/userLogout")
public class UserLogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().invalidate();

        // 删除登录 Cookie
        Cookie loginCookie = new Cookie("userLogin", "");
        loginCookie.setMaxAge(0);
        response.addCookie(loginCookie);

        response.sendRedirect("userlogin.jsp");
    }
}
