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

@WebServlet("/searchScore")
public class SearchScoreServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sno = request.getParameter("Sno");
        String tno = request.getParameter("Tno");
        String cno = request.getParameter("Cno");
        Integer score = null;
        String scoreParam = request.getParameter("score");
        if (scoreParam != null && !scoreParam.isEmpty()) {
            try {
                score = Integer.valueOf(scoreParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }
        Float grade = null;
        String gradeParam = request.getParameter("grade");
        if (gradeParam != null && !gradeParam.isEmpty()) {
            try {
                grade = Float.valueOf(gradeParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }
        String status = request.getParameter("status");


        AdminDAO adminDAO=new AdminDAO();
        List<Score> scores = adminDAO.searchScore(sno,tno,cno,score,grade,status);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(scores));
        out.flush();
    }
}