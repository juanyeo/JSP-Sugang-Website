<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.sugangserver.olap.OlapDAO" %>
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
    <h1 style="margin-bottom:30px; font-family: 'Nanum Pen Script'; font-size: 48px; text-align: center">통계 OLAP</h1>
  </div>
  <div class="container-fluid row align-items-center" style="margin-top:20px; margin-left: 16px; margin-right: 16px;">
    <div class="card col-auto shadow" style="margin-right: 36px">
      <div class="card-body">
        <h3 style="margin-bottom: 30px">1. 학점 받기 어려운 교과목 Top 10</h3>
        <table class="table table-hover" id='board_list'>
          <thead>
          <tr>
            <th class="text-center d-none d-md-table-cell">순위</th>
            <th class="text-center d-none d-md-table-cell">교과목명</th>
            <th class="text-center d-none d-md-table-cell">교강사</th>
            <th class="text-center d-none d-md-table-cell">(평점평균-과목학점)의 평균</th>
          </tr>
          </thead>
          <tbody>
  <%
    ArrayList<String[]> hellClassList = new ArrayList<>();
    hellClassList = new OlapDAO().getTopTenList();
    if (hellClassList != null) {
      for(int i = 0; i < hellClassList.size(); i++) {
        String[] hellClass = hellClassList.get(i);
  %>
          <tr>
            <td class="text-center d-none d-md-table-cell"><%=i+1%></td>
            <td class="text-center d-none d-md-table-cell"><%=hellClass[1]%></td>
            <td class="text-center d-none d-md-table-cell"><%=hellClass[2]%></td>
            <td class="text-center d-none d-md-table-cell"><%=hellClass[3]%></td>
          </tr>
  <%
      }
    }
  %>
          </tbody>
        </table>
      </div>
    </div>
    <div class="card col-auto shadow" style="width: 40%;">
      <div class="card-body">
        <h3 style="margin-bottom: 30px">2. 학점 평균이 가장 높은 학과 Top 10</h3>
        <table class="table table-hover" id='board_list2'>
          <thead>
          <tr>
            <th class="text-center d-none d-md-table-cell">순위</th>
            <th class="text-center d-none d-md-table-cell">학과명</th>
            <th class="text-center d-none d-md-table-cell">(학과 교과목평점)의 평균</th>
          </tr>
          </thead>
          <tbody>
          <%
            ArrayList<String[]> hellMajorList = new ArrayList<>();
            hellMajorList = new OlapDAO().getTopTenMajorList();
            hellMajorList.add(new String[]{"-", "-"});
            if (hellMajorList != null) {
              for(int i = 0; i < 10; i++) {
                String[] hellMajor = hellMajorList.get(i);
          %>
          <tr>
            <td class="text-center d-none d-md-table-cell"><%=i+1%></td>
            <td class="text-center d-none d-md-table-cell"><%=hellMajor[0]%></td>
            <td class="text-center d-none d-md-table-cell"><%=hellMajor[1]%></td>
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
