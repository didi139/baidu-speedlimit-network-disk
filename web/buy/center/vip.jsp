<%@ page import="db.User" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.svg" type="image/svg"/>
    <title>首页-圈钱中心-%°网盘</title>
    <%-- https://getbootstrap.com/docs/4.4/getting-started/introduction/ --%>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/css/bootstrap.min.css"/>
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <!-- custom style and script -->
    <link rel="stylesheet" href="center.css"/>
    <script src="${pageContext.request.contextPath}/cookie.js"></script>
    <script src="center.js"></script>
</head>
<body>
<nav class="navbar navbar-dark justify-content-center fixed-top baidu-navbar">
    <!-- logo -->
    <a class="navbar-brand row" href="javascript:void(0)">
        <img class="baidu-logo" src="${pageContext.request.contextPath}/logo.svg" alt="logo"/>
        &nbsp;<b>%°网盘会员</b>
    </a>
    <!-- link -->
    <ul class="nav baidu-nav">
        <li class="nav-item baidu-nav-item">
            <a class="nav-link disabled" href="#"><span class="">炒鸡会员</span></a></li>
        <li class="nav-item baidu-nav-item">
            <a class="nav-link active baidu-nav-link"
               href="javascript:void(0)"><span class="baidu-underline">会员</span></a></li>
        <li class="nav-item baidu-nav-item"><a class="nav-link disabled" href="#"><span class="">特权介绍</span></a></li>
        <li class="nav-item baidu-nav-item"><a class="nav-link disabled" href="#"><span class="">套餐容量</span></a></li>
        <li class="nav-item baidu-nav-item"><a class="nav-link disabled" href="#"><span class="">会员卡</span></a></li>
    </ul>

    <%
        String username = null;
        String password = null;
        User user = null;
        if (request.getCookies() != null) {
            for (Cookie each : request.getCookies()) {
                if (each.getName().equals("username")) {
                    username = each.getValue();
                }
                if (each.getName().equals("password")) {
                    password = each.getValue();
                }
            }
        }

        try {
            if (username != null && password != null) {
                user = new User(username, password);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (Exception ignored) {
        }
    %>
    <!-- user -->
    <div class="row baidu-user">
        <% if (user == null) {%>
        <!-- login-button -->
        <button id="login" type="button" class="btn btn-outline-dark baidu-nav-btn-login">登录</button>
        <%} else {%>
        <div class="baidu-user-info">
            <img class="rounded-circle baidu-portrait" src="${pageContext.request.contextPath}/pandamen/22.jpg"
                 alt="portrait"/>
            <span style="color: white;font-size: 0.8rem;"><%=user.getUsername().substring(0, 5)%></span>
            <div class="baidu-user-info-extension">
                <img src="${pageContext.request.contextPath}/pandamen/22.jpg" style="width: 100%" alt=""/>
                <div class="container justify-content-center bg-white"><%=user.getUsername()%>
                </div>
                <button type="button" class="btn btn-light container justify-content-center">进入网盘</button>
                <button id="logout" type="button" class="btn btn-light container justify-content-center">退出登录</button>
            </div>
        </div>
        <%}%>
    </div>
    <!-- buy-buy-buy -->
    <button type="button" class="btn btn-outline-dark baidu-nav-btn-buy-svip">开通炒鸡会员</button>
    <a class="baidu-nav-link baidu-nav-link-extension" href="#">激活码兑换</a>
</nav>

<!-- banner -->
<div class="baidu-banner-vip">
    <div style="height: 40%;"></div>
    <div class="row justify-content-center baidu-banner-vip-slogan">会员专享特权，尊享云上生活</div>
    <div style="height: 10%;"></div>
    <div class="row justify-content-center" style="width: 100%;">
        <button type="button" class="btn btn-danger baidu-banner-vip-btn">开通会员</button>
    </div>
</div>

<div class="row justify-content-center" style="width: 100%;"><span class="sign">会员尊享10项特权</span></div>
<table class="container">
    <%
        class Show {
            public final String img;
            public final String title;
            public final String detail;

            public Show(String img, String title, String detail) {
                this.img = img;
                this.title = title;
                this.detail = detail;
            }

        }
        Show[][] shows = {{
                new Show("1.png", "2T大空间", "容量扩容至2T，存储更多"),
                new Show("2.png", "云解压", "在线解压2G内压缩包文件"),
                new Show("3.png", "自动备份手机视频", "移动端自动备份相册中的视频"),
                new Show("4.png", "回收站有效期延长", "删除到回收站中的文件可保留15天"),
                new Show("5.png", "备份本地文件夹", "安卓端自动备份手机文件夹")
        }, {
                new Show("6.png", "10G大文件上传", "客户端支持10G单文件上传"),
                new Show("7.png", "转存上限提升", "单次转存文件数提升至3000"),
                new Show("8.png", "自动备份文件夹", "PC客户端自动备份本地文件夹"),
                new Show("9.png", "隐藏空间容量无限制", "与其他空间，共享2T容量"),
                new Show("10.png", "历史版本", "PC客户端自动备份的文档历史版本提升至100")}};

        for (Show[] row : shows) {
    %>
    <tr class="justify-content-center">
        <%
            for (Show each : row) {
        %>
        <td class="baidu-vip-privilege">
            <div class="row justify-content-center"><img class="baidu-vip-privilege-img" src="resource/<%=each.img%>"
                                                         alt="<%=each.img%>"/>
            </div>
            <div class="row justify-content-center baidu-vip-privilege-title"><%=each.title%>
            </div>
            <div class="row justify-content-center baidu-vip-privilege-detail"><%=each.detail%>
            </div>
        </td>
        <%
            }
        %></tr>
    <%
        }
    %>
</table>
<div class="row justify-content-center" style="width: 100%;"><span class="sign" style="font-size: 2rem;color: red;">↑↑↑↑↑ 这些统统没有 ↑↑↑↑↑</span>
</div>


<div class="row justify-content-center" style="width: 100%;"><span class="sign">特权对比</span></div>
<div class="row justify-content-center" style="width:100%">
    <ul class="list-group baidu-privilege-compare" style="display: inline-block">
        <li class="list-group-item">功能特权</li>
        <li class="list-group-item">空间容量</li>
        <li class="list-group-item"><strong style="color: red">限速</strong>下载</li>
        <li class="list-group-item">云解压</li>
        <li class="list-group-item">转存文件数上限</li>
        <li class="list-group-item">视频高速通道</li>
        <li class="list-group-item">视频倍速播放</li>
        <li class="list-group-item">音频倍速播放</li>
        <li class="list-group-item">垃圾文件清理</li>
        <li class="list-group-item">大文件上传</li>
        <li class="list-group-item">回收站有效期</li>
        <li class="list-group-item">自动备份手机视频</li>
        <li class="list-group-item">自动备份本地文件夹</li>
        <li class="list-group-item">备份本地文件夹</li>
        <li class="list-group-item">历史版本</li>
        <li class="list-group-item">内容特权</li>
        <li class="list-group-item">隐藏空间容量</li>
        <li class="list-group-item">尊贵身份标识</li>
    </ul>
    <ul class="list-group baidu-privilege-compare-svip" style="display: inline-block;box-shadow: 0 0 5px 0;">
        <li class="list-group-item">炒鸡会员</li>
        <li class="list-group-item">5M</li>
        <li class="list-group-item" style="color: #6dd56e">40KB/S</li>
        <li class="list-group-item">1个</li>
        <li class="list-group-item" style="color: #6dd56e">似乎不行</li>
        <li class="list-group-item" style="color: #6dd56e">似乎不行</li>
        <li class="list-group-item" style="color: #6dd56e">似乎不行</li>
        <li class="list-group-item" style="color: #6dd56e">似乎不行</li>
        <li class="list-group-item" style="color: #6dd56e">似乎不行</li>
        <li class="list-group-item" style="color: #6dd56e">0天</li>
        <li class="list-group-item" style="color: #6dd56e">0天</li>
        <li class="list-group-item" style="color: #6dd56e">似乎不行</li>
        <li class="list-group-item" style="color: #6dd56e">似乎不行</li>
        <li class="list-group-item" style="color: #6dd56e">似乎不行</li>
        <li class="list-group-item" style="color: #6dd56e">似乎不行</li>
        <li class="list-group-item" style="color: #6dd56e">好像有</li>
        <li class="list-group-item" style="color: #6dd56e">0M</li>
        <li class="list-group-item" style="color: #6dd56e">熊猫人头像</li>
    </ul>
    <ul class="list-group baidu-privilege-compare" style="display: inline-block">
        <li class="list-group-item">会员</li>
        <li class="list-group-item">5M</li>
        <li class="list-group-item">100KB/S</li>
        <li class="list-group-item">1个</li>
        <li class="list-group-item">应该不行</li>
        <li class="list-group-item">应该不行</li>
        <li class="list-group-item">应该不行</li>
        <li class="list-group-item">应该不行</li>
        <li class="list-group-item">应该不行</li>
        <li class="list-group-item">0天</li>
        <li class="list-group-item">0天</li>
        <li class="list-group-item">应该不行</li>
        <li class="list-group-item">应该不行</li>
        <li class="list-group-item">应该不行</li>
        <li class="list-group-item">应该不行</li>
        <li class="list-group-item">没有</li>
        <li class="list-group-item">0M</li>
        <li class="list-group-item">熊猫人头像</li>
    </ul>
    <ul class="list-group baidu-privilege-compare" style="display: inline-block">
        <li class="list-group-item">非会员</li>
        <li class="list-group-item">5M</li>
        <li class="list-group-item text-danger">完成任务后限速</li>
        <li class="list-group-item">1个</li>
        <li class="list-group-item text-danger">肯定不行</li>
        <li class="list-group-item text-danger">肯定不行</li>
        <li class="list-group-item text-danger">肯定不行</li>
        <li class="list-group-item text-danger">肯定不行</li>
        <li class="list-group-item text-danger">肯定不行</li>
        <li class="list-group-item text-danger">莫得</li>
        <li class="list-group-item text-danger">莫得</li>
        <li class="list-group-item text-danger">肯定不行</li>
        <li class="list-group-item text-danger">肯定不行</li>
        <li class="list-group-item text-danger">肯定不行</li>
        <li class="list-group-item text-danger">肯定不行</li>
        <li class="list-group-item">没有</li>
        <li class="list-group-item">没有</li>
        <li class="list-group-item">熊猫人头像</li>
    </ul>
</div>

<div style="height: 100px"></div>
<div class="row justify-content-center" style="width: 100%;"><span class="sign">建盘宗旨</span></div>
<div class="container" style="font-size: 1.2rem;">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;欢迎使用我们的产品！<strong>%°</strong>网盘建立的初衷是为了让人们更好的感受限速，体验来自社会的毒打。为了能够使大多数人拥有体验，我们采取了层层递进，步步为营，稳扎稳打，一击毙命的方法。首先，我们提供非限速网盘，大范围的吸引用户。在用户感受到我们网盘的免费，快速，大容量等优点后，使用量必然会飞速提高。接下来，我们只需要慢慢等待。在合适的时候，我们开始对非会员进行限速。紧随其后的是我们推出的会员与炒鸡会员，我们基于对人们的普遍心理的利用，在用户进行充值后，对成为会员的用户进行更进一步的限速。因为会员用户已经进行充值，为了不浪费钱加之大量资源还在我们的网盘上用户迫不得已只能继续使用我们的产品。在保证用户的前提下，我们成功限制了速度。
    与此同时，我们在网上散播会员与炒鸡会员能够提速的谣言。结合我们网盘曾经拥有过非限速的时期，利用人们的侥幸心理，促使他们再次充值，保持老顾客，吸引新顾客。目前，我们的运营策略收效非常良好，我们将会再接再厉，继续研发更好的限速功能，争取向和我们那个同音不同名的兄弟看齐。
</div>
<%--<div style="height: 100px"></div>--%>
<%--<div class="row justify-content-center" style="width: 100%;"><span class="sign" style="color: red;font-size: 2.5rem;">记住我们的口号</span>--%>
<%--</div>--%>
<%--<div class="row justify-content-center" style="width: 100%;"><span class="sign" style="font-size: 2.5rem;"> 👊👊👊 网盘限速哪家强，群英荟萃各千秋！ 👊👊👊</span>--%>
<%--</div>--%>
<%--<div class="row justify-content-center" style="width: 100%;"><span class="sign"--%>
<%--                                                                   style="font-size: 2.5rem;"> 👊👊👊 若是<b>%°</b>居第二，试问谁人称第一！ 👊👊👊</span>--%>
<%--</div>--%>
<div style="height: 100px"></div>
<div class="row justify-content-center" style="width: 100%;">©2020 <strong>%°</strong></div>
<div style="height: 10px"></div>
</body>
</html>
