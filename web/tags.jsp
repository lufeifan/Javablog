<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/14
  Time: 17:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>博客</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
</head>
<body style="background-color: #EEEEEE">
<jsp:include page="heard.jsp"></jsp:include>
<div style="position:relative;">
    <img src="https://tva1.sinaimg.cn/large/7a6a15d5gy1g742fwlko4j21hc08cab6.jpg" class="img-fluid" alt="...">
    <div style="position: absolute;top: 50%;left: 48%;font-size: 33px" class="text-light">文章</div>
</div>
<div class="container-fluid row no-gutters" style="padding: 0px;margin-top: 20px">
    <div class="col-2"></div>
    <div class="col-8 border text-center align-middle" style="background-color: white">
        <div>
            <ul class="cater">
                <li>标签</li>
                <li class="bg-info rounded-pill all">全部</li>
            </ul>
        </div>
        <div>
            <div class="row cat_list">
            </div>
        </div>
    </div>
    <div class="col-2"></div>
</div>

</body>
<style>
    .cater li {
        list-style: none;
        display: inline-block;
        width: 130px;
        text-align: center;
        line-height: 36px;
        padding: 0px;
        margin: 10px 10px 0 0;
        font-weight: bold;
    }
</style>
<script>
    $(function () {
        //获取标签
        $.ajax({
            url: "/TagsServlet",
            type: 'GET',
            success: function (data) {
                const json = JSON.parse(data);
                json.forEach((elem, index) => {
                    $(".cater").append('<li class="rounded-pill" value="'+elem.id+'">' + elem.tagName + '</li>')
                });
                $(".cater li").click(function () {
                    $(this).toggleClass("bg-info")
                    $(this).siblings().removeClass("bg-info")
                    $(".cater li:first-child").removeClass('bg-info')
                    if (!$(".cater li").hasClass("bg-info")) {
                        $(".cater li:nth-child(2)").addClass("bg-info")
                    }
                    if($(this).val()>0){
                        getData($(this).val())
                    }
                })
                $(".cater li:nth-child(2)").click(function () {
                    all();
                })
            }
        })
        all();
        //获取全部按钮获取全部文章
        function all(){
            $.ajax({
                url: "/articlelist",
                type: 'GET',
                success: function (data) {
                    const json = JSON.parse(data);
                    $(".cat_list div").remove()
                    json.forEach((elem, index) => {
                        let a = "<a href=\"pre-html.jsp?id="+elem.id+"\">"
                        $(".cat_list").append('<div class="col-sm-6" style="margin-top: 20px">\n' +
                            '                    <div class="card">\n' +
                            '                        <div class="card-body">\n' +
                            '                            <h5 class="card-title">'+elem.title+'</h5>\n' +
                            '                            <p class="card-text">With supporting text below as a natural lead-in to additional\n' +
                            '                                content.</p>\n' + a+ '阅读全文</a>\n' +
                            '                        </div>\n' +
                            '                    </div>\n' +
                            '                </div>')
                    });
                }
            })
        }

        function getData(id) {
            $.ajax({
                url: "/TagsServlet",
                type: 'POST',
                data:{id:id},
                success: function (data) {
                    const json = JSON.parse(data);
                    $(".cat_list div").remove()
                    json.forEach((elem, index) => {
                        let a = "<a href=\"pre-html.jsp?id="+elem.id+"\">"
                        $(".cat_list").append('<div class="col-sm-6" style="margin-top: 20px">\n' +
                            '                    <div class="card">\n' +
                            '                        <div class="card-body">\n' +
                            '                            <h5 class="card-title">'+elem.title+'</h5>\n' +
                            '                            <p class="card-text">With supporting text below as a natural lead-in to additional\n' +
                            '                                content.</p>\n' + a+ '阅读全文</a>\n' +
                            '                        </div>\n' +
                            '                    </div>\n' +
                            '                </div>')
                    });
                }
            })
        }
    })
</script>
</html>
