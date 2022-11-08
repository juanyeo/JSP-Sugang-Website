<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.sugangserver.timetable.TimetableDAO" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.UserInfo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.Integer" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.example.sugangserver.UserInfo" %>
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
    String studentIdSearch = "";

    if (request.getParameter("studentIdSearch") != null) {
      studentIdSearch = request.getParameter("studentIdSearch");
    }
  %>
  <div class="container"  style="margin-top:10px; margin-left:20px;">
    <h1 style="margin-bottom:30px; font-family: 'Nanum Pen Script'; font-size: 48px; text-align: center">수업 시간표</h1>
    <%
      if (userInfoDef.isAdmin()) {
    %>
    <form method="get" action="menu_timetable.jsp" class="row gy-2 gx-3 align-items-center">
      <div class="col-auto">
        <input type="text" <% if(!"".equals(studentIdSearch)) out.println("value=" + studentIdSearch); %> name="studentIdSearch" class="form-control mx-1 mt-2" placeholder="학생 ID를 입력하세요">
      </div>
      <div class="col-auto">
        <button type="submit" class="btn btn-primary mx-1 mt-2">시간표 검색</button>
      </div>
    </form>
    <%
      }
    %>
  </div>

  <div class="container" style="margin-top:20px; margin-left: 16px; margin-right: 16px;">
    <div class="card shadow">
      <div class="card-body">
        <table class="table table-bordered" id='board_list'>
          <thead>
          <tr>
            <th class="text-center d-none d-md-table-cell table-active align-middle" style="width: 10%">-</th>
            <th class="text-center d-none d-md-table-cell table-active align-middle" style="width: 18%"><h5>월요일</h5></th>
            <th class="text-center d-none d-md-table-cell table-active align-middle" style="width: 18%"><h5>화요일</h5></th>
            <th class="text-center d-none d-md-table-cell table-active align-middle" style="width: 18%"><h5>수요일</h5></th>
            <th class="text-center d-none d-md-table-cell table-active align-middle" style="width: 18%"><h5>목요일</h5></th>
            <th class="text-center d-none d-md-table-cell table-active align-middle" style="width: 18%"><h5>금요일</h5></th>
          </tr>
          </thead>
          <tbody>
  <%
    ArrayList<Lecture> lectureList = new ArrayList<Lecture>();
    UserInfo userInfo = UserInfo.getInstance();
    String studentId = userInfo.getUserId();
    if (!"".equals(studentIdSearch)) studentId = studentIdSearch;

    lectureList = new TimetableDAO().getTimeTableList(studentId, 2022);

    String[] weekTimes = {"00:00-02:00", "02:00-04:00", "04:00-06:00", "06:00-08:00", "08:00-12:00"};
    for(int r = 0; r < 5; r++) {
      String[] weekSchedule = {"", "", "", "", ""};
      for(int i = 0; i < lectureList.size(); i++) {
        Lecture lecture = lectureList.get(i);

        if (lecture.getBegin() != null && !"".equals(lecture.getBegin())) {
          String startMin = "0" + String.valueOf(r * 2) + ":00";
          String startMax = "0" + String.valueOf(r * 2 + 1) + ":01";
          String givenStart = lecture.getBegin();

          if (startMin.compareTo(givenStart) <= 0 && startMax.compareTo(givenStart) > 0) {
            // 시간대 포함
            String lectureText = "<b>" + lecture.getCourse_name() + "</b><br/>" + lecture.getLecturer_name() + " 교수님" + "<br/>(" + lecture.getBegin() + "-" + lecture.getEnd() + ")";
            int dayOfWeek = Integer.parseInt(lecture.getDay_of_week());
            if (dayOfWeek != 6) weekSchedule[dayOfWeek-1] = lectureText;
          }
        }

      }
  %>
          <tr>
            <td class="text-center d-none d-md-table-cell table-info align-self-center align-middle"><h5><%=weekTimes[r]%></h5></td>
            <td class="text-center d-none d-md-table-cell <% if(!"".equals(weekSchedule[0])) out.println("table-warning"); %>"><%=weekSchedule[0]%></td>
            <td class="text-center d-none d-md-table-cell <% if(!"".equals(weekSchedule[1])) out.println("table-warning"); %>"><%=weekSchedule[1]%></td>
            <td class="text-center d-none d-md-table-cell <% if(!"".equals(weekSchedule[2])) out.println("table-warning"); %>"><%=weekSchedule[2]%></td>
            <td class="text-center d-none d-md-table-cell <% if(!"".equals(weekSchedule[3])) out.println("table-warning"); %>"><%=weekSchedule[3]%></td>
            <td class="text-center d-none d-md-table-cell <% if(!"".equals(weekSchedule[4])) out.println("table-warning"); %>"><%=weekSchedule[4]%></td>
          </tr>
  <%
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
