<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.classes.ClassDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String classId = null;

    if (request.getParameter("classId") != null) classId = request.getParameter("classId");

    ClassDAO classDAO = new ClassDAO();
    int result = classDAO.deleteLecture(classId);

    PrintWriter writer = response.getWriter();
    writer.println("<script>");
    if (result == -1) {
        writer.println("alert('폐강을 실패했습니다.');");
        writer.println("history.back();");
    } else {
        writer.println("alert('폐강을 완료했습니다.');");
        writer.println("location.href = 'menu_classes.jsp'");
    }
    writer.println("</script>");
    writer.close();
%>
