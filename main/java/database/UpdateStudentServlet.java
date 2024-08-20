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


@WebServlet("/updateStudent")
public class UpdateStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sno = request.getParameter("Sno");
        String clno = request.getParameter("Clno");
        String dno = request.getParameter("Dno");
        String sname = request.getParameter("Sname");
        String ssex = request.getParameter("Ssex");
        Integer sbirth = 0;
        String sbirthParam = request.getParameter("Sbirth");
        if (sbirthParam != null && !sbirthParam.isEmpty()) {
            try {
                sbirth = Integer.valueOf(sbirthParam);
            } catch (NumberFormatException e) {

            }
        }
        String sprovince = request.getParameter("Sprovince");
        String scity = request.getParameter("Scity");
        AdminDAO adminDAO = new AdminDAO();
        boolean success = adminDAO.updateStudent(sno,clno,dno,sname,ssex,sbirth,sprovince,scity);

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


