package database;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

import dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.AdminDAO;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


@WebServlet("/updateScore")
public class UpdateScoreServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sno = request.getParameter("Sno");
        String tno = request.getParameter("Tno");
        String cno = request.getParameter("Cno");
        Integer score = 0;
        String scoreParam = request.getParameter("score");
        if (scoreParam != null && !scoreParam.isEmpty()) {
            try {
                score = Integer.valueOf(scoreParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }
        String status = request.getParameter("status");


        StudentDAO studentDAO=new StudentDAO();
        boolean success = studentDAO.updateScore(sno,tno,cno,score,status);

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


