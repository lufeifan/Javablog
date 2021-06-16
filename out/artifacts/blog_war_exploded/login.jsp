<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/login.css" rel="stylesheet"/>
    <script src="js/jquery.js"></script>
</head>
<body>

<div class="form-structor">
    <form class="signup">
        <h2 class="form-title" id="signup"><span>或</span>注册</h2>
        <div class="form-holder">
            <input type="text" class="input rusername" name="username" placeholder="用户名"/>
            <input type="email" class="input remail" name="email" placeholder="邮箱"/>
            <input type="password" class="input rpassword" name="password" placeholder="密码"/>
        </div>
        <button type="button" class="submit-btn submit-btn_re">注册</button>
    </form>
    <form action="/Login" method="post" class="login slide-up">
        <div class="center">
            <h2 class="form-title" id="login"><span>或</span>登录</h2>
            <div class="form-holder">
                <input type="text" value="123" class="input" name="username" placeholder="用户名"/>
                <input type="password" value="123" class="input" name="password" placeholder="密码"/>
            </div>
            <button type="submit" class="submit-btn">登录</button>
        </div>
    </form>
</div>

<script src="js/login.js"></script>
<script>
    $(".submit-btn_re").click(function () {
        var username = $(".rusername").val();
        var email = $(".remail").val();
        var password = $(".rpassword").val();
        $.ajax({
            url: "/Register",
            data: JSON.stringify({username, email, password}),
            type: "POST",
			async:true,
            success: function (data) {
                console.log(data);
                if (data) {
                    alert("注册成功");
                } else {
                    alert("注册失败")
                }
                window.location.href = "/login.jsp";
            }
        })
    })
</script>
</body>
</html>