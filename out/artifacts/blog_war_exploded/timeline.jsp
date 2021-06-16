<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/12
  Time: 23:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <link rel="stylesheet" type="text/css" href="layui/css/layui.css"/>
    <script src="layui/layui.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
</head>

<body>
<jsp:include page="heard.jsp" flush="true"></jsp:include>

<div class="container-fluid row no-gutters">
    <div class="col-4">
    </div>
    <div class="timeline-small col-4" style="padding-top: 80px;">
        <div class="timeline-small-body">
            <ul class="layui-timeline time_li" name="12">

            </ul>
        </div>
    </div>
    <div class="col-4">

    </div>
</div>

</body>
<script>
    $(function () {
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
                };
            };
            return fmt;
        }
        $.ajax({
            url: "/articlelist",
            type: 'GET',
            success: function (data) {
                //对于获取的数据执行相关的操作，如：绑定、显示等
                const json = JSON.parse(data);
                json.forEach((elem, index) => {
                    let time = dateFormat("YYYY-mm-dd", new Date(elem.createtime))
                    // $(".time_li").append(`<li> <div class="bullet blak"></div> <div class="date">`+time+`</div> <div class="desc"> <h3>`+elem.title+`</h3> </div></li>`);
                    $(".time_li").append("<li class=\"layui-timeline-item \"" +
                        "\">\n" +
                        "                    <i class=\"layui-icon layui-timeline-axis\">&#xe63f;</i>\n" +
                        "                    <div class=\"layui-timeline-content layui-text\">\n" +
                        "                        <h3 class=\"layui-timeline-title\">" +time+
                        "</h3>\n<fieldset class=\"layui-elem-field time_l layui-field-title\" name='" +elem.id+
                        "' style=\"margin-top: 30px;\">\n" +
                        "  <legend>" +elem.title+
                        "</legend>\n" +
                        "</fieldset><div id=\"" +elem.id+
                        "\"></div>"+
                        "                    </div>\n" +
                        "                </li>")

                    layui.use('rate', function(){
                        var rate = layui.rate;

                        //渲染
                        var ins1 =rate.render({
                            elem: '#'+elem.id,
                            readonly:true
                            ,value: elem.score
                            ,half: true
                            ,theme: '#FE0000'
                        })
                    });
                });
                $(".time_l").click(function () {
                    window.location.href= "/pre-html.jsp?id="+$(this).attr("name")
                })

            }
        })
    })
</script>
</html>