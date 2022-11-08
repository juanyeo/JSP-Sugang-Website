<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.classes.ClassDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String classId = null;
    String newPersonMax = null;

    if (request.getParameter("classId") != null) classId = request.getParameter("classId");
    if (request.getParameter("newPersonMax") != null) newPersonMax = request.getParameter("newPersonMax");

    if (newPersonMax == null) {
        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        writer.println("alert('새로운 인원수를 입력해주세요.');");
        writer.println("history.back();");
        writer.println("</script>");
        writer.close();
        return;
    }

    ClassDAO classDAO = new ClassDAO();
    int result = classDAO.updatePersonMax(classId, newPersonMax);

    PrintWriter writer = response.getWriter();
    writer.println("<script>");
    if (result == -1) {
        writer.println("alert('증원을 실패했습니다.');");
        writer.println("history.back();");
    } else {
        writer.println("alert('증원을 완료했습니다.');");
        writer.println("location.href = 'menu_classes.jsp'");
    }
    writer.println("</script>");
    writer.close();
%>
