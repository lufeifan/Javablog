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
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>
                        编号
                    </th>
                    <th>
                        文章
                    </th>
                    <th>
                        发布时间
                    </th>
                    <th>
                        文章状态
                    </th>
                </tr>
                </thead>
                <tbody class="table_body">

                </tbody>
            </table>
        </div>
        <div class="col-md-2 column">

        </div>
    </div>
</div>
</body>
<script>
    $(function () {
        let tagName = [];

        $.each($('input:checkbox'), function () {
            if (this.checked) {
                tagName.push($(this).val())
            }
        });
        console.log(tagName)
    })

    //获取文章
    $.ajax({
        url: "/articlelist",
        type: 'GET',
        success: function (data) {
            //对于获取的数据执行相关的操作，如：绑定、显示等
            const json = JSON.parse(data);
            console.log(json)
            json.forEach((elem, index) => {
                $(".table_body").append("<tr>\n" +
                    "                    <td>\n" +
                    "                        " +(index+1)+
                    "\n" +
                    "                    </td>\n" +
                    "                    <td>\n" +elem.title+
                    "                    </td>\n" +
                    "                    <td>\n" +dateFormat("YYYY-mm-dd", new Date(elem.createtime))+
                    "                    </td>\n" +
                    "                    <td class=\"test_status\">\n" +
                    "                        <fieldset class=\"form-group row\">\n" +
                    "                            <div class=\"col-sm-10\">\n" +
                    "                                <div class=\"form-check\">\n" +
                    "                                    <input class=\"form-check-input \"" +CheckedTrue(elem.status)+
                    " type=\"radio\" name=\"" +elem.id+
                    "\"  value=\"1\">\n" +
                    "                                    <label class=\"form-check-label\">\n" +
                    "                                        已发布\n" +
                    "                                    </label>\n" +
                    "                                </div>\n" +
                    "                                <div class=\"form-check\">\n" +
                    "                                    <input class=\"form-check-input\"" +CheckedFalse(elem.status)+
                    " type=\"radio\" name=\"" +elem.id+
                    "\" value=\"0\">\n" +
                    "                                    <label class=\"form-check-label\">\n" +
                    "                                        未发布\n" +
                    "                                    </label>\n" +
                    "                                </div>\n" +
                    "                            </div>\n" +
                    "                        </fieldset>\n" +
                    "                    </td>\n" +
                    "                </tr>")

                // $(".stateWTrue").attr("checked",true);
            });
            $(".table_body input").click(function () {
                // 文章的唯一属性id $(this).attr("name")
                //    得出0或者1 表示文章状态
                //     alert($(this).val())
                changStatus($(this).attr("name"),$(this).val())
            })
        }
    })

    function changStatus(id,status) {
        //articlestatus
        $.ajax({
            url: "/articlestatus",
            data: {id,status},
            type: "POST",
            success: function (data) {
                console.log(data);
            }
        })
    }

    function CheckedTrue(status) {
        if (status==1){
            return "checked"
        }
        return ""
    }
    function CheckedFalse(status) {
        if (status==0){
            console.log(status)
            return "checked"
        }
        return ""
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
</html>
