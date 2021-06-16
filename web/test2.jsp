<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/16
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="layui/css/layui.css"/>
    <script src="layui/layui.js"></script>
    <script src="js/jquery.js"></script>
</head>
<body>
<table class="layui-table" id="#test"  lay-filter="test3">

</table>
</body>
<script>
    layui.use(['table', 'util'], function(){
        var table = layui.table
            ,util = layui.util;

        table.render({
            elem: '#test'
            ,url:'/UserListServlet'
            ,cellMinWidth: 80,height:600
            ,cols: [[
                {type:'numbers'}
                ,{field:'id', title:'ID', width:100, unresize: true, sort: true}
                ,{field:'username', title:'用户名', templet: '#usernameTpl'}
                ,{field:'address',edit:true, title:'城市'},{field:'phoneNum', title:'手机号'}
                ,{field:'email', title: '邮箱', minWidth:120, sort: true}
                ,{field:'sex', title:'性别', width:85, templet: '#switchTpl', unresize: true}
                ,{field:'status', title:'是否锁定', width:110, templet: '#checkboxTpl', unresize: true}
            ]]
            ,page: true
        });

        //监听单元格编辑
        table.on('edit(test3)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段
            layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改值为：'+ util.escape(value));
        });
    });
</script>
</html>
