package dao;

import database.Class;
import database.Dept;
import database.*;
import java.sql.*;
import java.util.*;

public class TeacherDAO implements Dao {

    public List<TeacherStudentScore> searchTeacherStudentScore(String tno) {
        List<TeacherStudentScore> teacherStudentScores = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_teacher_student_score_info WHERE 1=1");

            // 构建查询条件
            if (tno != null && !tno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Tno01 = ?");
            }

            stmt = conn.prepareStatement(sqlBuilder.toString());
            int parameterIndex = 1;
            if (tno != null && !tno.isEmpty()) {
                stmt.setString(parameterIndex++, tno);
            }
            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                TeacherStudentScore teacherStudentScore = new TeacherStudentScore();
                teacherStudentScore.setSno(rs.getString("xzy_Sno01"));
                teacherStudentScore.setSname(rs.getString("xzy_Sname01"));
                teacherStudentScore.setDno(rs.getString("xzy_Dno01"));
                teacherStudentScore.setClno(rs.getString("xzy_Clno01"));
                teacherStudentScore.setCno(rs.getString("xzy_Cno01"));
                teacherStudentScore.setCname(rs.getString("xzy_Cname01"));
                teacherStudentScore.setTno(rs.getString("xzy_Tno01"));
                teacherStudentScore.setTname(rs.getString("xzy_Tname01"));
                teacherStudentScore.setScore(rs.getInt("xzy_score01"));

                teacherStudentScores.add(teacherStudentScore);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return teacherStudentScores;
    }

}
