<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.student.StudentDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String studentId = null;
    String newStatus = null;

    if (request.getParameter("studentId") != null) studentId = request.getParameter("studentId");
    if (request.getParameter("newStatus") != null) newStatus = request.getParameter("newStatus");

    if (newStatus == null) {
        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        writer.println("alert('상태를 선택해주세요.');");
        writer.println("history.back();");
        writer.println("</script>");
        writer.close();
        return;
    }

    StudentDAO studentDAO = new StudentDAO();
    int result = studentDAO.updateStatus(studentId, newStatus);

    PrintWriter writer = response.getWriter();
    writer.println("<script>");
    if (result == -1) {
        writer.println("alert('상태 변경을 실패했습니다.');");
        writer.println("history.back();");
    } else {
        writer.println("alert('상태 변경을 완료했습니다.');");
        writer.println("location.href = 'menu_student.jsp'");
    }
    writer.println("</script>");
    writer.close();
%>
