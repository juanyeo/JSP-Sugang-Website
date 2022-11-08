<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.dto.Lecture" %>
<%@ page import="com.example.sugangserver.login.LoginDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = null;
    String userPassword = null;

    if (request.getParameter("userId") != null) userId = request.getParameter("userId");
    if (request.getParameter("userPassword") != null) userPassword = request.getParameter("userPassword");

    if (userId == null || userPassword == null) {
        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        writer.println("alert('입력 안 된 필드가 있습니다.');");
        writer.println("history.back();");
        writer.println("</script>");
        writer.close();
        return;
    }

    LoginDAO loginDAO = new LoginDAO();
    int result = loginDAO.login(userId, userPassword);

    if (result == 1) {
        session.setAttribute("userId", userId);
        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        writer.println("location.href = 'menu_classes.jsp'");
        writer.println("</script>");
        writer.close();
    } else {
        PrintWriter writer = response.getWriter();
        writer.println("<script>");
        if (result == 0) {
            writer.println("alert('[로그인 실패] 비밀번호가 맞지 않습니다.');");
        } else if (result == -1) {
            writer.println("alert('[로그인 실패] 학번이 존재하지 않습니다.');");
        } else {
            writer.println("alert('[로그인 실패] 데이터베이스 오류가 발생했습니다.');");
        }
        writer.println("history.back();");
        writer.println("</script>");
        writer.close();
    }
%>
