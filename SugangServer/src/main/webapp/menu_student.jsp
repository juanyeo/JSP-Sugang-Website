<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.sugangserver.student.StudentDAO" %>
<%@ page import="com.example.sugangserver.dto.Student" %>
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
    <h1 style="margin-bottom:30px; font-family: 'Nanum Pen Script'; font-size: 48px; text-align: center">학생 정보</h1>
  </div>
  <!-- 상태 선택 Modal 창 -->
  <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="statusModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="statusModalLabel">상태 변경</h4>
          <button type="button" class="btn btn-light" data-dismiss="modal" aria-label="Close" style="background-color: white">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form action="./action_update_person_max.jsp" method="post">
            <div class="row mt-4">
              <div class="col-12">
                <select id="newStatus" name="newStatus" class="form-control mx-1 mt-2">
                  <option value="재학" selected>재학</option>
                  <option value="휴학">휴학</option>
                  <option value="자퇴">자퇴</option>
                </select>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-primary" data-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary" onclick="updateStatus()">변경</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <script>
    var studentId = "";
    var newStatus = "";

    function updateStatus()
    {
      var newStatus = $('#newStatus').val();
      location.href='${path}/SugangServer_war_exploded/action_update_student_status.jsp?studentId='+studentId+'&newStatus='+newStatus;
    }
  </script>
  <div class="container_fluid" style="margin-top:20px; margin-left: 16px; margin-right: 16px;">
    <div class="card shadow">
      <div class="card-body">
        <table class="table table-hover" id='board_list'>
          <thead>
          <tr>
            <th class="text-center d-none d-md-table-cell">학번</th>
            <th class="text-center d-none d-md-table-cell">이름</th>
            <th class="text-center d-none d-md-table-cell">전공</th>
            <th class="text-center d-none d-md-table-cell">학년</th>
            <th class="text-center d-none d-md-table-cell">지도교수</th>
            <th class="text-center d-none d-md-table-cell">성적</th>
            <th class="text-center d-none d-md-table-cell">상태</th>
            <th class="text-center d-none d-md-table-cell">상태 변경</th>
          </tr>
          </thead>
          <tbody>
  <%
    ArrayList<Student> studentList = new ArrayList<Student>();
    studentList = new StudentDAO().getStudentList("");
    if (studentList != null) {
      for(int i = 0; i < studentList.size(); i++) {
        Student student = studentList.get(i);
  %>
          <tr>
            <td class="text-center d-none d-md-table-cell"><%=student.getStudent_id()%></td>
            <td class="text-center d-none d-md-table-cell"><%=student.getName()%></td>
            <td class="text-center d-none d-md-table-cell"><%=student.getMajor_name()%></td>
            <td class="text-center d-none d-md-table-cell"><%=student.getYear()%></td>
            <td class="text-center d-none d-md-table-cell"><%=student.getLecturer_name()%></td>
            <td class="text-center d-none d-md-table-cell"><%=student.getAvg_grade()%></td>
            <td class="text-center d-none d-md-table-cell"><%=student.getStatus()%></td>
            <td class="text-center d-none d-md-table-cell">
              <button type="button" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#statusModal" onclick="studentId=<%=student.getStudent_id()%>">상태 변경</button>
            </td>
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

  <!--<script src="./js/jquery-3.6.1.min.js"/>
    <script src="./js/popper.js"/>
    <script src="./js/bootstrap.min.js"/>-->
  <script src="./js/jquery-3.6.1.min.js"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
