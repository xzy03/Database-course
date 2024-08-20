package database;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.*;

@WebServlet("/searchClass")
public class SearchClassServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clno = request.getParameter("Clno");
        String clname = request.getParameter("Clname");
        Integer clnumber = null;
        String clnumberParam = request.getParameter("Clnumber");
        if (clnumberParam != null && !clnumberParam.isEmpty()) {
            try {
                clnumber = Integer.valueOf(clnumberParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }
        String dno = request.getParameter("Dno");

        AdminDAO adminDAO=new AdminDAO();
        List<Class> classes = adminDAO.searchClass(clno,clname,clnumber,dno);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(classes));
        out.flush();
    }
}