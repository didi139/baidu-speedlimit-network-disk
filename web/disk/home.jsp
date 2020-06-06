<%@ page import="bean.AssetBean" %>
<%@ page import="dao.Asset" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="user" class="bean.UserBean" scope="session"/>
<% if (user.getName().equals("")) {
    response.sendRedirect("../uc");
}%>
<html>
<head>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.svg" type="image/svg"/>
    <title>%°网盘-全部文件</title>
    <%-- https://getbootstrap.com/docs/4.4/getting-started/introduction/ --%>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/css/bootstrap.min.css"/>
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <!-- custom style and script -->
    <link rel="stylesheet" href="home.css"/>
</head>
<body>
<div id="bg">
    <form action="${pageContext.request.contextPath}/ac" method="post" enctype="multipart/form-data">
        <input type="file" class="btn btn-primary" name="filename" required="required">
        <input type="submit" class="btn btn-primary" value="☁ 上传">
    </form>
    用户：
    <jsp:getProperty name="user" property="name"/>
    欢迎！<a href="${pageContext.request.contextPath}/uc?exit">退出登录</a>
    <br/>

    <table class="table table-hover" style="margin-top: 30px">
        <thead>
        <tr>
            <th>文件名</th>
            <th>大小</th>
            <th>创建时间</th>
            <th>动作</th>
        </tr>
        </thead>
        <tbody>
        <% AssetBean[] beans = null;
            try {
                beans = Asset.list(user.getId());
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
            if (beans == null) {
                out.write("错误：无法获取文件信息！");
            } else {
                for (AssetBean it : beans) {
        %>
        <tr>
            <td><%=it.getName()%>
            </td>
            <td><%=it.getSize() + "B"%>
            </td>
            <td><%=it.getCreatedTime()%>
            </td>
            <td><a href="${pageContext.request.contextPath}/ac?filename=<%=it.getName()%>">下载</a>
                <a href="${pageContext.request.contextPath}/ac?filename=<%=it.getName()%>&type=delete">删除</a>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
