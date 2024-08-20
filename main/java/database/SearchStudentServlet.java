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

@WebServlet("/searchStudent")
public class SearchStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sno = request.getParameter("Sno");
        String clno = request.getParameter("Clno");
        String dno = request.getParameter("Dno");
        String sname = request.getParameter("Sname");
        String ssex = request.getParameter("Ssex");
        Integer sbirth = null;
        String sbirthParam = request.getParameter("Sbirth");
        if (sbirthParam != null && !sbirthParam.isEmpty()) {
            try {
                sbirth = Integer.valueOf(sbirthParam);
            } catch (NumberFormatException e) {

            }
        }
        String sprovince = request.getParameter("Sprovince");
        String scity = request.getParameter("Scity");
        Float minScredit = null;
        String minScreditParam = request.getParameter("MinScredit");
        if (minScreditParam != null && !minScreditParam.isEmpty()) {
            try {
                minScredit = Float.valueOf(minScreditParam);
            } catch (NumberFormatException e) {

            }
        }
        Float maxScredit = null;
        String maxScreditParam = request.getParameter("MaxScredit");
        if (maxScreditParam != null && !maxScreditParam.isEmpty()) {
            try {
                maxScredit = Float.valueOf(maxScreditParam);
            } catch (NumberFormatException e) {

            }
        }
        Float minSGPA = null;
        String minSGPAParam = request.getParameter("MinSGPA");
        if (minSGPAParam != null && !minSGPAParam.isEmpty()) {
            try {
                minSGPA = Float.valueOf(minSGPAParam);
            } catch (NumberFormatException e) {

            }
        }
        Float maxSGPA = null;
        String maxSGPAParam = request.getParameter("MaxSGPA");
        if (maxSGPAParam != null && !maxSGPAParam.isEmpty()) {
            try {
                maxSGPA = Float.valueOf(maxSGPAParam);
            } catch (NumberFormatException e) {

            }
        }
        AdminDAO adminDAO=new AdminDAO();
        List<Student> students = adminDAO.searchStudent(sno,clno,dno,sname,ssex,sbirth,sprovince,scity,minScredit,maxScredit,minSGPA,maxSGPA);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(students));
        out.flush();
    }
}