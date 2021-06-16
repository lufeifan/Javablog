<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/11
  Time: 21:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>博客</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <link href="https://at.alicdn.com/t/font_1446720_4jyjkk81fll.css" rel="stylesheet">
  </head>

  <body>
    <jsp:include page="heard.jsp"></jsp:include>
  <div style="margin: 80px 0px;">
<%--    <jsp:include page="content.jsp"></jsp:include>--%>
    <%@include file="content.jsp"%>
  </div>
  <div class="fixed-bottom">
    <jsp:include page="footer.jsp"></jsp:include>
  </div>
  </body>
</html>
