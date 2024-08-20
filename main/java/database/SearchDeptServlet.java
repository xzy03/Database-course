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

@WebServlet("/searchDept")
public class SearchDeptServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dno = request.getParameter("Dno");
        String dname = request.getParameter("Dname");
        Integer dnumber = null;
        String dnumberParam = request.getParameter("Dnumber");
        if (dnumberParam != null && !dnumberParam.isEmpty()) {
            try {
                dnumber = Integer.valueOf(dnumberParam);
            } catch (NumberFormatException e) {
                // 处理异常
            }
        }

        AdminDAO adminDAO=new AdminDAO();
        List<Dept> depts = adminDAO.searchDept(dno,dname,dnumber);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(depts));
        out.flush();
    }
}