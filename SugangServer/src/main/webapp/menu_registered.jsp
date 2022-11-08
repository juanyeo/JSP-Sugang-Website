<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.sugangserver.register.RegisterDAO" %>
<%@ page import="com.example.sugangserver.registered.RegisteredDAO" %>
<%@ page import="com.example.sugangserver.registered.WishDAO" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.Integer" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>수강신청</title>
  <link rel="stylesheet" href="./css/bootstrap.min.css">
  <link rel="stylesheet" href="./css/custom.css">
</head>
<body>
  <%@ include file="top_navigation.jsp"%>

  <%
    request.setCharacterEncoding("UTF-8");
  %>
  <div class="container_fluid"  style="margin-top:10px; margin-left:20px;">
    <h1 style="margin-bottom:30px; margin-left: 20px; font-family: 'Nanum Pen Script'; font-size: 32px;">희망 수업</h1>
  </div>
  <script>
    var classId = null;

    function registerClass()
    {
      location.href='${path}/SugangServer_war_exploded/action_register_class.jsp?classId='+classId;
    }

    function cancelWish()
    {
      location.href='${path}/SugangServer_war_exploded/action_cancel_wish.jsp?classId='+classId;
    }
  </script>
  <div class="container_fluid" style="margin-top:20px; margin-left: 16px; margin-right: 16px;">
    <div class="card shadow">
      <div class="card-body">
        <table class="table table-hover" id='board_list'>
          <thead>
          <tr>
            <th class="text-center d-none d-md-table-cell">신청/삭제</th>
            <th class="text-center d-none d-md-table-cell">재수강</th>
            <th class="text-center d-none d-md-table-cell">수업번호</th>
            <th class="text-center d-none d-md-table-cell">학수번호</th>
            <th class="text-center d-none d-md-table-cell">교과목명</th>
            <th class="text-center d-none d-md-table-cell">개설학기</th>
            <th class="text-center d-none d-md-table-cell">교강사</th>
            <th class="text-center d-none d-md-table-cell">수업시간</th>
            <th class="text-center d-none d-md-table-cell">인원</th>
            <th class="text-center d-none d-md-table-cell">강의실</th>
          </tr>
          </thead>
          <tbody>
  <%
    ArrayList<Lecture> lectureWishList = new ArrayList<Lecture>();
    lectureWishList = new WishDAO().getWishList();
    if (lectureWishList != null) {
      for(int i = 0; i < lectureWishList.size(); i++) {
        Lecture lecture = lectureWishList.get(i);
        String timeText = "E-러닝 강의";
        if (lecture.getDay_of_week() != null && !lecture.getDay_of_week().isEmpty()) {
          String[] week = {"월", "화", "수", "목", "금", "토", "일"};
          timeText = week[Integer.parseInt(lecture.getDay_of_week())-1] + " " + lecture.getBegin() + " - " + lecture.getEnd();
        }
        String reEnrollText = "-";
        if (lecture.getRe_enroll() > 0) {
          if (lecture.getOpened() == 2022) {
            reEnrollText = "신청됨";
          } else {
            reEnrollText = "재수강";
          }
        }
  %>
          <tr>
            <td class="text-center d-none d-md-table-cell">
              <button type="button" class="btn btn-success btn-sm" onclick="classId=<%=lecture.getClass_id()%>; registerClass();">신청</button>
              <button type="button" class="btn btn-outline-danger btn-sm" onclick="classId=<%=lecture.getClass_id()%>; cancelWish();">삭제</button>
            </td>
            <td class="text-center d-none d-md-table-cell"><%=reEnrollText%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getClass_no()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getCourse_id()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getCourse_name()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getOpened()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getLecturer_name()%></td>
            <td class="text-center d-none d-md-table-cell"><%=timeText%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getPerson_enroll()%>/<%=lecture.getPerson_max()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getBuilding_name()%>,<%=lecture.getRoom_id()%>호</td>
          </tr>
  <%
      }
    }
  %>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="container_fluid"  style="margin-top:10px; margin-left:20px;">
    <h1 style="margin-top: 30px; margin-bottom:30px; margin-left: 20px; font-family: 'Nanum Pen Script'; font-size: 32px;">신청 수업</h1>
  </div>
  <script>
    var classId = null;

    function cancelRegister()
    {
      location.href='${path}/SugangServer_war_exploded/action_cancel_register.jsp?classId='+classId;
    }
  </script>
  <div class="container_fluid" style="margin-top:20px; margin-left: 16px; margin-right: 16px;">
    <div class="card shadow">
      <div class="card-body">
        <table class="table table-hover" id='board_list2'>
          <thead>
          <tr>
            <th class="text-center d-none d-md-table-cell">신청 취소</th>
            <th class="text-center d-none d-md-table-cell">재수강</th>
            <th class="text-center d-none d-md-table-cell">수업번호</th>
            <th class="text-center d-none d-md-table-cell">학수번호</th>
            <th class="text-center d-none d-md-table-cell">교과목명</th>
            <th class="text-center d-none d-md-table-cell">개설학기</th>
            <th class="text-center d-none d-md-table-cell">교강사</th>
            <th class="text-center d-none d-md-table-cell">수업시간</th>
            <th class="text-center d-none d-md-table-cell">인원</th>
            <th class="text-center d-none d-md-table-cell">강의실</th>
          </tr>
          </thead>
          <tbody>
          <%
            ArrayList<Lecture> lectureList = new ArrayList<Lecture>();
            lectureList = new RegisteredDAO().getRegisteredList();
            if (lectureList != null) {
              for(int i = 0; i < lectureList.size(); i++) {
                Lecture lecture = lectureList.get(i);
                String timeText = "E-러닝 강의";
                if (lecture.getDay_of_week() != null && !lecture.getDay_of_week().isEmpty()) {
                  String[] week = {"월", "화", "수", "목", "금", "토", "일"};
                  timeText = week[Integer.parseInt(lecture.getDay_of_week())-1] + " " + lecture.getBegin() + " - " + lecture.getEnd();
                }
                String reEnrollText = "-";
                if (lecture.getRe_enroll() > 0) {
                  if (lecture.getOpened() == 2022) {
                    reEnrollText = "-";
                  } else {
                    reEnrollText = "재수강";
                  }
                }
          %>
          <tr>
            <td class="text-center d-none d-md-table-cell">
              <button type="button" class="btn btn-danger btn-sm" onclick="classId=<%=lecture.getClass_id()%>; cancelRegister();">취소</button>
            </td>
            <td class="text-center d-none d-md-table-cell"><%=reEnrollText%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getClass_no()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getCourse_id()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getCourse_name()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getOpened()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getLecturer_name()%></td>
            <td class="text-center d-none d-md-table-cell"><%=timeText%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getPerson_enroll()%>/<%=lecture.getPerson_max()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getBuilding_name()%>,<%=lecture.getRoom_id()%>호</td>
          </tr>
          <%
              }
            }
          %>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <script src="./js/jquery-3.6.1.min.js"/>
  <script src="./js/popper.js"/>
  <script src="./js/bootstrap.min.js"/>
</body>
</html>
