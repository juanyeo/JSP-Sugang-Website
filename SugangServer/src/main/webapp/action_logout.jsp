<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.sugangserver.UserInfo" %>
<%
    session.invalidate();

    UserInfo userInfo = UserInfo.getInstance();
    userInfo.setUserId(null);
    userInfo.setAdmin(false);
%>
<script>
    location.href = "index.jsp";
</script>
