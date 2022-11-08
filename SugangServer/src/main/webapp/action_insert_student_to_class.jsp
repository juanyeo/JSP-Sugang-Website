<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.classes.ClassDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String classId = null;
    String personMax = null;
    String studentId = null;

    if (request.getParameter("classId") != null) classId = request.getParameter("classId");
    if (request.getParameter("personMax") != null) personMax = request.getParameter("personMax");
    if (request.getParameter("studentId") != null) studentId = request.getParameter("studentId");

    if (studentId == null) {
        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        writer.println("alert('등록할 학생 ID를 입력해주세요.');");
        writer.println("history.back();");
        writer.println("</script>");
        writer.close();
        return;
    }

    ClassDAO classDAO = new ClassDAO();
    int result = classDAO.insertStudentToClass(classId, personMax, studentId);

    PrintWriter writer = response.getWriter();
    writer.println("<script>");
    if (result == -1) {
        writer.println("alert('학생 등록을 실패했습니다.');");
        writer.println("history.back();");
    } else {
        writer.println("alert('학생 등록을 완료했습니다.');");
        writer.println("location.href = 'menu_classes.jsp'");
    }
    writer.println("</script>");
    writer.close();
%>
