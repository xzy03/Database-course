package dao;

import database.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO  implements Dao {
    public User login(String loginName, String password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            String sql = "SELECT * FROM xiangzy_user01 WHERE xzy_account01 = ? AND xzy_pass01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, loginName);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getString("xzy_account01"),
                        rs.getString("xzy_pass01"),
                        rs.getString("xzy_identify01")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs,stmt,conn);
        }

        return null;
    }

    public User getUserByLoginName(String loginName) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            String sql = "SELECT * FROM xiangzy_user01 WHERE xzy_account01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, loginName);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getString("xzy_account01"),
                        rs.getString("xzy_pass01"),
                        rs.getString("xzy_identify01")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Dao.close(rs, stmt, conn);
        }

        return null;
    }

    public boolean updatePassword(String account, String newPassword) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            String sql = "UPDATE xiangzy_user01 SET xzy_pass01 = ? WHERE xzy_account01 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, account);

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
