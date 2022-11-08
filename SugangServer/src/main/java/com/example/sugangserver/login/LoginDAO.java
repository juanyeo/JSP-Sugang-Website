package com.example.sugangserver.login;

import com.example.sugangserver.UserInfo;
import com.example.sugangserver.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO {

    String adminId = "202211";
    String adminPassword = "admin2022";

    public int login(String userId, String userPassword) {
        UserInfo userInfo = UserInfo.getInstance();

        if (adminId.equals(userId) && adminPassword.equals(userPassword)) {
            userInfo.setAdmin(true);
            return 1; // 로그인 성공
        }
        String SQL = "SELECT password, name FROM student WHERE student_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(userId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    userInfo.setUserId(userId);
                    userInfo.setName(rs.getString(2));
                    return 1; // 로그인 성공
                } else {
                    return 0; // 로그인 실패
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }

        return -1;
    }
}
