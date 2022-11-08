<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.sugangserver.tutorial.TutoDAO"%>
<%@ page import="com.example.sugangserver.tutorial.TutoDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%
  request.setCharacterEncoding("UTF-8");
  String userID = null;
  String userPassword = null;
  if (request.getParameter("userID") != null) {
    userID = (String) request.getParameter("userID");
  }
  if (request.getParameter("userPassword") != null) {
    userPassword = (String) request.getParameter("userPassword");
  }

  if (userID == null || userPassword == null) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('입력이 안 된 필드가 있다면 채워주세요, 모든 필드를 올바르게 입력해주세요.');");
    script.println("history.bach();");
    script.println("</script>");
    script.close();
    return;
  }

  TutoDAO tutoDAO = new TutoDAO();
  int result = tutoDAO.intro(userID, userPassword);
  if (result == 1) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('정보 입력에 성공했습니다.');");
    script.println("location.href = 'tutorial.jsp';");
    script.println("</script>");
    script.close();
    return;
  }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
