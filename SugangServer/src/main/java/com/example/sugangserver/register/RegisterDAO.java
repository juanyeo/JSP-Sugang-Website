package com.example.sugangserver.register;

import com.example.sugangserver.UserInfo;
import com.example.sugangserver.dto.Lecture;
import com.example.sugangserver.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RegisterDAO {

    public ArrayList<Lecture> getList(int semesterSelect, String classNoSearch, String courseIdSearch, String courseNameSearch, String classIdSearch) {
        ArrayList<Lecture> lectureList = null;
        UserInfo userInfo = UserInfo.getInstance();

        String SQL = "SELECT C.class_id, C.class_no, C.course_id, C.name, C.major_id, M.name, \n" +
                "C.year, C.credit, C.lecturer_id, L.name, C.person_max, C.opened, \n" +
                "C.room_id, B.name, SUBSTRING(T.begin, 10, 1), SUBSTRING(T.begin, 12, 5), SUBSTRING(T.end, 12, 5), \n" +
                "(SELECT count(CR.student_id) FROM credits CR WHERE CR.class_id = C.class_id), \n" +
                "EXISTS(SELECT * FROM credits CR2 WHERE CR2.class_id = C.class_id AND CR2.student_id = '" + userInfo.getUserId() + "') \n" +
                "FROM class C\n" +
                "LEFT JOIN major M ON M.major_id = C.major_id\n" +
                "LEFT JOIN lecturer L ON L.lecturer_id = C.lecturer_id\n" +
                "LEFT JOIN room R ON R.room_id = C.room_id\n" +
                "LEFT JOIN building B ON B.building_id = R.building_id\n" +
                "LEFT JOIN time T ON T.class_id = C.class_id WHERE 1=1\n";
        if (semesterSelect != 0) SQL += "AND C.opened = " + String.valueOf(semesterSelect) + " \n";
        if (!"".equals(classNoSearch)) SQL += "AND C.class_no = '" + classNoSearch + "' \n";
        if (!"".equals(courseIdSearch)) SQL += "AND C.course_id = '" + courseIdSearch + "' \n";
        if (!"".equals(courseNameSearch)) SQL += "AND C.name LIKE '%" + courseNameSearch + "%' \n";
        if (!"".equals(classIdSearch)) SQL += "AND C.class_id = " + classIdSearch + "\n";
        SQL += ";";

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

                lecture.setRe_enroll(rs.getInt(19));
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

    public ArrayList<Lecture> getUserClassList() {
        ArrayList<Lecture> lectureList = null;
        UserInfo userInfo = UserInfo.getInstance();

        String SQL = "SELECT C.class_id, C.class_no, C.course_id, C.name, C.major_id, M.name, \n" +
                "C.year, C.credit, C.lecturer_id, L.name, C.person_max, C.opened, \n" +
                "C.room_id, B.name, SUBSTRING(T.begin, 10, 1), SUBSTRING(T.begin, 12, 5), SUBSTRING(T.end, 12, 5), \n" +
                "(SELECT count(CR.student_id) FROM credits CR WHERE CR.class_id = C.class_id), \n" +
                "(SELECT CR2.grade_num FROM credits CR2 WHERE CR2.class_id = C.class_id AND CR2.student_id = " + userInfo.getUserId() + ") \n" +
                "FROM class C\n" +
                "LEFT JOIN major M ON M.major_id = C.major_id\n" +
                "LEFT JOIN lecturer L ON L.lecturer_id = C.lecturer_id\n" +
                "LEFT JOIN room R ON R.room_id = C.room_id\n" +
                "LEFT JOIN building B ON B.building_id = R.building_id\n" +
                "LEFT JOIN time T ON T.class_id = C.class_id \n" +
                "WHERE 1=EXISTS(SELECT * FROM credits CR2 WHERE CR2.class_id = C.class_id AND CR2.student_id = " + userInfo.getUserId() + ")";

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

                int reCredit = 0;
                if (rs.getString(19) != null && !"".equals(rs.getString(19))) {
                    reCredit = (int) Float.parseFloat(rs.getString(19)) * 2;
                }
                lecture.setRe_enroll(reCredit);
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

    public int validateCredit(String classId) {
        ArrayList<Lecture> myLectureList = getUserClassList();
        ArrayList<Lecture> clickedLectureList = getList(0, "", "", "", classId);

        Lecture clickedLecture = clickedLectureList.get(0);
        Lecture clickedLecture2 = null;
        if (clickedLectureList.size() > 1) clickedLecture2 = clickedLectureList.get(1);

        int semester = clickedLecture.getOpened();
        int credit = clickedLecture.getCredit();
        String dayOfWeek = clickedLecture.getDay_of_week();
        String begin = clickedLecture.getBegin();
        String end = clickedLecture.getEnd();
        int personMax = clickedLecture.getPerson_max();
        int personEnroll = clickedLecture.getPerson_enroll();

        for (int i = 0; i < myLectureList.size(); i++) {
            Lecture lecture = myLectureList.get(i);

            if (lecture.getOpened() == semester) {
                credit += lecture.getCredit();
                // 조건 3: 동일 시간대 수강신청 불가능
                if (dayOfWeek != null && !"".equals(dayOfWeek) && dayOfWeek.equals(lecture.getDay_of_week())) {
                    if (begin.compareTo(lecture.getBegin())==1) {
                        if (lecture.getEnd().compareTo(begin)==1) return 3;
                    } else {
                        if (end.compareTo(lecture.getBegin())==1) return 3;
                    }
                }
                if (clickedLecture2 != null) {
                    String dayOfWeek2 = clickedLecture2.getDay_of_week();
                    String begin2 = clickedLecture2.getBegin();
                    String end2 = clickedLecture2.getEnd();
                    if (dayOfWeek2 != null && !"".equals(dayOfWeek2) && dayOfWeek2.equals(lecture.getDay_of_week())) {
                        if (begin2.compareTo(lecture.getBegin())==1) {
                            if (lecture.getEnd().compareTo(begin2)==1) return 3;
                        } else {
                            if (end2.compareTo(lecture.getBegin())==1) return 3;
                        }
                    }
                }
            }

            if (lecture.getClass_id() == Integer.parseInt(classId)) {
                // 조건 5: 같은 강의 2번째 신청
                if (lecture.getOpened() == semester) return 5;
                // 조건 1: 이전 성적 B0 이상일 경우 X
                if (lecture.getRe_enroll() >= 6) return 1;
            }
        }

        // 조건 2: 정원이 다 찼을 경우
        if (personEnroll >= personMax) return 2;
        // 조건 4: 최대 학점 18학점
        if (credit > 18) return 4;

        // 모든 조건 통과
        return 0;
    }

    public int insertCredit(String classId) {
        // 학생 수강 등록
        String SQL = "INSERT INTO credits VALUES (NULL, ?, ?, NULL, NULL)";

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
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }
        return -1;
    }

    public int insertWish(String classId) {
        // 학생 수강 등록
        String SQL = "INSERT INTO wish VALUES (NULL, ?, ?)";

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
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
        }
        return -1;
    }
}
