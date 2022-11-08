<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>수강신청</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.css">
</head>
<body>
    <jsp:forward page="login.jsp"></jsp:forward>
    <%@ include file="top_navigation.jsp"%>

    <a href="menu_classes.jsp">Class List</a>
    <a href="login.jsp">Login</a>

    <!--<script src="./js/jquery-3.6.1.min.js"/>
    <script src="./js/popper.js"/>
    <script src="./js/bootstrap.min.js"/>-->
    <script src="./js/jquery-3.6.1.min.js"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>