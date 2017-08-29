<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <meta charset="utf-8">
        <title>春和发管理平台</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- CSS -->
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/js/login/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/js/login/assets/css/supersized.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/js/login/assets/css/style.css">

        <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
    </head>

    <body>

        <div class="page-container">
            <h1>登录</h1>
            <form id="loginForm" action="${pageContext.request.contextPath}/login.htm" method="post">
                <input type="hidden" name="action" value="do">
                <input type="text" name="username" class="username" placeholder="用户名">
                <input type="password" name="password" class="password" placeholder="密码">
                <button type="submit" >提交</button>
                <div class="error"><span>+</span></div>
            </form>
            <div class="connect">
                <!-- <p>春和发真品食屋</p> -->
                <p>
                    <a class="facebook" href="javascript:void(0)"></a>
                    <a class="twitter" href="javascript:void(0)"></a>
                </p>
            </div>
        </div>
		
    </body>

<script src="${pageContext.request.contextPath}/js/login/assets/js/jquery-1.8.2.min.js"></script>
<script src="${pageContext.request.contextPath}/js/login/assets/js/supersized.3.2.7.min.js"></script>
<script src="${pageContext.request.contextPath}/js/login/assets/js/supersized-init.js"></script>
<script src="${pageContext.request.contextPath}/js/login/assets/js/scripts.js"></script>
<script type="text/javascript">
if(window.top !== window.self){ window.top.location = window.location;}
$(document).keydown(function (event) {
    if (event.keyCode == 13) {
        submitLogin();
    }
});

function submitLogin(){
	$('#loginForm').submit();
}
</script>

</html>


