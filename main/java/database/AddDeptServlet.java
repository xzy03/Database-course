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


@WebServlet("/addDept")
public class AddDeptServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dno = request.getParameter("Dno");
        String dname = request.getParameter("Dname");
        Integer dnumber = 0;
        AdminDAO adminDAO = new AdminDAO();
        boolean success = adminDAO.addDept(dno,dname,dnumber);

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


