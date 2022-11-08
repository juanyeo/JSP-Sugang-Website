package com.example.sugangserver.registered;

import com.example.sugangserver.UserInfo;
import com.example.sugangserver.dto.Lecture;
import com.example.sugangserver.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class WishDAO {

    public ArrayList<Lecture> getWishList() {
        ArrayList<Lecture> lectureList = null;
        UserInfo userInfo = UserInfo.getInstance();

        String SQL = "SELECT C.class_id, C.class_no, C.course_id, C.name, C.major_id, M.name, \n" +
                "C.year, C.credit, C.lecturer_id, L.name, C.person_max, C.opened, \n" +
                "C.room_id, B.name, SUBSTRING(T.begin, 10, 1), SUBSTRING(T.begin, 12, 5), SUBSTRING(T.end, 12, 5), \n" +
                "(SELECT count(CR.student_id) FROM credits CR WHERE CR.class_id = C.class_id) \n" +
                "FROM class C\n" +
                "LEFT JOIN major M ON M.major_id = C.major_id\n" +
                "LEFT JOIN lecturer L ON L.lecturer_id = C.lecturer_id\n" +
                "LEFT JOIN room R ON R.room_id = C.room_id\n" +
                "LEFT JOIN building B ON B.building_id = R.building_id\n" +
                "LEFT JOIN time T ON T.class_id = C.class_id \n" +
                "WHERE 1=EXISTS(SELECT * FROM wish CR2 WHERE CR2.class_id = C.class_id AND CR2.student_id = " + userInfo.getUserId() + ")";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();

            lectureList = new ArrayList<Lecture>();
            while(rs.next()) {
                //System.out.println(rs.getString(4));
                Lecture lecture = new Lecture(
                        // class_id, class_no, course_id, course_name
                        rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4),
                        // major_id, major_name, year, credit // lecturer_id, lecturer_name, person_max, opened
                        rs.getInt(5), rs.getString(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9), rs.getString(10), rs.getInt(11), rs.getInt(12),
                        // room_id, building_name, day_of_week, begin, end, person_enroll
                        rs.getInt(13), rs.getString(14), rs.getString(15),
                        rs.getString(16), rs.getString(17), rs.getInt(18));

                lectureList.add(lecture);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }

        return lectureList;
    }

    public int cancelWish(String classId) {
        String SQL = "DELETE FROM wish WHERE student_id = ? AND class_id = ?";

        UserInfo userInfo = UserInfo.getInstance();
        String studentId = userInfo.getUserId();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(studentId));
            pstmt.setInt(2, Integer.parseInt(classId));

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
