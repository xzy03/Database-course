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

@WebServlet("/searchTeach")
public class SearchTeachServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cno = request.getParameter("Cno");
        String tno = request.getParameter("Tno");
        String time = request.getParameter("Time");
        Integer maxnum = null;
        String maxnumParam = request.getParameter("Maxnum");
        if (maxnumParam != null && !maxnumParam.isEmpty()) {
            try {
                maxnum = Integer.valueOf(maxnumParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }
        Integer choosenum = null;
        String choosenumParam = request.getParameter("Choosenum");
        if (choosenumParam != null && !choosenumParam.isEmpty()) {
            try {
                choosenum = Integer.valueOf(choosenumParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }


        AdminDAO adminDAO=new AdminDAO();
        List<Teach> teaches = adminDAO.searchTeach(cno,tno,time,maxnum,choosenum);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(teaches));
        out.flush();
    }
}