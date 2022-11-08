<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.register.RegisterDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String classId = null;

    if (request.getParameter("classId") != null) classId = request.getParameter("classId");

    RegisterDAO registerDAO = new RegisterDAO();
    int validationResult = registerDAO.validateCredit(classId);

    if (validationResult == 0) {
        int result = registerDAO.insertCredit(classId);

        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        if (result == -1) {
            writer.println("alert('수강 신청을 실패했습니다.');");
        } else {
            writer.println("alert('수강 신청을 완료했습니다.');");
        }
        writer.println("location.href = 'menu_register.jsp'");
        writer.println("</script>");
        writer.close();
    } else {
        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        if (validationResult == 1) {
            writer.println("alert('[신청 실패] 지난 성적이 B0 이상입니다.');");
        } else if (validationResult == 2) {
            writer.println("alert('[신청 실패] 정원이 모두 찼습니다.');");
        } else if (validationResult == 3) {
            writer.println("alert('[신청 실패] 동일 시간대에 신청된 과목이 있습니다.');");
        } else if (validationResult == 4) {
            writer.println("alert('[신청 실패] 최대학점(18학점)을 초과하였습니다.');");
        } else {
            writer.println("alert('[신청 실패] 이미 신청한 강의입니다.');");
        }
        writer.println("location.href = 'menu_register.jsp'");
        writer.println("</script>");
        writer.close();
    }
%>
