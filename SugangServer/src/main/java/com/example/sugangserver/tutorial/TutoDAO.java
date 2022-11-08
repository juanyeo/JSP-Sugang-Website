package com.example.sugangserver.tutorial;

import com.example.sugangserver.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class TutoDAO {

    public int intro(String userID, String userPassword) {
        String SQL = "INSERT INTO TUTORIAL VALUES (?, ?)";
        try {
            Connection conn = DatabaseUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            pstmt.setString(1, userID);
            pstmt.setString(2, userPassword);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
