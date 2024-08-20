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


@WebServlet("/updateClass")
public class UpdateClassServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clno = request.getParameter("Clno");
        String clname = request.getParameter("Clname");
        String dno = request.getParameter("Dno");
        AdminDAO adminDAO = new AdminDAO();
        boolean success = adminDAO.updateClass(clno,clname,dno);

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


