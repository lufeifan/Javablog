<%--
  Created by IntelliJ IDEA.
  User: 17140
  Date: 2021/6/16
  Time: 12:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <link rel="stylesheet" type="text/css" href="layui/css/layui.css"/>
    <script src="layui/layui.js"></script>
    <script src="js/jquery.js"></script>
</head>
<body>
<jsp:include page="heard.jsp" flush="true"></jsp:include>
<div style="margin-top: 80px"></div>
<table  class="layui-hide" id="test" lay-filter="test3"></table>

<script type="text/html" id="switchTpl">
    <!-- 这里的 checked 的状态只是演示 -->
    <input type="checkbox" name="sex" value="{{d.id}}" lay-skin="switch" lay-text="女|男" lay-filter="sexDemo" {{ d.sex == "女" ? 'checked' : '' }}>
</script>

<script type="text/html" id="checkboxTpl">
    <!-- 这里的 checked 的状态只是演示 -->
    <input type="checkbox" name="lock" value="{{d.id}}" title="锁定" lay-filter="lockDemo" {{ d.status == 0 ? 'checked' : '' }}>
</script>

<!-- 注意：如果你直接复制所有代码到本地，上述 JS 路径需要改成你本地的 -->

<script>
    layui.use('table', function(){
        var table = layui.table
            ,util = layui.util
            ,form = layui.form;

        table.render({
            elem: '#test'
            ,url:'/UserListServlet'
            ,cellMinWidth: 80,height:600
            ,cols: [[
                {type:'numbers'}
                ,{field:'id', title:'ID', width:100, unresize: true, sort: true}
                ,{field:'username', title:'用户名', templet: '#usernameTpl'}
                ,{field:'address',edit:true, title:'城市'},{field:'phoneNum',edit:true, title:'手机号'}
                ,{field:'email',edit:true, title: '邮箱', minWidth:100, sort: true}
                ,{field:'age',edit:true, title: '年龄', minWidth:30, sort: true}
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
            layer.msg(' 更改值为：'+ util.escape(value));
            console.log(obj)
            updateUserMsg(data)
        });

        //监听性别操作
        form.on('switch(sexDemo)', function(obj){
            if (obj.elem.checked){
                changSex(this.value,'女')
            }else {
                changSex(this.value,'男')
            }

        });

        //监听锁定操作
        form.on('checkbox(lockDemo)', function(obj){
        //    用户 id  this.value
            if (obj.elem.checked){
                frozenUser(this.value,0)
            }else {
                frozenUser(this.value,1)
            }
        });
    });
    function frozenUser(id,status) {
        $.ajax({
            url: "/UserStatusServlet",
            type: 'GET',
            data: {id, status},
            success: function (data) {
                console.log(data)
            }
        });
    }
    function changSex(id,sex) {
        $.ajax({
            url: "/UserStatusServlet",
            type: 'POST',
            data: {id, sex},
            success: function (data) {
                console.log(data)
            }
        });
    }
    function updateUserMsg(data) {
        $.ajax({
            url: "/UserMsgServlet",
            type: 'POST',
            data: JSON.stringify(data),
            success: function (data) {
                console.log(data)
            }
        });
    }
</script>

</body>
</html>