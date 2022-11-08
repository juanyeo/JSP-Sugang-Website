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
    <section class="container mt-3" style="max-width: 560px;">
        <div class="card shadow">
            <div class="card-body">
                <h3 style="margin-top: 20px; font-size: 38px">HYU 수강신청 로그인</h3>
                <a class="w-100" href="#">
                    <img src="./asset/lion_icon.png" alt="" width="200" height="200" style="margin-top: 40px; margin-bottom: 40px;">
                </a>
                <form method="post" action="./action_login.jsp">
                    <div class="form-group">
                        <label>학번</label>
                        <input type="text" name="userId" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>비밀번호</label>
                        <input type="password" name="userPassword" class="form-control">
                    </div>
                    <button type="submit" class="btn-lg btn-warning">로그인</button>
                </form>
            </div>
        </div>
    </section>

    <!--<script src="./js/jquery-3.6.1.min.js"/>
    <script src="./js/popper.js"/>
    <script src="./js/bootstrap.min.js"/>-->
    <script src="./js/jquery-3.6.1.min.js"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>