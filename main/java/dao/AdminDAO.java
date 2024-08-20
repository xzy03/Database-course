package dao;
import database.Class;
import database.Dept;
import database.*;
import java.sql.*;
import java.util.*;

public class AdminDAO implements Dao {
    public List<Student> searchStudent(String sno, String clno, String dno, String sname, String ssex, Integer sbirth, String sprovince, String scity, Float minScredit, Float maxScredit, Float minSGPA, Float maxSGPA) {
        List<Student> students = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        System.out.println("进入查询函数");
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM Xiangzy_STUDENTS01 WHERE 1=1");

            // 构建查询条件
            if (sno != null && !sno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Sno01 LIKE ?");
            }
            if (clno != null && !clno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Clno01 LIKE ?");
            }
            if (dno != null && !dno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Dno01 LIKE ?");
            }
            if (sname != null && !sname.isEmpty()) {
                sqlBuilder.append(" AND xzy_Sname01 LIKE ?");
            }
            if (ssex != null && !ssex.isEmpty()) {
                sqlBuilder.append(" AND xzy_Ssex01 = ?");
            }
            if (sbirth != null) {
                sqlBuilder.append(" AND xzy_Sbirth01 = ?");
            }
            if (sprovince != null && !sprovince.isEmpty()) {
                sqlBuilder.append(" AND xzy_Sprovince01 LIKE ?");
            }
            if (scity != null && !scity.isEmpty()) {
                sqlBuilder.append(" AND xzy_Scity01 LIKE ?");
            }
            if (minScredit != null) {
                sqlBuilder.append(" AND xzy_Scredit01 >= ?");
            }
            if (maxScredit != null) {
                sqlBuilder.append(" AND xzy_Scredit01 <= ?");
            }
            if (minSGPA != null) {
                sqlBuilder.append(" AND xzy_SGPA01 >= ?");
            }
            if (maxSGPA != null) {
                sqlBuilder.append(" AND xzy_SGPA01 <= ?");
            }

            stmt = conn.prepareStatement(sqlBuilder.toString());
            int parameterIndex = 1;
            if (sno != null && !sno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + sno + "%");
            }
            if (clno != null && !clno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + clno + "%");
            }
            if (dno != null && !dno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + dno + "%");
            }
            if (sname != null && !sname.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + sname + "%");
            }
            if (ssex != null && !ssex.isEmpty()) {
                stmt.setString(parameterIndex++, ssex);
            }
            if (sbirth != null) {
                stmt.setInt(parameterIndex++, sbirth);
            }
            if (sprovince != null && !sprovince.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + sprovince + "%");
            }
            if (scity != null && !scity.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + scity + "%");
            }
            if (minScredit != null) {
                stmt.setFloat(parameterIndex++, minScredit);
            }
            if (maxScredit != null) {
                stmt.setFloat(parameterIndex++, maxScredit);
            }
            if (minSGPA != null) {
                stmt.setFloat(parameterIndex++, minSGPA);
            }
            if (maxSGPA != null) {
                stmt.setFloat(parameterIndex++, maxSGPA);
            }
            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                Student student = new Student();
                student.setSno(rs.getString("xzy_Sno01"));
                student.setClno(rs.getString("xzy_Clno01"));
                student.setDno(rs.getString("xzy_Dno01"));
                student.setSname(rs.getString("xzy_Sname01"));
                student.setSsex(rs.getString("xzy_Ssex01"));
                student.setSbirth(rs.getInt("xzy_Sbirth01"));
                student.setSprovince(rs.getString("xzy_Sprovince01"));
                student.setScity(rs.getString("xzy_Scity01"));
                student.setScredit(rs.getFloat("xzy_Scredit01"));
                student.setSgpa(rs.getFloat("xzy_SGPA01"));

                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return students;
    }

    public boolean addStudent(String sno, String clno, String dno, String sname, String ssex, Integer sbirth, String sprovince, String scity) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "INSERT INTO xiangzy_students01 (xzy_sno01, xzy_clno01, xzy_dno01, xzy_sname01, xzy_ssex01, xzy_sbirth01, xzy_sprovince01, xzy_scity01, xzy_scredit01, xzy_sgpa01) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, sno);
            stmt.setString(2, clno);
            stmt.setString(3, dno);
            stmt.setString(4, sname);
            stmt.setString(5, ssex);
            stmt.setInt(6, sbirth);
            stmt.setString(7, sprovince);
            stmt.setString(8, scity);
            stmt.setFloat(9, 0.0f);
            stmt.setFloat(10, 0.0f);

            int rowsAffected = stmt.executeUpdate();
            if(rowsAffected > 0){
                sql="INSERT INTO xiangzy_user01(xzy_account01,xzy_pass01,xzy_identify01) VALUES (?,?,?)";
                stmt=conn.prepareStatement(sql);
                stmt.setString(1, sno);
                stmt.setString(2, "123456");
                stmt.setString(3, "学生");
                stmt.executeUpdate();
            }
            return rowsAffected > 0; // 如果有行受影响，则返回 true，否则返回 false
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // 出现异常时返回 false
        } finally {
            Dao.close(stmt);
            Dao.close(conn);
        }
    }

    public boolean updateStudent(String sno, String clno, String dno, String sname, String ssex, Integer sbirth, String sprovince, String scity) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "UPDATE xiangzy_students01 SET xzy_clno01 = ?, xzy_dno01 = ?, xzy_sname01 = ?, xzy_ssex01 = ?, xzy_sbirth01 = ?, xzy_sprovince01 = ?, xzy_scity01 = ?, xzy_scredit01 = ?, xzy_sgpa01 = ? WHERE xzy_sno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, clno);
            stmt.setString(2, dno);
            stmt.setString(3, sname);
            stmt.setString(4, ssex);
            stmt.setInt(5, sbirth);
            stmt.setString(6, sprovince);
            stmt.setString(7, scity);
            stmt.setFloat(8, 0.0f);
            stmt.setFloat(9, 0.0f);
            stmt.setString(10, sno);
            System.out.println(stmt);

            int rowsAffected = stmt.executeUpdate();
            System.out.println(rowsAffected);
            return rowsAffected > 0; // 如果有行受影响，则返回 true，否则返回 false
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // 出现异常时返回 false
        } finally {
            Dao.close(stmt);
            Dao.close(conn);
        }
    }

    public boolean deleteStudent(String sno) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "DELETE FROM xiangzy_students01 WHERE xzy_sno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, sno);
            System.out.println(stmt);

            int rowsAffected = stmt.executeUpdate();

            if(rowsAffected > 0){
                sql="DELETE FROM xiangzy_user01 WHERE xzy_account01 = ?";
                stmt=conn.prepareStatement(sql);
                stmt.setString(1, sno);
                stmt.executeUpdate();
            }
            return rowsAffected > 0; // 如果有行受影响，则返回 true，否则返回 false
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // 出现异常时返回 false
        } finally {
            Dao.close(stmt);
            Dao.close(conn);
        }
    }

    public List<Teacher> searchTeacher(String tno, String tname, String tsex, Integer tbirth, String tposition, String tphone) {
        List<Teacher> teachers = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        System.out.println("进入教师查询函数");
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_TEACHER01 WHERE 1=1");

            // 构建查询条件
            if (tno != null && !tno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Tno01 LIKE ?");
            }
            if (tname != null && !tname.isEmpty()) {
                sqlBuilder.append(" AND xzy_Tname01 LIKE ?");
            }
            if (tsex != null && !tsex.isEmpty()) {
                sqlBuilder.append(" AND xzy_Tsex01 = ?");
            }
            if (tbirth != null) {
                sqlBuilder.append(" AND xzy_Tbirth01 = ?");
            }
            if (tposition != null && !tposition.isEmpty()) {
                sqlBuilder.append(" AND xzy_Tposition01 = ?");
            }
            if (tphone != null && !tphone.isEmpty()) {
                sqlBuilder.append(" AND xzy_Tphone01 LIKE ?");
            }

            stmt = conn.prepareStatement(sqlBuilder.toString());
            int parameterIndex = 1;
            if (tno != null && !tno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + tno + "%");
            }
            if (tname != null && !tname.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + tname + "%");
            }
            if (tsex != null && !tsex.isEmpty()) {
                stmt.setString(parameterIndex++, tsex);
            }
            if (tbirth != null) {
                stmt.setInt(parameterIndex++, tbirth);
            }
            if (tposition != null && !tposition.isEmpty()) {
                stmt.setString(parameterIndex++, tposition);
            }
            if (tphone != null && !tphone.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + tphone + "%");
            }
            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setTno(rs.getString("xzy_Tno01"));
                teacher.setTname(rs.getString("xzy_Tname01"));
                teacher.setTsex(rs.getString("xzy_Tsex01"));
                teacher.setTbirth(rs.getInt("xzy_Tbirth01"));
                teacher.setTposition(rs.getString("xzy_Tposition01"));
                teacher.setTphone(rs.getString("xzy_Tphone01"));

                teachers.add(teacher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return teachers;
    }

    public boolean addTeacher(String tno, String tname, String tsex, Integer tbirth, String tposition, String tphone) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "INSERT INTO xiangzy_teacher01 (xzy_tno01, xzy_tname01, xzy_tsex01, xzy_tbirth01, xzy_tposition01, xzy_tphone01) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, tno);
            stmt.setString(2, tname);
            stmt.setString(3, tsex);
            stmt.setInt(4, tbirth);
            stmt.setString(5, tposition);
            stmt.setString(6, tphone);

            int rowsAffected = stmt.executeUpdate();
            if(rowsAffected > 0){
                sql = "INSERT INTO xiangzy_user01(xzy_account01, xzy_pass01, xzy_identify01) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, tno);
                stmt.setString(2, "123456");
                stmt.setString(3, "教师");
                stmt.executeUpdate();
            }
            return rowsAffected > 0; // 如果有行受影响，则返回 true，否则返回 false
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // 出现异常时返回 false
        } finally {
            Dao.close(stmt);
            Dao.close(conn);
        }
    }

    public boolean updateTeacher(String tno, String tname, String tsex, Integer tbirth, String tposition, String tphone) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "UPDATE xiangzy_teacher01 SET xzy_tname01 = ?, xzy_tsex01 = ?, xzy_tbirth01 = ?, xzy_tposition01 = ?, xzy_tphone01 = ? WHERE xzy_tno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, tname);
            stmt.setString(2, tsex);
            stmt.setInt(3, tbirth);
            stmt.setString(4, tposition);
            stmt.setString(5, tphone);
            stmt.setString(6, tno);

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

    public boolean deleteTeacher(String tno) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "DELETE FROM xiangzy_teacher01 WHERE xzy_tno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, tno);
            System.out.println(stmt);

            int rowsAffected = stmt.executeUpdate();

            if(rowsAffected > 0){
                sql="DELETE FROM xiangzy_user01 WHERE xzy_account01 = ?";
                stmt=conn.prepareStatement(sql);
                stmt.setString(1, tno);
                stmt.executeUpdate();
            }
            return rowsAffected > 0; // 如果有行受影响，则返回 true，否则返回 false
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // 出现异常时返回 false
        } finally {
            Dao.close(stmt);
            Dao.close(conn);
        }
    }

    public List<Dept> searchDept(String dno, String dname, Integer dnumber) {
        List<Dept> depts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        System.out.println("进入部门查询函数");
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_DEPTS01 WHERE 1=1");

            // 构建查询条件
            if (dno != null && !dno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Dno01 LIKE ?");
            }
            if (dname != null && !dname.isEmpty()) {
                sqlBuilder.append(" AND xzy_Dname01 LIKE ?");
            }
            if (dnumber != null) {
                sqlBuilder.append(" AND xzy_Dnumber01 = ?");
            }

            stmt = conn.prepareStatement(sqlBuilder.toString());
            int parameterIndex = 1;
            if (dno != null && !dno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + dno + "%");
            }
            if (dname != null && !dname.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + dname + "%");
            }
            if (dnumber != null) {
                stmt.setInt(parameterIndex++, dnumber);
            }
            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                Dept dept = new Dept();
                dept.setDno(rs.getString("xzy_Dno01"));
                dept.setDname(rs.getString("xzy_Dname01"));
                dept.setDnumber(rs.getInt("xzy_Dnumber01"));

                depts.add(dept);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return depts;
    }

    public boolean addDept(String dno, String dname, Integer dnumber) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "INSERT INTO xiangzy_DEPTS01 (xzy_Dno01, xzy_Dname01, xzy_Dnumber01) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, dno);
            stmt.setString(2, dname);
            stmt.setInt(3, dnumber);

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

    public boolean updateDept(String dno, String dname) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "UPDATE xiangzy_DEPTS01 SET xzy_Dname01 = ? WHERE xzy_Dno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, dname);
            stmt.setString(2, dno);

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

    public boolean deleteDept(String dno) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "DELETE FROM xiangzy_depts01 WHERE xzy_dno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, dno);
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

    public List<Class> searchClass(String clno, String clname, Integer clnumber, String dno) {
        List<Class> classes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        System.out.println("进入班级查询函数");
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_CLASS01 WHERE 1=1");

            // 构建查询条件
            if (clno != null && !clno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Clno01 LIKE ?");
            }
            if (clname != null && !clname.isEmpty()) {
                sqlBuilder.append(" AND xzy_Clname01 LIKE ?");
            }
            if (clnumber != null) {
                sqlBuilder.append(" AND xzy_Clnumber01 = ?");
            }
            if (dno != null && !dno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Dno01 LIKE ?");
            }

            stmt = conn.prepareStatement(sqlBuilder.toString());
            int parameterIndex = 1;
            if (clno != null && !clno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + clno + "%");
            }
            if (clname != null && !clname.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + clname + "%");
            }
            if (clnumber != null) {
                stmt.setInt(parameterIndex++, clnumber);
            }
            if (dno != null && !dno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + dno + "%");
            }
            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                Class cls = new Class();
                cls.setClno(rs.getString("xzy_Clno01"));
                cls.setClname(rs.getString("xzy_Clname01"));
                cls.setClnumber(rs.getInt("xzy_Clnumber01"));
                cls.setDno(rs.getString("xzy_Dno01"));

                classes.add(cls);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return classes;
    }

    public boolean addClass(String clno, String clname, Integer clnumber, String dno) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "INSERT INTO xiangzy_CLASS01 (xzy_Clno01, xzy_Clname01, xzy_Clnumber01, xzy_Dno01) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, clno);
            stmt.setString(2, clname);
            stmt.setInt(3, clnumber);
            stmt.setString(4, dno);

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

    public boolean updateClass(String clno, String clname, String dno) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "UPDATE xiangzy_CLASS01 SET xzy_Clname01 = ? WHERE xzy_Clno01 = ? AND xzy_Dno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, clname);
            stmt.setString(2, clno);
            stmt.setString(3, dno);

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

    public boolean deleteClass(String clno, String dno) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "DELETE FROM xiangzy_class01 WHERE xzy_clno01 = ? AND xzy_dno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, clno);
            stmt.setString(2, dno);
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

    public List<Course> searchCourse(String cno, String cname, Integer cyear, Integer period, String way, String curriculum, Float credit) {
        List<Course> courses = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        System.out.println("进入课程查询函数");
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_COURSE01 WHERE 1=1");

            // 构建查询条件
            if (cno != null && !cno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Cno01 LIKE ?");
            }
            if (cname != null && !cname.isEmpty()) {
                sqlBuilder.append(" AND xzy_Cname01 LIKE ?");
            }
            if (cyear != null) {
                sqlBuilder.append(" AND xzy_Cyear01 = ?");
            }
            if (period != null) {
                sqlBuilder.append(" AND xzy_Period01 = ?");
            }
            if (way != null && !way.isEmpty()) {
                sqlBuilder.append(" AND xzy_Way01 LIKE ?");
            }
            if (curriculum != null && !curriculum.isEmpty()) {
                sqlBuilder.append(" AND xzy_Curriculum LIKE ?");
            }
            if (credit != null) {
                sqlBuilder.append(" AND xzy_Credit01 = ?");
            }

            stmt = conn.prepareStatement(sqlBuilder.toString());
            int parameterIndex = 1;
            if (cno != null && !cno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + cno + "%");
            }
            if (cname != null && !cname.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + cname + "%");
            }
            if (cyear != null) {
                stmt.setInt(parameterIndex++, cyear);
            }
            if (period != null) {
                stmt.setInt(parameterIndex++, period);
            }
            if (way != null && !way.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + way + "%");
            }
            if (curriculum != null && !curriculum.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + curriculum + "%");
            }
            if (credit != null) {
                stmt.setFloat(parameterIndex++, credit);
            }
            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                Course course = new Course();
                course.setCno(rs.getString("xzy_Cno01"));
                course.setCname(rs.getString("xzy_Cname01"));
                course.setCyear(rs.getInt("xzy_Cyear01"));
                course.setPeriod(rs.getInt("xzy_Period01"));
                course.setWay(rs.getString("xzy_Way01"));
                course.setCurriculum(rs.getString("xzy_Curriculum"));
                course.setCredit(rs.getFloat("xzy_Credit01"));

                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return courses;
    }

    public boolean addCourse(String cno, String cname, Integer cyear, Integer period, String way, String curriculum, Float credit) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "INSERT INTO xiangzy_COURSE01 (xzy_Cno01, xzy_Cname01, xzy_Cyear01, xzy_Period01, xzy_Way01, xzy_Curriculum, xzy_Credit01) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cno);
            stmt.setString(2, cname);
            stmt.setInt(3, cyear);
            stmt.setInt(4, period);
            stmt.setString(5, way);
            stmt.setString(6, curriculum);
            stmt.setFloat(7, credit);

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

    public boolean updateCourse(String cno, String cname, Integer cyear, Integer period, String way, String curriculum, Float credit) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "UPDATE xiangzy_COURSE01 SET xzy_Cname01 = ?, xzy_Cyear01 = ?, xzy_Period01 = ?, xzy_Way01 = ?, xzy_Curriculum = ?, xzy_Credit01 = ? WHERE xzy_Cno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cname);
            stmt.setInt(2, cyear);
            stmt.setInt(3, period);
            stmt.setString(4, way);
            stmt.setString(5, curriculum);
            stmt.setFloat(6, credit);
            stmt.setString(7, cno);

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

    public boolean deleteCourse(String cno) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "DELETE FROM xiangzy_course01 WHERE xzy_cno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cno);
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

    public List<Teach> searchTeach(String cno, String tno, String time, Integer maxnum, Integer choosenum) {
        List<Teach> teaches = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        System.out.println("进入授课查询函数");
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_TEACH01 WHERE 1=1");

            // 构建查询条件
            if (cno != null && !cno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Cno01 LIKE ?");
            }
            if (tno != null && !tno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Tno01 LIKE ?");
            }
            if (time != null && !time.isEmpty()) {
                sqlBuilder.append(" AND xzy_time01 LIKE ?");
            }
            if (maxnum != null) {
                sqlBuilder.append(" AND xzy_maxnum01 = ?");
            }
            if (choosenum != null) {
                sqlBuilder.append(" AND xzy_choosenum01 = ?");
            }

            stmt = conn.prepareStatement(sqlBuilder.toString());
            int parameterIndex = 1;
            if (cno != null && !cno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + cno + "%");
            }
            if (tno != null && !tno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + tno + "%");
            }
            if (time != null && !time.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + time + "%");
            }
            if (maxnum != null) {
                stmt.setInt(parameterIndex++, maxnum);
            }
            if (choosenum != null) {
                stmt.setInt(parameterIndex++, choosenum);
            }
            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                Teach teach = new Teach();
                teach.setCno(rs.getString("xzy_Cno01"));
                teach.setTno(rs.getString("xzy_Tno01"));
                teach.setTime(rs.getString("xzy_time01"));
                teach.setMaxnum(rs.getInt("xzy_maxnum01"));
                teach.setChoosenum(rs.getInt("xzy_choosenum01"));

                teaches.add(teach);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return teaches;
    }

    public boolean addTeach(String cno, String tno, String time, Integer maxnum, Integer choosenum) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "INSERT INTO xiangzy_TEACH01 (xzy_Cno01, xzy_Tno01, xzy_time01, xzy_maxnum01, xzy_choosenum01) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cno);
            stmt.setString(2, tno);
            stmt.setString(3, time);
            stmt.setInt(4, maxnum);
            stmt.setInt(5, choosenum);
            System.out.println("添加授课sql:");
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

    public boolean updateTeach(String cno, String tno, String time) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "UPDATE xiangzy_teach01 SET xzy_time01 = ? WHERE xzy_Cno01 = ? AND xzy_Tno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, time);
            stmt.setString(2, cno);
            stmt.setString(3, tno);

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

    public boolean deleteTeach(String cno, String tno) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "DELETE FROM xiangzy_teach01 WHERE xzy_cno01 = ? AND xzy_tno01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cno);
            stmt.setString(2, tno);
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

    public List<Score> searchScore(String sno, String tno, String cno, Integer score, Float grade, String status) {
        List<Score> scores = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        System.out.println("进入成绩查询函数");
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_SCORE01 WHERE 1=1");

            // 构建查询条件
            if (sno != null && !sno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Sno01 LIKE ?");
            }
            if (tno != null && !tno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Tno01 LIKE ?");
            }
            if (cno != null && !cno.isEmpty()) {
                sqlBuilder.append(" AND xzy_Cno01 LIKE ?");
            }
            if (score != null) {
                sqlBuilder.append(" AND xzy_score01 = ?");
            }
            if (grade != null) {
                sqlBuilder.append(" AND xzy_grade01 = ?");
            }
            if (status != null && !status.isEmpty()) {
                sqlBuilder.append(" AND xzy_status01 = ?");
            }

            stmt = conn.prepareStatement(sqlBuilder.toString());
            int parameterIndex = 1;
            if (sno != null && !sno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + sno + "%");
            }
            if (tno != null && !tno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + tno + "%");
            }
            if (cno != null && !cno.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + cno + "%");
            }
            if (score != null) {
                stmt.setInt(parameterIndex++, score);
            }
            if (grade != null) {
                stmt.setFloat(parameterIndex++, grade);
            }
            if (status != null && !status.isEmpty()) {
                stmt.setString(parameterIndex++, status);
            }
            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                Score scoreObj = new Score();
                scoreObj.setSno(rs.getString("xzy_Sno01"));
                scoreObj.setTno(rs.getString("xzy_Tno01"));
                scoreObj.setCno(rs.getString("xzy_Cno01"));
                scoreObj.setScore(rs.getInt("xzy_score01"));
                scoreObj.setGrade(rs.getFloat("xzy_grade01"));
                scoreObj.setStatus(rs.getString("xzy_status01"));

                scores.add(scoreObj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return scores;
    }

    public boolean changeScoreStatus(String sno, String tno, String cno, String way) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            if(way.equals("accept")) {
                String sql = "UPDATE xiangzy_score01 SET xzy_status01 = '已选上' WHERE xzy_Sno01 = ? AND xzy_Tno01 = ? AND xzy_Cno01 = ?";
                stmt = conn.prepareStatement(sql);
            }
            else if(way.equals("reject")){
                String sql = "DELETE FROM xiangzy_score01 WHERE xzy_Sno01 = ? AND xzy_Tno01 = ? AND xzy_Cno01 = ?";
                stmt = conn.prepareStatement(sql);
            }
            stmt.setString(1, sno);
            stmt.setString(2, tno);
            stmt.setString(3, cno);

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

    public List<Count> showStudentGPA() {
        List<Count>  counts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_All_GPA");
            stmt = conn.prepareStatement(sqlBuilder.toString());

            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                Count count=new Count();
                count.setMax(rs.getFloat("MAX"));
                count.setMin(rs.getFloat("MIN"));
                count.setAvg(rs.getFloat("AVG"));

                counts.add(count);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return counts;
    }

    public List<Count> showStudentCredit() {
        List<Count>  counts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_All_Credit");
            stmt = conn.prepareStatement(sqlBuilder.toString());

            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                Count count=new Count();
                count.setMax(rs.getFloat("MAX"));
                count.setMin(rs.getFloat("MIN"));
                count.setAvg(rs.getFloat("AVG"));

                counts.add(count);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return counts;
    }

    public List<StudentCount> showStudentEachScore() {
        List<StudentCount>  studentCounts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_Each_Score");
            stmt = conn.prepareStatement(sqlBuilder.toString());

            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                StudentCount studentCount=new StudentCount();
                studentCount.setSno(rs.getString("xzy_sno01"));
                studentCount.setSname(rs.getString("xzy_sname01"));
                studentCount.setMax(rs.getFloat("MAX"));
                studentCount.setMin(rs.getFloat("MIN"));
                studentCount.setAvg(rs.getFloat("AVG"));

                studentCounts.add(studentCount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return studentCounts;
    }

    public List<StudentRank> showStudentGpaRank() {
        List<StudentRank>  studentRanks = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_Each_GPArank");
            stmt = conn.prepareStatement(sqlBuilder.toString());

            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                StudentRank studentRank=new StudentRank();

                studentRank.setSno(rs.getString("xzy_sno01"));
                studentRank.setSname(rs.getString("xzy_sname01"));
                studentRank.setRank(rs.getInt("RANK"));

                studentRanks.add(studentRank);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return studentRanks;
    }

    public List<StudentRank> showStudentCreditRank() {
        List<StudentRank>  studentRanks = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_Each_CreditRank");
            stmt = conn.prepareStatement(sqlBuilder.toString());

            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                StudentRank studentRank=new StudentRank();

                studentRank.setSno(rs.getString("xzy_sno01"));
                studentRank.setSname(rs.getString("xzy_sname01"));
                studentRank.setRank(rs.getInt("RANK"));

                studentRanks.add(studentRank);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return studentRanks;
    }

    public List<StudentRank> showCourseChooseNumber() {
        List<StudentRank>  studentRanks = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_Count_StudyCourse");
            stmt = conn.prepareStatement(sqlBuilder.toString());

            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                StudentRank studentRank=new StudentRank();

                studentRank.setSno(rs.getString("xzy_cno01"));
                studentRank.setSname(rs.getString("xzy_cname01"));
                studentRank.setRank(rs.getInt("number"));

                studentRanks.add(studentRank);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return studentRanks;
    }

    public List<StudentCount> showCourseScore() {
        List<StudentCount>  studentCounts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM xiangzy_All_Score");
            stmt = conn.prepareStatement(sqlBuilder.toString());

            System.out.println("查询前");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            System.out.println("查询后");
            while (rs.next()) {
                StudentCount studentCount=new StudentCount();
                studentCount.setSno(rs.getString("xzy_cno01"));
                studentCount.setSname(rs.getString("xzy_cname01"));
                studentCount.setMax(rs.getFloat("MAX"));
                studentCount.setMin(rs.getFloat("MIN"));
                studentCount.setAvg(rs.getFloat("AVG"));

                studentCounts.add(studentCount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return studentCounts;
    }

    public boolean deleteGraduateCredit(Float credit) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "CALL delete_graduate_credit( ? )";
            stmt = conn.prepareStatement(sql);
            stmt.setFloat(1, credit);
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

    public boolean deleteGraduateGpa(Float drop) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "CALL delete_graduate_gpa( ? )";
            stmt = conn.prepareStatement(sql);
            stmt.setFloat(1, drop);
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
}