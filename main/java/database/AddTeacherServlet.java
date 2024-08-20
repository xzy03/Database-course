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


@WebServlet("/addTeacher")
public class AddTeacherServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tno = request.getParameter("Tno");
        String tname = request.getParameter("Tname");
        String tsex = request.getParameter("Tsex");
        Integer tbirth = 0;
        String tbirthParam = request.getParameter("Tbirth");
        if (tbirthParam != null && !tbirthParam.isEmpty()) {
            try {
                tbirth = Integer.valueOf(tbirthParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }
        String tposition = request.getParameter("Tposition");
        String tphone = request.getParameter("Tphone");
        AdminDAO adminDAO = new AdminDAO();
        boolean success = adminDAO.addTeacher(tno,tname,tsex,tbirth,tposition,tphone);

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


