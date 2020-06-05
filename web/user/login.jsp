<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <%-- https://getbootstrap.com/docs/4.4/getting-started/introduction/ --%>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/css/bootstrap.min.css"/>
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="ui.js"></script>
</head>
<body>
<div id="d" style="position: absolute;">
    <form action="${pageContext.request.contextPath}/uc" method="get">
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">账号</span>
            </div>
            <input type="text" class="form-control" placeholder="Username" id="usr" name="username" required="required">
        </div>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">密码</span>
            </div>
            <input type="password" class="form-control" placeholder="Password" id="psd" name="password"
                   required="required">
        </div>
        没有账号？去<a href="signup.jsp">注册</a>
        <input id="login" type="submit" class="btn btn-danger" style="width: 100%" name="login" value="login"/>
    </form>
</div>
</body>
</html>
