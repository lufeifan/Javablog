<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/11
  Time: 21:10
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>博客</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <link href="https://at.alicdn.com/t/font_1446720_4jyjkk81fll.css" rel="stylesheet">

</head>
<div class="container-fluid fixed-top" style="padding: 0px">
    <div class="row no-gutters">
        <div style="height: 56px" class="col-2 bg-dark text-light">
            <h4 style="line-height: 56px;text-align: center;">博客</h4>
        </div>
        <div class="col-8 container-fluid row no-gutters">
            <div class="col-2 bg-dark"></div>
            <nav class="navbar navbar-expand-lg bg-dark navbar-dark col-10">
                <ul class="navbar-nav">
                    <li style="margin-left: 20px" class="nav-item active">
                        <a class="nav-link" href="index.jsp">首页</a>
                    </li>
                    <li class="nav-item " style="margin-left: 20px">
                        <a class="nav-link" href="category.jsp">分类</a>
                    </li>
                    <li style="margin-left: 20px" class="nav-item">
                        <a class="nav-link" href="timeline.jsp">归档</a>
                    </li>
                    <li style="margin-left: 20px" class="nav-item">
                        <a class="nav-link" href="tags.jsp">标签</a>
                    </li>
                    <li style="margin-left: 20px" class="nav-item">
                        <a class="nav-link" href="index.jsp">关于</a>
                    </li>
                </ul>
                <form style="margin-left: 60px" class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                </form>
            </nav>
        </div>
        <div style="height: 56px" class="col-2 bg-dark text-light">
<%--            TODO --%>
            <c:if test="${username== null}">
                    <button type="button" class="btn btn-dark text-light btn_login" style="margin-top: 10px">登录/注册</button>
            </c:if>
            <c:if test="${username != null}">
                <i id="userico" role="button" data-toggle="dropdown" aria-expanded="false" class="iconfont icon-GitHub" style="font-size: 24px;position: absolute;top: 10px;left: 70px"></i>
                <div class="dropdown-menu" aria-labelledby="userico">
                    <a class="dropdown-item" href="#">资料</a>
                    <a class="dropdown-item" href="article.jsp">文章编辑</a>
                    <a class="dropdown-item" href="#">收藏</a>
                    <a class="dropdown-item" href="#">评论</a>
                    <a class="dropdown-item login_out" href="/Login">退出</a>
                </div>
            </c:if>
        </div>
    </div>
</div>
<script>
    $(".btn_login").click(function () {
        window.location.href = "login.jsp";
    })
</script>
</html>

