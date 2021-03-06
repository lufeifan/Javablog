<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/12
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<!DOCTYPE html>--%>
<html lang="zh">
<head>
    <meta charset="utf-8"/>
    <title>HTML Preview (markdown to html) - Editor.md examples</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="editormd/examples/css/style.css"/>
    <link rel="stylesheet" href="editormd/css/editormd.preview.css"/>
    <link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon"/>
    <link href="http://at.alicdn.com/t/font_1446720_tvwzlm71egd.css" rel="stylesheet">
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
            width: 60%;
            margin: 0 auto;
        }

        .list-unstyled li {
            margin-left: 20px;
            display: inline-block;
        }
    </style>
</head>
<body>
<%
    String id = request.getParameter("id");
%>
<input id="message" type="hidden" value="<%= id %>"/>
<jsp:include page="heard.jsp"></jsp:include>

<div id="layout" style="margin-top: 60px">
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <h1 class="text-center title" style="font-weight: bold"></h1>
                <ol class="list-unstyled">
                    <li class="author">
                        <i class="iconfont icon-zuozhe"></i>?????????<span></span>
                    </li>
                    <li class="score">
                        <i class="iconfont icon-zuozheicon-defen"></i>???????????????<span></span>
                    </li>
                    <li class="createtime">
                        <i class="iconfont icon-fabushijian"></i>???????????? <span></span>
                    </li>
                    <li class="updatatime">
                        <i class="iconfont icon-gengxinshijian"></i>???????????? <span></span>
                    </li>
                </ol>
            </div>
        </div>
    </div>
    <div id="sidebar">
        <h1>Table of Contents</h1>
        <div class="markdown-body editormd-preview-container" id="custom-toc-container">#custom-toc-container</div>
    </div>
    <div id="test-editormd-view">
        <textarea style="display:none;" name="test-editormd-markdown-doc">###Hello world!</textarea>
    </div>
</div>
<script src="editormd/examples/js/jquery.min.js"></script>
<script src="editormd/lib/marked.min.js"></script>
<script src="editormd/lib/prettify.min.js"></script>

<script src="editormd/lib/raphael.min.js"></script>
<script src="editormd/lib/underscore.min.js"></script>
<script src="editormd/lib/sequence-diagram.min.js"></script>
<script src="editormd/lib/flowchart.min.js"></script>
<script src="editormd/lib/jquery.flowchart.min.js"></script>

<script src="editormd/editormd.js"></script>
<script type="text/javascript">
    $(function () {
        var testEditormdView;

        $.get("/article", {id: $('#message').val()}, function (markdown) {
            let json = JSON.parse(markdown);
            $(".title").text(json.title)
            $(".author span").text(json.author)
            $(".score span").text(json.score)
            let time = dateFormat("YYYY-mm-dd", new Date(json.createtime))
            $(".createtime span").text(time)

            let updatatime = dateFormat("YYYY-mm-dd", new Date(json.updatatime))
            $(".updatatime span").text(updatatime)
            testEditormdView = editormd.markdownToHTML("test-editormd-view", {
                markdown: json.doc,//+ "\r\n" + $("#append-test").text(),
                //htmlDecode      : true,       // ?????? HTML ????????????????????????????????????????????????
                htmlDecode: "style,script,iframe",  // you can filter tags decode
                //toc             : false,
                tocm: true,    // Using [TOCM]
                tocContainer: "#custom-toc-container", // ????????? ToC ?????????
                //gfm             : false,
                //tocDropdown     : true,
                // markdownSourceCode : true, // ???????????? Markdown ??????????????????????????????????????? Textarea ??????
                emoji: true,
                taskList: true,
                tex: true,  // ???????????????
                flowChart: true,  // ???????????????
                sequenceDiagram: true,  // ???????????????
            });
        });

        function dateFormat(fmt, date) {
            let ret;
            const opt = {
                "Y+": date.getFullYear().toString(),        // ???
                "m+": (date.getMonth() + 1).toString(),     // ???
                "d+": date.getDate().toString(),            // ???
                "H+": date.getHours().toString(),           // ???
                "M+": date.getMinutes().toString(),         // ???
                "S+": date.getSeconds().toString()          // ???
                // ???????????????????????????????????????????????????????????????????????????
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
    });
</script>
</body>
</html>
</html>