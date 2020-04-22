<%@ page import="java.util.Map" %>
<%@ page import="db.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录/注册</title>
    <%-- https://getbootstrap.com/docs/4.4/getting-started/introduction/ --%>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/css/bootstrap.min.css"/>
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/cookie.js"></script>
    <script>
        $('#d').ready(() => {
            let d = $('#d');
            d.css({
                'left': ((window.innerWidth - d.width()) / 2) + 'px',
                'top': ((window.innerHeight - d.height()) / 2) + 'px'
            });
            $(window).resize(() => d.css({
                'left': ((window.innerWidth - d.width()) / 2) + 'px',
                'top': ((window.innerHeight - d.height()) / 2) + 'px'
            }));
        });

        $('#login').click(() => {
            clearCookie('username');
            clearCookie('password');
        });

        $('#signup').click(() => {
            clearCookie('username');
            clearCookie('password');
        });
    </script>
</head>
<body>

<%
    if (request.getParameter("login") != null) {
        try {
            new User(request.getParameter("username"), request.getParameter("password"));
            Cookie username = new Cookie("username", request.getParameter("username"));
            Cookie password = new Cookie("password", request.getParameter("password"));
            username.setPath("/");
            password.setPath("/");
            response.addCookie(username);
            response.addCookie(password);
            response.sendRedirect("../buy/center/vip.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    for (Map.Entry<String, String[]> me : request.getParameterMap().entrySet()) {
        System.out.println(me.getKey() + "  " + me.getValue()[0]);
    }
    if (request.getParameterMap() != null) {

    }
%>

<div id="d" style="position: absolute;">
    <form>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">账号</span>
            </div>
            <input type="text" class="form-control" placeholder="Username" id="usr" name="username">
        </div>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">密码</span>
            </div>
            <input type="password" class="form-control" placeholder="Password" id="psd" name="password">
        </div>
        <input id="login" type="submit" class="btn btn-danger" style="width: 100%" name="login" value="login"/>
        <input id="signup" type="submit" class="btn btn-danger" style="width: 100%;margin-top: 10px" name="signup"
               value="signup"/>
    </form>
</div>
</body>
</html>