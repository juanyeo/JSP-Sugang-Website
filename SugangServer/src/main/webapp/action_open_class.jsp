<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.classes.ClassDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int classNo = 0;
    String courseId = null;
    String courseName = null;
    int majorId = 0;
    int year = 0;
    int credit = 0;
    int lecturerId = 0;
    int personMax = 0;
    int opened = 0;
    int roomId = 0;

    String dayOfWeek = null;
    String begin = null;
    String end = null;

    if (request.getParameter("classNo") != null && !"".equals(request.getParameter("classNo"))) classNo = Integer.parseInt(request.getParameter("classNo"));
    if (request.getParameter("courseId") != null) courseId = request.getParameter("courseId");
    if (request.getParameter("courseName") != null) courseName = request.getParameter("courseName");
    if (request.getParameter("majorId") != null && !"".equals(request.getParameter("majorId"))) majorId = Integer.parseInt(request.getParameter("majorId"));
    if (request.getParameter("year") != null && !"".equals(request.getParameter("year"))) year = Integer.parseInt(request.getParameter("year"));
    if (request.getParameter("credit") != null && !"".equals(request.getParameter("credit"))) credit = Integer.parseInt(request.getParameter("credit"));
    if (request.getParameter("lecturerId") != null && !"".equals(request.getParameter("lecturerId"))) lecturerId = Integer.parseInt(request.getParameter("lecturerId"));
    if (request.getParameter("personMax") != null && !"".equals(request.getParameter("personMax"))) personMax = Integer.parseInt(request.getParameter("personMax"));
    if (request.getParameter("opened") != null && !"".equals(request.getParameter("opened"))) opened = Integer.parseInt(request.getParameter("opened"));
    if (request.getParameter("roomId") != null && !"".equals(request.getParameter("roomId"))) roomId = Integer.parseInt(request.getParameter("roomId"));

    if (request.getParameter("dayOfWeek") != null) dayOfWeek = request.getParameter("dayOfWeek");
    if (request.getParameter("begin") != null) begin = request.getParameter("begin");
    if (request.getParameter("end") != null) end = request.getParameter("end");

    if (courseId == null || courseName == null || classNo*majorId*year*credit*lecturerId*personMax*opened*roomId == 0) {
        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        writer.println("alert('입력 안 된 필드가 있습니다.');");
        writer.println("history.back();");
        writer.println("</script>");
        writer.close();
        return;
    }

    ClassDAO classDAO = new ClassDAO();

    Lecture validatedLecture = classDAO.validateOpenLecture(new Lecture(0, classNo, courseId, courseName, majorId, "", year, credit, lecturerId, "", personMax, opened, roomId, "", dayOfWeek, begin, end, 0));

    if (!"SUCCESS".equals(validatedLecture.getValidation_message())) {
        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        writer.println("alert('" + validatedLecture.getValidation_message() + "');");
        writer.println("history.back();");
        writer.println("</script>");
        writer.close();
        return;
    }

    int result = classDAO.write(validatedLecture);

    PrintWriter writer = response.getWriter();
    writer.println("<script>");
    if (result == -1) {
        writer.println("alert('강의 설강을 실패했습니다.');");
        writer.println("history.back();");
    } else {
        writer.println("alert('강의 설강을 완료했습니다.');");
        writer.println("location.href = 'menu_classes.jsp'");
    }
    writer.println("</script>");
    writer.close();
%>
