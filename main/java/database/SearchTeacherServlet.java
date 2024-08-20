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

@WebServlet("/searchTeacher")
public class SearchTeacherServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tno = request.getParameter("Tno");
        String tname = request.getParameter("Tname");
        String tsex = request.getParameter("Tsex");
        Integer tbirth = null;
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

        AdminDAO adminDAO=new AdminDAO();
        List<Teacher> teachers = adminDAO.searchTeacher(tno,tname,tsex,tbirth,tposition,tphone);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(teachers));
        out.flush();
    }
}