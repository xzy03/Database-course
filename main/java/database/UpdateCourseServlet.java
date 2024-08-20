package database;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.AdminDAO;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


@WebServlet("/updateCourse")
public class UpdateCourseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cno = request.getParameter("Cno");
        String cname = request.getParameter("Cname");
        Integer cyear = 0;
        String cyearParam = request.getParameter("Cyear");
        if (cyearParam != null && !cyearParam.isEmpty()) {
            try {
                cyear = Integer.valueOf(cyearParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }
        Integer period = 0;
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
        Float credit = 0.0f;
        String creditParam = request.getParameter("Credit");
        if (creditParam != null && !creditParam.isEmpty()) {
            try {
                credit = Float.valueOf(creditParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }

        AdminDAO adminDAO = new AdminDAO();
        boolean success = adminDAO.updateCourse(cno,cname,cyear,period,way,curriculum,credit);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.write(new Gson().toJson(new Result(success)));
        out.close();
    }

    class Result {
        boolean success;

        Result(boolean success) {
            this.success = success;
        }
    }
}


