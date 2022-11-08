<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.example.sugangserver.UserInfo"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Navigation Bar</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #6a1b9a;">
  <a class="navbar-brand" href="menu_classes.jsp" style="margin-left: 20px; color: #e1bee7">
    <img src="./asset/lion_icon.png" alt="" width="45" height="45" style="margin-right: 10px;">
    수강신청 Database
  </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <%
    UserInfo userInfoDef = UserInfo.getInstance();
  %>
  <div id="navbar" class="collapse navbar-collapse">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active"  style="padding: 12px;">
        <a class="nav-link" href="menu_classes.jsp" style="color: white; font-family: 'Jeju Gothic'; font-size: large">
          수강 편람
        </a>
      </li>
      <%
        if (!userInfoDef.isAdmin()) {
      %>
      <li class="nav-item active"  style="padding: 12px;">
        <a class="nav-link" href="menu_register.jsp" style="color: white; font-family: 'Jeju Gothic'; font-size: large">
          수강 신청
        </a>
      </li>
      <li class="nav-item active"  style="padding: 12px;">
        <a class="nav-link" href="menu_registered.jsp" style="color: white; font-family: 'Jeju Gothic'; font-size: large">
          신청/희망 수업
        </a>
      </li>
      <%
        }
      %>
      <%
        if (userInfoDef.isAdmin()) {
      %>
      <li class="nav-item active"  style="padding: 12px;">
        <a class="nav-link" href="menu_student.jsp" style="color: white; font-family: 'Jeju Gothic'; font-size: large">
          학생 정보
        </a>
      </li>
      <li class="nav-item active"  style="padding: 12px;">
        <a class="nav-link" href="menu_olap.jsp" style="color: white; font-family: 'Jeju Gothic'; font-size: large">
          통계 OLAP
        </a>
      </li>
      <%
        }
      %>
      <li class="nav-item active"  style="padding: 12px;">
        <a class="nav-link" href="menu_timetable.jsp" style="color: white; font-family: 'Jeju Gothic'; font-size: large">
          수업 시간표
        </a>
      </li>
      <li class="nav-item active"  style="padding: 12px;">
        <a class="nav-link" href="action_logout.jsp" style="color: white; font-family: 'Jeju Gothic'; font-size: large">
          로그아웃
        </a>
      </li>
    </ul>
  </div>
</nav>

</h1>
<br/>
</body>
</html>
