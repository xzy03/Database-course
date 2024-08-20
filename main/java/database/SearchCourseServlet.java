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

@WebServlet("/searchCourse")
public class SearchCourseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cno = request.getParameter("Cno");
        String cname = request.getParameter("Cname");
        Integer cyear = null;
        String cyearParam = request.getParameter("Cyear");
        if (cyearParam != null && !cyearParam.isEmpty()) {
            try {
                cyear = Integer.valueOf(cyearParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }
        Integer period = null;
        String periodParam = request.getParameter("Period");
        if (periodParam != null && !periodParam.isEmpty()) {
            try {
                period = Integer.valueOf(periodParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }
        String way = request.getParameter("Way");
        String curriculum = request.getParameter("Curriculum");
        Float credit = null;
        String creditParam = request.getParameter("Credit");
        if (creditParam != null && !creditParam.isEmpty()) {
            try {
                credit = Float.valueOf(creditParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }

        AdminDAO adminDAO=new AdminDAO();
        List<Course> courses = adminDAO.searchCourse(cno,cname,cyear,period,way,curriculum,credit);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(courses));
        out.flush();
    }
}