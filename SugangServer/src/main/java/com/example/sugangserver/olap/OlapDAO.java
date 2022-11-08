package com.example.sugangserver.olap;

import com.example.sugangserver.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class OlapDAO {
    public ArrayList<String[]> getTopTenList() {
        ArrayList<String[]> hellClassList = new ArrayList<>();

        String SQL = "SELECT A.class_id, CL.name, L.name AS lecturer, avg(A.dev) AS avg_dev FROM\n" +
                "(SELECT C.class_id, C.student_id, ((SELECT avg(CR.grade_num) FROM credits CR WHERE CR.student_id = C.student_id) - grade_num) AS dev\n" +
                "FROM credits C) A LEFT JOIN class CL ON CL.class_id = A.class_id LEFT JOIN lecturer L ON CL.lecturer_id = L.lecturer_id \n" +
                "GROUP BY A.class_id ORDER BY avg_dev DESC LIMIT 10;";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                String[] resultArray = new String[]{rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4).substring(0, 4)};
                hellClassList.add(resultArray);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }

        return hellClassList;
    }

    public ArrayList<String[]> getTopTenMajorList() {
        ArrayList<String[]> hellMajorList = new ArrayList<>();

        String SQL = "SELECT M.name, avg(C.grade_num) AS avg_grade\n" +
                "FROM credits C \n" +
                "LEFT JOIN class CL ON CL.class_id = C.class_id\n" +
                "LEFT JOIN major M ON M.major_id = CL.major_id\n" +
                "GROUP BY M.major_id ORDER BY avg_grade DESC LIMIT 10;";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                String[] resultArray = new String[]{rs.getString(1), rs.getString(2)};
                hellMajorList.add(resultArray);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }

        return hellMajorList;
    }
}
