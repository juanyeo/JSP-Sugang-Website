<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.sugangserver.classes.MainDAO" %>
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
    int semesterSelect = 0;
    String classNoSearch = "";
    String courseIdSearch = "";
    String courseNameSearch = "";
    if (request.getParameter("semesterSelect") != null) {
      try {
        semesterSelect = Integer.parseInt(request.getParameter("semesterSelect"));
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    if (request.getParameter("classNoSearch") != null) {
      classNoSearch = request.getParameter("classNoSearch");
    }
    if (request.getParameter("courseIdSearch") != null) {
      courseIdSearch = request.getParameter("courseIdSearch");
    }
    if (request.getParameter("courseNameSearch") != null) {
      courseNameSearch = request.getParameter("courseNameSearch");
    }
  %>
  <div class="container-fluid" style="margin-top:10px; margin-left:20px;">
    <h1 style="margin-bottom:30px; font-family: 'Nanum Pen Script'; font-size: 48px; text-align: center">수강 편람</h1>
    <form method="get" action="menu_classes.jsp" class="row gy-2 gx-3 align-items-center">
      <div class="col-auto">
        <select name="semesterSelect" class="form-control mx-1 mt-2">
          <option value=0>전체</option>
          <option value=2022 <% if(semesterSelect == 2022) out.println("selected"); %>>2022</option>
          <option value=2021 <% if(semesterSelect == 2021) out.println("selected"); %>>2021</option>
          <option value=2020 <% if(semesterSelect == 2020) out.println("selected"); %>>2020</option>
          <option value=2019 <% if(semesterSelect == 2019) out.println("selected"); %>>2019</option>
        </select>
      </div>
      <div class="col-sm-auto">
        <input type="text" <% if(!"".equals(classNoSearch)) out.println("value=" + classNoSearch); %> name="classNoSearch" class="form-control mx-1 mt-2" placeholder="수업번호">
      </div>
      <div class="col-sm-auto">
        <input type="text" <% if(!"".equals(courseIdSearch)) out.println("value=" + courseIdSearch); %> name="courseIdSearch" class="form-control mx-1 mt-2" placeholder="학수번호">
      </div>
      <div class="col-sm-auto">
        <input type="text" <% if(!"".equals(courseNameSearch)) out.println("value=" + courseNameSearch); %> name="courseNameSearch" class="form-control mx-1 mt-2" placeholder="교과목명">
      </div>
      <div class="col-auto">
        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
      </div>
      <%
        if (userInfoDef.isAdmin()) {
      %>
      <div class="col-auto">
        <a class="btn btn-outline-info mt-2 float-end" data-toggle="modal" href="#openModal">+ 강의 설강</a>
      </div>
      <%
        }
      %>
    </form>
  </div>
  <!-- Modal 창 -->
  <div class="modal fade" id="openModal" tabindex="-1" role="dialog" aria-labelledby="openModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="openModalLabel">강의 설강</h4>
          <button type="button" class="btn btn-light" data-dismiss="modal" aria-label="Close" style="background-color: white">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <b style="font-size: 14px; font-family: 'Jeju Gothic'">*관리자는 설강하고자 하는 강의에 대한 ID 정보를 미리 확인부탁드립니다.</b>
          <form action="./action_open_class.jsp" method="post">
            <div class="row mt-4">
              <div class="col-auto">
                <label>수업번호</label>
                <input type="text" name="classNo" class="form-control" maxlength="20" placeholder="10042">
              </div>
              <div class="col-auto">
                <label>학수번호</label>
                <input type="text" name="courseId" class="form-control" maxlength="20" placeholder="ITE3016">
              </div>
            </div>
            <div class="row mt-4">
              <div class="col-12">
                <label>교과목명</label>
                <input type="text" name="courseName" class="form-control" maxlength="40" placeholder="데이터베이스시스템">
              </div>
            </div>
            <div class="row mt-4">
              <div class="col-4">
                <label>학기(년)</label>
                <input type="text" name="opened" class="form-control" maxlength="4" placeholder="2022">
              </div>
              <div class="col-3">
                <label>학점</label>
                <input type="text" name="credit" class="form-control" maxlength="2" placeholder="3">
              </div>
              <div class="col-3">
                <label>대상학년</label>
                <input type="text" name="year" class="form-control" maxlength="4" placeholder="2">
              </div>
            </div>
            <div class="row mt-4">
              <div class="col-4">
                <label>전공 ID</label>
                <input type="text" name="majorId" class="form-control" maxlength="3" placeholder="3">
              </div>
              <div class="col-8">
                <label>교강사 ID</label>
                <input type="text" name="lecturerId" class="form-control" maxlength="20" placeholder="2001032071">
              </div>
            </div>
            <div class="row mt-4">
              <div class="col-4">
                <label>강의실 ID</label>
                <input type="text" name="roomId" class="form-control" maxlength="4" placeholder="108">
              </div>
              <div class="col-3">
                <label>최대 인원</label>
                <input type="text" name="personMax" class="form-control" maxlength="4" placeholder="30">
              </div>
              <div class="col-5">
                <button type="button" class="btn btn-danger mx-1 mt-4">강의실 이용 확인</button>
              </div>
            </div>
            <div class="row mt-4 mb-4">
              <div class="col-3">
                <label>요일</label>
                <select name="dayOfWeek" class="form-control">
                  <option value="1" selected>월</option>
                  <option value="2" selected>화</option>
                  <option value="3" selected>수</option>
                  <option value="4" selected>목</option>
                  <option value="5" selected>금</option>
                  <option value="6" selected>토</option>
                </select>
              </div>
              <div class="col-4">
                <label>시작시간</label>
                <input type="text" name="begin" class="form-control" maxlength="5" placeholder="09:00">
              </div>
              <div class="col-4">
                <label>마침시간</label>
                <input type="text" name="end" class="form-control" maxlength="5" placeholder="11:00">
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-primary" data-dismiss="modal">취소</button>
              <button type="submit" class="btn btn-primary">설강하기</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!-- 인원 입력 Modal 창 -->
  <div class="modal fade" id="personModal" tabindex="-1" role="dialog" aria-labelledby="personModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="personModalLabel">과목 증원</h4>
          <button type="button" class="btn btn-light" data-dismiss="modal" aria-label="Close" style="background-color: white">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form action="./action_update_person_max.jsp" method="post">
            <div class="row mt-4">
              <div class="col-12">
                <input type="text" id="newPersonMax" name="newPersonMax" class="form-control" maxlength="4" placeholder="새로운 수강 정원을 입력하세요.">
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-primary" data-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary" onclick="updatePerson()">적용</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!-- 학생 ID 입력 Modal 창 -->
  <div class="modal fade" id="studentModal" tabindex="-1" role="dialog" aria-labelledby="studentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="studentModalLabel">학생 등록</h4>
          <button type="button" class="btn btn-light" data-dismiss="modal" aria-label="Close" style="background-color: white">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form action="./action_update_person_max.jsp" method="post">
            <div class="row mt-4">
              <div class="col-12">
                <input type="text" id="modalStudentId" name="modalStudentId" class="form-control" maxlength="20" placeholder="등록할 학생의 ID를 입력하세요.">
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-primary" data-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary" onclick="insertStudent()">등록</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <script>
    var classId="";
    var personMax="";

    function updatePerson()
    {
      var newPersonMax = $('#newPersonMax').val();
      location.href='${path}/SugangServer_war_exploded/action_update_person_max.jsp?classId='+classId+'&newPersonMax='+newPersonMax;
    }

    function insertStudent()
    {
      var studentID = $('#modalStudentId').val();
      location.href='${path}/SugangServer_war_exploded/action_insert_student_to_class.jsp?classId='+classId+'&personMax='+personMax+'&studentId='+studentID;
    }

    function deleteClass()
    {
      location.href='${path}/SugangServer_war_exploded/action_delete_class.jsp?classId='+classId;
    }
  </script>
  <!-- 강의 목록 -->
  <div class="container-fluid" style="margin-top:20px">
    <div class="card shadow">
      <div class="card-body">
        <table class="table table-hover" id='board_list'>
          <thead>
          <tr>
            <th class="text-center d-none d-md-table-cell">수업번호</th>
            <th class="text-center d-none d-md-table-cell">학수번호</th>
            <th class="text-center d-none d-md-table-cell">교과목명</th>
            <th class="text-center d-none d-md-table-cell">개설학기</th>
            <th class="text-center d-none d-md-table-cell">교강사</th>
            <th class="text-center d-none d-md-table-cell">수업시간</th>
            <th class="text-center d-none d-md-table-cell">인원</th>
            <th class="text-center d-none d-md-table-cell">강의실</th>
            <%
              if (userInfoDef.isAdmin()) {
            %>
            <th class="text-center d-none d-md-table-cell">과목 상태 변경</th>
            <%
              }
            %>
          </tr>
          </thead>
          <tbody>
  <%
    ArrayList<Lecture> lectureList = new ArrayList<Lecture>();
    lectureList = new MainDAO().getList(semesterSelect, classNoSearch, courseIdSearch, courseNameSearch);
    if (lectureList != null) {
      for(int i = 0; i < lectureList.size(); i++) {
        Lecture lecture = lectureList.get(i);
        String timeText = "E-러닝 강의";
        if (lecture.getDay_of_week() != null && !lecture.getDay_of_week().isEmpty()) {
          String[] week = {"월", "화", "수", "목", "금", "토", "일"};
          timeText = week[Integer.parseInt(lecture.getDay_of_week())-1] + " " + lecture.getBegin() + " - " + lecture.getEnd();
        }
  %>
          <tr>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getClass_no()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getCourse_id()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getCourse_name()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getOpened()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getLecturer_name()%></td>
            <td class="text-center d-none d-md-table-cell"><%=timeText%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getPerson_enroll()%>/<%=lecture.getPerson_max()%></td>
            <td class="text-center d-none d-md-table-cell"><%=lecture.getBuilding_name()%>,<%=lecture.getRoom_id()%>호</td>
            <%
              if (userInfoDef.isAdmin()) {
            %>
            <td class="text-center d-none d-md-table-cell">
              <button type="button" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#personModal" onclick="classId=<%=lecture.getClass_id()%>">증원</button>
              <button type="button" class="btn btn-light btn-sm" data-toggle="modal" data-target="#studentModal" onclick="classId=<%=lecture.getClass_id()%>;personMax=<%=lecture.getPerson_max()%>">학생 등록</button>
              <button type="button" class="btn btn-dark btn-sm" onclick="classId=<%=lecture.getClass_id()%>; deleteClass();">폐강</button>
            </td>
            <%
              }
            %>
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
