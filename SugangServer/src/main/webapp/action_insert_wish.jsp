<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.register.RegisterDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String classId = null;

    if (request.getParameter("classId") != null) classId = request.getParameter("classId");

    RegisterDAO registerDAO = new RegisterDAO();
    int result = registerDAO.insertWish(classId);

    PrintWriter writer = response.getWriter();
    writer.println("<script>");
    if (result == -1) {
        writer.println("alert('희망 목록 추가를 실패했습니다.');");
    } else {
        writer.println("alert('수강 희망을 완료했습니다.');");
    }
    writer.println("location.href = 'menu_register.jsp'");
    writer.println("</script>");
    writer.close();
%>
