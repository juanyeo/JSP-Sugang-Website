package com.example.sugangserver.student;

import com.example.sugangserver.dto.Lecture;
import com.example.sugangserver.dto.Student;
import com.example.sugangserver.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class StudentDAO {

    public ArrayList<Student> getStudentList(String studentId) {
        ArrayList<Student> studentList = null;

        String SQL = "SELECT S.student_id, S.name, S.sex, M.name, S.lecturer_id, L.name, S.year, S.status,\n" +
                "(SELECT avg(CR.grade_num) FROM credits CR WHERE CR.student_id = S.student_id)\n" +
                "FROM student S\n" +
                "LEFT JOIN major M ON M.major_id = S.major_id\n" +
                "LEFT JOIN lecturer L ON L.lecturer_id = S.lecturer_id WHERE 1=1 \n";
        if (!"".equals(studentId)) SQL += "AND S.student_id = '" + studentId + "' \n";
        SQL += ";";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();

            studentList = new ArrayList<Student>();
            while(rs.next()) {
                Student student = new Student(
                        // student_id, name, sex, major_name
                        rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        // lecturer_id, lecturer_name, year, status
                        rs.getInt(5), rs.getString(6), rs.getInt(7), rs.getString(8),
                        // avg_grade
                        rs.getString(9).substring(0, 4));

                studentList.add(student);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }

        return studentList;
    }

    public int updateStatus(String studentId, String newStatus) {
        String SQL = "UPDATE student SET status = ? WHERE student_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, Integer.parseInt(studentId));
            return pstmt.executeUpdate();
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
