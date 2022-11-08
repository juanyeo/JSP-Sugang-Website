<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.registered.WishDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String classId = null;

    if (request.getParameter("classId") != null) classId = request.getParameter("classId");

    WishDAO wishDAO = new WishDAO();
    int result = wishDAO.cancelWish(classId);

    PrintWriter writer = response.getWriter();
    writer.println("<script>");
    if (result == -1) {
        writer.println("alert('희망 취소를 마치지 못했습니다.');");
        writer.println("history.back();");
    } else {
        writer.println("alert('수강 희망이 취소 되었습니다.');");
        writer.println("location.href = 'menu_registered.jsp'");
    }
    writer.println("</script>");
    writer.close();
%>
