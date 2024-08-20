package dao;

import database.Class;
import database.Dept;
import database.*;
import java.sql.*;
import java.util.*;

public class StudentDAO implements Dao {

    public boolean addTeach(String sno, String cno, String tno, Integer score, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "INSERT INTO xiangzy_SCORE01 (xzy_Sno01, xzy_Cno01, xzy_Tno01, xzy_score01, xzy_status01) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, sno);
            stmt.setString(2, cno);
            stmt.setString(3, tno);
            stmt.setInt(4, score);
            stmt.setString(5, status);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // 如果有行受影响，则返回 true，否则返回 false
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // 出现异常时返回 false
        } finally {
            Dao.close(stmt);
            Dao.close(conn);
        }
    }

    public boolean updateScore(String sno, String tno, String cno, Integer score, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "UPDATE xiangzy_SCORE01 SET xzy_score01 = ?, xzy_status01 = ? WHERE xzy_Sno01 = ? AND xzy_Tno01 = ? AND xzy_Cno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, score);
            stmt.setString(2, status);
            stmt.setString(3, sno);
            stmt.setString(4, tno);
            stmt.setString(5, cno);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // 如果有行受影响，则返回 true，否则返回 false
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // 出现异常时返回 false
        } finally {
            Dao.close(stmt);
            Dao.close(conn);
        }
    }

    public boolean deleteScore(String sno, String cno, String tno) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "DELETE FROM xiangzy_score01 WHERE xzy_Sno01 = ? AND xzy_Cno01 = ? AND xzy_Tno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, sno);
            stmt.setString(2, cno);
            stmt.setString(3, tno);
            System.out.println(stmt);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // 如果有行受影响，则返回 true，否则返回 false
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // 出现异常时返回 false
        } finally {
            Dao.close(stmt);
            Dao.close(conn);
        }
    }

    public List<StudentScore> searchStudentScore(String sno) {
        List<StudentScore> studentScores = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_Student_Score_Info WHERE 1=1");

            // 构建查询条件
            if (sno != null && !sno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Sno01 = ?");
            }

            stmt = conn.prepareStatement(sqlBuilder.toString());
            int parameterIndex = 1;
            if (sno != null && !sno.isEmpty()) {
                stmt.setString(parameterIndex++, sno);
            }
            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                StudentScore studentScore=new StudentScore();
                studentScore.setSno(rs.getString("xzy_Sno01"));
                studentScore.setSname(rs.getString("xzy_Sname01"));
                studentScore.setDno(rs.getString("xzy_Dno01"));
                studentScore.setClno(rs.getString("xzy_Clno01"));
                studentScore.setCno(rs.getString("xzy_Cno01"));
                studentScore.setCname(rs.getString("xzy_Cname01"));
                studentScore.setCcredit(rs.getFloat("xzy_Ccredit01"));
                studentScore.setTname(rs.getString("xzy_Tname01"));
                studentScore.setScore(rs.getInt("xzy_score01"));
                studentScore.setGrade(rs.getFloat("xzy_grade01"));

                studentScores.add(studentScore);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return studentScores;
    }
}
