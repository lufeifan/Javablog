<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/12
  Time: 18:20
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
    <link href="http://at.alicdn.com/t/font_1446720_tvwzlm71egd.css" rel="stylesheet">
</head>
<body>

<div class="container-fluid row no-gutters" style="padding: 0px">
    <div class="col-1"></div>
    <div class="col-10 container-fluid row">
        <div class="col-9">
            <%--            轮播图--%>
            <div id="demo" class="carousel slide" data-ride="carousel">

                <!-- 指示符 -->
                <ul class="carousel-indicators">
                    <li data-target="#demo" data-slide-to="0" class="active"></li>
                    <li data-target="#demo" data-slide-to="1"></li>
                    <li data-target="#demo" data-slide-to="2"></li>
                </ul>

                <!-- 轮播图片 -->
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="https://static.runoob.com/images/mix/img_fjords_wide.jpg">
                    </div>
                    <div class="carousel-item">
                        <img src="https://static.runoob.com/images/mix/img_nature_wide.jpg">
                    </div>
                    <div class="carousel-item">
                        <img src="https://static.runoob.com/images/mix/img_mountains_wide.jpg">
                    </div>
                </div>

                <!-- 左右切换按钮 -->
                <a class="carousel-control-prev" href="#demo" data-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </a>
                <a class="carousel-control-next" href="#demo" data-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </a>

            </div>

            <%--    大银幕--%>
            <%--TODO--%>
            <div class="cotence_middle">

            </div>
        </div>
        <div class="col-3">

            <div class="card" style="width: 18rem;" style="margin-top: 50px">
                <img style="width: 150px;height: 150px;margin: 0 auto;border-radius: 50%"
                     src="https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3101694723,748884042&fm=26&gp=0.jpg"
                     class="card-img-top" alt="...">
                <div class="card-body text-center">
                    <h5 class="card-title">用户名</h5>
                    <p class="card-text">个性签名</p>

                    <button type="button" class="btn btn-dark">
                        日志
                        <span class="badge badge-light">9</span>
                    </button>
                    <button type="button" class="btn btn-success" style="margin-left: 20px">
                        分类
                        <span class="badge badge-light">59</span>
                    </button>
                    <button type="button" class="btn btn-warning " style="margin-top: 10px">
                        标签
                        <span class="badge badge-light">9</span>
                    </button>
                </div>
            </div>

            <ul class="list-group col" style="margin-top: 50px">
                <li class="list-group-item active bg-dark text-center">热门文章</li>
                <li class="list-group-item">A second item</li>
                <li class="list-group-item">A third item</li>
                <li class="list-group-item">A fourth item</li>
                <li class="list-group-item">And a fifth one</li>
            </ul>

            <ul class="list-group col" style="margin-top: 50px">
                <li class="list-group-item active bg-dark text-center">文章推荐</li>
                <li class="list-group-item">A second item</li>
                <li class="list-group-item">A third item</li>
                <li class="list-group-item">A fourth item</li>
                <li class="list-group-item">And a fifth one</li>
            </ul>

            <ul class="list-group col" style="margin-top: 50px">
                <li class="list-group-item active bg-dark text-center">标签</li>
                <div class="list-group-item tagsli">
                </div>
            </ul>


            <ul class="list-group col" style="margin-top: 50px">
                <li class="list-group-item active bg-dark text-center">技术博客</li>
                <li class="list-group-item">
                    <a class="btn-link text-dark" href="#" style="width: 50%">前端博客</a>
                </li>
                <li class="list-group-item">
                    <a class="btn-link text-dark" href="#" style="width: 50%">前端技术</a>
                </li>
                <li class="list-group-item">
                    <a class="btn-link text-dark" href="#" style="width: 50%">web前端开发</a>
                </li>
            </ul>

            <ul class="list-group col" style="margin-top: 50px">
                <li class="list-group-item active bg-dark text-center">站点消息</li>
                <li class="list-group-item">
                    站点运行时间：<span id="show_time"></span>
                </li>
                <li class="list-group-item count">
                    访问量：
                </li>
                <a href="pre-html.jsp?id=46"></a>
            </ul>

        </div>
    </div>
    <div class="col-1"></div>
</div>

<script>
    <%--    生成标签  --%>
    $.ajax({
        url: "/TagsServlet",
        type: "GET",
        success: function (data) {
            const json = JSON.parse(data);
            json.forEach((elem, index) => {
                $(".tagsli").append(`<span value=` + elem.id + ` class="badge badge-primary"style="min-width: 50px;padding: 5px;margin: 10px 10px 0 0">` + elem.tagName + `</span>`)
            });
            $(".tagsli span").each(function () {
                $(this).css("background-color", Color());
            });
            $(".tagsli span").click(function () {
                // 标签id  $(this).attr("value")
                // console.log("/taglist.jsp?id="+$(this).attr("value")+"&&tag="+$(this).text())
                window.location.href = "/taglist.jsp?id=" + $(this).attr("value") + "&&tag=" + $(this).text()
            });
        }
    })
    $.ajax({
        url: "/CountServlet",
        type: "GET",
        success: function (data) {
            $(".count").text("访问量：" + data)
            console.log(data)
        }
    })
    //获取文章
    $.ajax({
        url: "/articlelist",
        type: 'GET',
        success: function (data) {
            //对于获取的数据执行相关的操作，如：绑定、显示等
            const json = JSON.parse(data);
            json.forEach((elem, index) => {
                let a = "<a href=\"pre-html.jsp?id=" + elem.id + "\">"
                if (index > 4) {
                    return
                }
                console.log(a);
                // $(".cotence_middle").append('<div class="jumbotron" style="margin-top: 35px">' + a + '<h1 class="display-4">' + elem.title + '</h1><p class="lead">' + elem.id + '</p> </a></div>');
                $(".cotence_middle").append("<div class=\"jumbotron\" style=\"margin-top: 30px\">\n" + a +
                    "                        <h1 class=\"text-center title\" style=\"font-weight: bold;color: #0a001f\">elem.title</h1></a>\n" +
                    "                    <ol class=\"list-unstyled\">\n" +
                    "                        <li class=\"author\">\n" +
                    "                            <i class=\"iconfont icon-zuozhe\"></i>作者：<span>" +elem.author+
                    "</span>\n" +
                    "                        </li>\n" +
                    "                        <li class=\"score\">\n" +
                    "                            <i class=\"iconfont icon-zuozheicon-defen\"></i>文章得分：<span>" +elem.score+
                    "</span>\n" +
                    "                        </li>\n" +
                    "                        <li class=\"createtime\">\n" +
                    "                            <i class=\"iconfont icon-fabushijian\"></i>发布时间 <span>" +dateFormat("YYYY-mm-dd", new Date(elem.createtime))+
                    "</span>\n" +
                    "                        </li>\n" +
                    "                        <li class=\"updatatime\">\n" +
                    "                            <i class=\"iconfont icon-gengxinshijian\"></i>更新时间 <span>" +dateFormat("YYYY-mm-dd", new Date(elem.updatatime))+
                    "</span>\n" +
                    "                        </li>\n" +
                    "                    </ol>\n" +
                    "                    <div style=\"width: 100%\">"+ a+
                    "                        <button style=\"margin-left: 350px;margin-top: 30px\">阅读全文</button>\n" +
                    "                    </a></div>\n" +
                    "                </div>")
            });

        }
    })

    function Color() {
        var r = Math.floor(Math.random() * 255);
        var g = Math.floor(Math.random() * 255);
        var b = Math.floor(Math.random() * 255);
        var color = 'rgba(' + r + ',' + g + ',' + b + ',0.8)';
        return color;
    }

    function dateFormat(fmt, date) {
        let ret;
        const opt = {
            "Y+": date.getFullYear().toString(),        // 年
            "m+": (date.getMonth() + 1).toString(),     // 月
            "d+": date.getDate().toString(),            // 日
            "H+": date.getHours().toString(),           // 时
            "M+": date.getMinutes().toString(),         // 分
            "S+": date.getSeconds().toString()          // 秒
            // 有其他格式化字符需求可以继续添加，必须转化成字符串
        };
        for (let k in opt) {
            ret = new RegExp("(" + k + ")").exec(fmt);
            if (ret) {
                fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
            }
            ;
        }
        ;
        return fmt;
    }


</script>
<script type="text/javascript" language="javascript">
    function secondToDate(second) {
        if (!second) {
            return 0;
        }
        var time = new Array(0, 0, 0, 0, 0);
        if (second >= 365 * 24 * 3600) {//计算年
            time[0] = parseInt(second / (365 * 24 * 3600));
            second %= 365 * 24 * 3600;
        }
        if (second >= 24 * 3600) {//计算天
            time[1] = parseInt(second / (24 * 3600));
            second %= 24 * 3600;
        }
        if (second >= 3600) {//计算时
            time[2] = parseInt(second / 3600);
            second %= 3600;
        }
        if (second >= 60) {//计算分
            time[3] = parseInt(second / 60);
            second %= 60;
        }
        if (second > 0) {//计算秒
            time[4] = second;
        }
        return time;
    }

    function setTime() {
        var create_time = Math.round(new Date(Date.UTC(2021, 5, 12, 0, 0, 0)).getTime() / 1000);//设置起始时间为2017年1月1日0点整，注意月份取值是0-11。
        var timestamp = Math.round((new Date().getTime() + 8 * 60 * 60 * 1000) / 1000);
        currentTime = secondToDate((timestamp - create_time));
        currentTimeHtml = currentTime[0] + '年' + currentTime[1] + '天' + currentTime[2] + '时' + currentTime[3] + '分' + currentTime[4] + '秒';
        document.getElementById("show_time").innerHTML = currentTimeHtml;
    }

    setInterval(setTime, 1000);
</script>
</body>
<style>
    /*包含以下四种的链接*/
    .cotence_middle a {
        text-decoration: none;
    }

    /*正常的未被访问过的链接*/
    .cotence_middle a:link {
        text-decoration: none;
    }

    /*已经访问过的链接*/
    .cotence_middle a:visited {
        text-decoration: none;
    }

    /*鼠标划过(停留)的链接*/
    .cotence_middle a:hover {
        text-decoration: none;
    }

    /* 正在点击的链接*/
    .cotence_middle a:active {
        text-decoration: none;
    }
</style>
<style>
    body {
        padding: 40px;
    }

    #layout > header, .btns {
        width: auto;
    }

    #sidebar {
        width: 300px;
        height: 100%;
        position: fixed;
        top: 0;
        right: 0;
        overflow: hidden;
        background: #fff;
        z-index: 100;
        padding: 18px;
        border: 1px solid #ddd;
        border-top: none;
        border-bottom: none;
    }

    #sidebar:hover {
        overflow: auto;
    }

    #sidebar h1 {
        font-size: 16px;
    }

    #custom-toc-container {
        padding-left: 0;
    }

    #test-editormd-view, #test-editormd-view2 {
        padding-left: 0;
        padding-right: 430px;
        margin: 0;
    }

    .list-unstyled {
        width: 85%;
        margin: 20px auto;
    }

    .list-unstyled li {
        margin-left: 20px;
        display: inline-block;
    }
</style>
</html>
