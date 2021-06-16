<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/13
  Time: 18:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
</head>
<body>
<jsp:include page="heard.jsp"></jsp:include>
<div class="container-fluid" style="margin-top: 80px">
    <div class="row clearfix">
        <div class="col-md-2 column">
        </div>
        <div class="col-md-8 column">
            <a href="/articalAdmin.jsp"><button type="button" class="btn btn-secondary">文章管理</button></a>
            <a href="/userAdmin.jsp"><button type="button" class="btn btn-secondary">用户管理</button></a>
        </div>
        <div class="col-md-2 column">
        </div>
    </div>
</div>

</body>
</html>
