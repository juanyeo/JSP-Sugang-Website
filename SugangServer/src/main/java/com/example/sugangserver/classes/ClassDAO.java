package com.example.sugangserver.classes;

import com.example.sugangserver.dto.Lecture;
import com.example.sugangserver.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ClassDAO {

    public int write(Lecture lecture) {
        String SQL = "INSERT INTO class VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);

            pstmt.setInt(1, lecture.getClass_no());
            pstmt.setString(2, lecture.getCourse_id());
            pstmt.setString(3, lecture.getCourse_name()); // 불러오기
            pstmt.setInt(4, lecture.getMajor_id());
            pstmt.setInt(5, lecture.getYear());
            pstmt.setInt(6, lecture.getCredit()); // 불러오기
            pstmt.setInt(7, lecture.getLecturer_id());
            pstmt.setInt(8, lecture.getPerson_max());
            pstmt.setInt(9, lecture.getOpened());
            pstmt.setInt(10, lecture.getRoom_id());

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }
        return -1;
    }

    public Lecture validateOpenLecture(Lecture lecture) {
        // 조건3: 토요일과 평일 18시 이후 수업은 E-러닝 강의로 분류 (NULL로 변경)
        if ("6".equals(lecture.getDay_of_week()) || Integer.parseInt(lecture.getBegin().substring(0,2)) >= 18) {
            lecture.setDay_of_week(null);
            lecture.setBegin(null);
            lecture.setEnd(null);
        }
        // 조건1: 수강 정원이 강의실 수용 인원보다 초과할 경우 과목 개설 불가능
        String SQL = "SELECT occupancy FROM room WHERE room_id = " + lecture.getRoom_id() + ";";

        int roomOccupacy = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                roomOccupacy = rs.getInt(1);
            }

            if (roomOccupacy >= lecture.getPerson_max()) {
                lecture.setValidation_message("SUCCESS");
            } else {
                lecture.setValidation_message("강의실이 지정한 최대 인원을 수용할 수 없습니다.");
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }

        return lecture;
    }

    public int updatePersonMax(String classId, String newMax) {
        String SQL = "UPDATE class SET person_max = ? WHERE class_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(newMax));
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

    public int insertStudentToClass(String classId, String personMax, String studentId) {
        // 수강 정원 1명 증가
        int updateResult = updatePersonMax(classId, String.valueOf(Integer.parseInt(personMax) + 1));
        if (updateResult == -1) return -1;

        // 학생 수강 등록
        String SQL = "INSERT INTO credits VALUES (NULL, ?, ?, NULL, NULL)";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);

            pstmt.setInt(1, Integer.parseInt(studentId));
            pstmt.setInt(2, Integer.parseInt(classId));

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }
        return -1;
    }

    public int deleteLecture(String classId) {
        String SQL = "DELETE FROM class WHERE class_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(classId));
            int result = pstmt.executeUpdate();
            if (result != -1) {
                deleteRegister(classId);
                deleteWish(classId);
            }
            return result;
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }

        return -1;
    }

    public int deleteRegister(String classId) {
        String SQL = "DELETE FROM credits WHERE class_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(classId));
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

    public int deleteWish(String classId) {
        String SQL = "DELETE FROM wish WHERE class_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(classId));
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
