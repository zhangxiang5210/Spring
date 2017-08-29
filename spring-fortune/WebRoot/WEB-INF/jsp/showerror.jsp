<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
    	Exception ex = (Exception)request.getAttribute("exception");
        ex.printStackTrace();
    
    %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>春和发管理平台</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/404/css/main.css" type="text/css" media="screen, projection" /> <!-- main stylesheet -->
<link rel="stylesheet" type="text/css" media="all" href="${pageContext.request.contextPath}/js/404/css/tipsy.css" /> <!-- Tipsy implementation -->



<title>404</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>

<body style="border: 1px solid red">

<!-- <img alt="" src="" id ="img">
<img src='http://qr.liantu.com/api.php?&w=200&text=http://192.168.0.120:8080/spring-fortune/bill_order_food_share.htm?id=0' onclick="aa()">
 -->
<!-- Universal preloader -->
<div id="universal-preloader">
    <div class="preloader">
        <img src="${pageContext.request.contextPath}/js/404/images/universal-preloader.gif" alt="universal-preloader" class="universal-preloader-preloader" />
    </div>
</div>
<!-- Universal preloader -->

<div id="wrapper">
<!-- 404 graphic -->
	<div class="graphic"></div>
<!-- 404 graphic -->
<!-- Not found text -->
	<div class="not-found-text">
    	<h1 class="not-found-text">File not found, sorry!</h1>
    </div>
<!-- Not found text -->

<!-- search form -->
<!-- <div class="search">
	<form name="search" method="get" action="#" />
        <input type="text" name="search" value="Search ..." />
        <input class="with-tooltip" title="Search!" type="submit" name="submit" value="" />
    </form>
</div> -->
<!-- search form -->

<!-- top menu -->
<div class="top-menu">
	<a href="${pageContext.request.contextPath}/main.htm" class="with-tooltip" title="主页">主页</a> |
	<a href="#" class="with-tooltip" title="开发中。。。">首页</a> | 
	<a href="http://zhangxiang.pub/ekhouse-cms" class="with-tooltip" title="帐号：qqwen  密码：88888">娱乐</a>
</div>
<!-- top menu -->

<div class="dog-wrapper">
<!-- dog running -->
	<div class="dog"></div>
<!-- dog running -->
	
<!-- dog bubble talking -->
	<div class="dog-bubble">
    	
    </div>
    
    <!-- The dog bubble rotates these -->
    <div class="bubble-options">
    	<p class="dog-bubble">
        	Are you lost, bud? No worries, I'm an excellent guide!
        </p>
    	<p class="dog-bubble">
	        <br />
        	Arf! Arf!
        </p>
        <p class="dog-bubble">
        	<br />
        	Don't worry! I'm on it!
        </p>
        <p class="dog-bubble">
        	I wish I had a cookie<br /><img style="margin-top:8px" src="${pageContext.request.contextPath}/js/404/images/cookie.png" alt="cookie" />
        </p>
        <p class="dog-bubble">
        	<br />
        	Geez! This is pretty tiresome!
        </p>
        <p class="dog-bubble">
        	<br />
        	Am I getting close?
        </p>
        <p class="dog-bubble">
        	Or am I just going in circles? Nah...
        </p>
        <p class="dog-bubble">
        	<br />
            OK, I'm officially lost now...
        </p>
        <p class="dog-bubble">
        	I think I saw a <br /><img style="margin-top:8px" src="${pageContext.request.contextPath}/js/404/images/cat.png" alt="cat" />
        </p>
        <p class="dog-bubble">
        	What are we supposed to be looking for, anyway? @_@
        </p>
    </div>
    <!-- The dog bubble rotates these -->
<!-- dog bubble talking -->
</div>

<!-- planet at the bottom -->
	<div class="planet"></div>
<!-- planet at the bottom -->
</div>

<script src="${pageContext.request.contextPath}/js/hui/lib/jquery/1.9.1/jquery.min.js"></script> <!-- uiToTop implementation -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/404/scripts/custom-scripts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/404/scripts/jquery.tipsy.js"></script> <!-- Tipsy -->
<script type="text/javascript">
$(function(){
	universalPreloader();
});

$(window).load(function(){

	//remove Universal Preloader
	universalPreloaderRemove();
	
	rotate();
    dogRun();
	dogTalk();
	
	//Tipsy implementation
	$('.with-tooltip').tipsy({gravity: $.fn.tipsy.autoNS});
						   
});

function aa(){
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/qrcode.htm",
    	cache: false,
    	dataType: "json",
    	data:{},
    	success: function(result){
    		if(result.success){
    			$("#img").attr("src",result.value);
    		}else{
    			alert(result.msg);
    		}
    		
    	},
		error: function(xhr, type){
		}
    });
}
</script>
</body>
</html>
