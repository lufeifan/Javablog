<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/12
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文章编辑</title>
    <link rel="stylesheet" href="editormd/css/editormd.css"/>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
</head>
<body>
<jsp:include page="heard.jsp"></jsp:include>
<div class="tip"></div>
<form style="margin-top: 80px;">
    <div class="input-group mb-3" style="width: 70%;margin: 0 auto">
        <div class="input-group-prepend">
            <span class="input-group-text">文章标题</span>
        </div>
        <input type="text" class="form-control title" aria-label="Sizing example input"
               aria-describedby="inputGroup-sizing-default">
    </div>
    <%--选择框--%>
    <div class="input-group mb-3" style="width: 70%;margin: 0 auto">
        <div class="input-group-prepend">
            <span class="input-group-text">文章分类</span>
        </div>
        <select id="selectId" class="custom-select category">
        </select>
    </div>
<%--标签--%>
    <div class="input-group mb-3" style="width: 70%;margin: 0 auto">
        <fieldset class="form-group row">
            <div class="col-sm-10 tags">
            </div>
        </fieldset>
    </div>

    <div id="test-editor">
        <textarea class="testForm" style="display:none;"></textarea>
    </div>
    <div style="width:90%;margin: 10px auto;">
        <input class="submit" type="button" name="submit" value="发表文章" style="padding: 5px;"/>
    </div>
</form>
<script src="https://cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="editormd/editormd.min.js"></script>
<script type="text/javascript">
    $(function () {
        //    获取文章分类
        $.ajax({
            url: "/CategoryServlet",
            type: 'GET',
            success: function (data) {
                //对于获取的数据执行相关的操作，如：绑定、显示等
                const json = JSON.parse(data);
                json.forEach((elem, index) => {
                    if (index == 0) {
                        $(".category").append('<option selected value="' + elem.id + '">' + elem.categoryName + '</option>');
                    } else {
                        $(".category").append('<option value="' + elem.id + '">' + elem.categoryName + '</option>');
                    }
                });

            }
        })
        //获取标签
        $.ajax({
            url: "/TagsServlet",
            type: 'GET',
            success: function (data) {
                //对于获取的数据执行相关的操作，如：绑定、显示等
                const json = JSON.parse(data);
                json.forEach((elem, index) => {
                    console.log(elem)
                    if (index == 0) {
                        $(".tags").append('<div class="form-check form-check-inline"> <input class="form-check-input" type="checkbox" checked name="gridRadios" value="'+elem.id+'"> <label class="form-check-label">'+elem.tagName+'</label> </div>');
                    } else {
                        $(".tags").append('<div class="form-check form-check-inline"> <input class="form-check-input" type="checkbox" name="gridRadios" value="'+elem.id+'"> <label class="form-check-label">'+elem.tagName+'</label> </div>');
                    }
                });

            }
        })

        var editor = editormd("test-editor", {
            // width  : "100%",
            // height : "100%",
            path: "editormd/lib/",
            saveHTMLToTextarea: true
        });
        $(".submit").click(function () {

            let tagName = [];

            $.each($('input:checkbox'),function(){
                if(this.checked){
                    tagName.push($(this).val())
                }
            });
            console.log(tagName)
            $.ajax({
                url: "/article",
                type: 'POST',
                data: JSON.stringify(
                    {
                        doc: $(".editormd-markdown-textarea").val(),
                        content: $(".editormd-html-textarea").val(),
                        title: $(".title").val(),
                        categoryName: $("#selectId").find("option:selected").val(),
                        tagName,
                    }),
                dataType: "json",
                success: function (data) {
                    console.log(data)
                    if (data){
    $(".tip").append("<div class=\"alert alert-success fixed-top alert-dismissible\">\n" +
                            "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button>\n" +
                            "  <strong>文章保存成功!等待管理员的审核吧！</strong>\n" +
                            "</div>")
                    }
                }
            })
        });

    });
</script>
</body>
</html>
