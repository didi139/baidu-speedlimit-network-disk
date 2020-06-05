<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <%-- https://getbootstrap.com/docs/4.4/getting-started/introduction/ --%>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/css/bootstrap.min.css"/>
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="ui.js"></script>
    <script>
        function checkPassword() {
            if ($("#psd").val() !== $("#psd2").val()) {
                window.alert("两次输入的密码不一致！");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div id="d" style="position: absolute;">
    <form action="${pageContext.request.contextPath}/uc" method="post">
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
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">确认</span>
            </div>
            <input type="password" class="form-control" placeholder="Password" id="psd2" name="password"
                   required="required">
        </div>
        已有账号？去<a href="login.jsp">登录</a>
        <input id="signup" onclick="return checkPassword()" type="submit" class="btn btn-danger" style="width: 100%;margin-top: 10px"
               name="signup"
               value="signup"/>
    </form>
</div>
</body>
</html>
