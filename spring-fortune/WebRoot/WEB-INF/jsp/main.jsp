<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>

<html lang="en">
<head>
	<title>春和发管理平台</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<%@include  file="/WEB-INF/jsp/include/hui.jsp" %>


<style type="text/css">
.tree-menu ul{
	display: none;
}
.tree-menu ul li{
	padding-left: 12px;
}
</style>

	   
</head>

<body>
  <header class="navbar-wrapper">
	<div class="navbar navbar-fixed-top">
			<div class="container-fluid cl"> <a class="logo navbar-logo f-l mr-10 hidden-xs" href="">餐饮管理系统</a> <span class="logo navbar-slogan f-l mr-10 hidden-xs">1.0</span> <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
			
			<nav class="nav navbar-nav">
				<ul class="cl">
					<li class="dropDown dropDown_hover"><a href="javascript:;" class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i> 打赏<i class="Hui-iconfont">&#xe6d5;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							
							<li><a href="javascript:;"><i class="Hui-iconfont">&#xe616;</i> 联系电话：17051023028</a></li>
							<li><a href="javascript:;"><i class="Hui-iconfont">&#xe60d;</i> 微信：17051023028</a></li>
							<li><a href="javascript:;"><i class="Hui-iconfont">&#xe620;</i>  可订做各种小型网站、APP</a></li>
							
							
							
							<li>
								<img alt="" src="${pageContext.request.contextPath}/images/zhifubao.jpg" style="width: 350px;height: 477px">
							</li>
							
							
							<!-- <li><a href="javascript:;" onclick="article_add('添加资讯','article-add.html')"><i class="Hui-iconfont">&#xe616;</i> 资讯</a></li>
							<li><a href="javascript:;" onclick="picture_add('添加资讯','picture-add.html')"><i class="Hui-iconfont">&#xe613;</i> 图片</a></li>
							<li><a href="javascript:;" onclick="product_add('添加资讯','product-add.html')"><i class="Hui-iconfont">&#xe620;</i> 产品</a></li>
							<li><a href="javascript:;" onclick="member_add('添加用户','member-add.html','','510')"><i class="Hui-iconfont">&#xe60d;</i> 用户</a></li>
						 -->
						</ul>
					</li>
				</ul>
			</nav>
			<nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
				<ul class="cl">
					<li>超级管理员</li>
					<li class="dropDown dropDown_hover"> <a href="#" class="dropDown_A">admin <i class="Hui-iconfont">&#xe6d5;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="#">个人信息</a></li>
							<li><a href="#">切换账户</a></li>
							<li><a href="#">退出</a></li>
						</ul>
					</li>
					<li id="Hui-msg"> <a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li>
					<li id="Hui-skin" class="dropDown right dropDown_hover"> <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							
							<li><a href="javascript:;" data-val="default" title="绿色">绿色</a></li>
							<!-- <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li> -->
							<li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
							<li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
							<li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
							<li><a href="javascript:;" data-val="orange" title="绿色">橙色</a></li>
							<li><a href="javascript:;" data-val="black" title="黑色">黑色</a></li>
						</ul>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</header>
<aside class="Hui-aside">
	<input runat="server" id="divScrollValue" type="hidden" value="" />
	<div class="menu_dropdown bk_2">
		<dl id="menu-article">
			<dt><i class="Hui-iconfont">&#xe616;</i> 前台管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a _href="${pageContext.request.contextPath}/user/add_bill.htm" data-title="新增订单" href="javascript:void(0)">新增订单</a></li>
					<li><a _href="${pageContext.request.contextPath}/user/bill_list.htm" data-title="账单管理" href="javascript:void(0)">账单管理</a></li>
					<li><a _href="${pageContext.request.contextPath}/user/reservation_list.htm" data-title="预约管理" href="javascript:void(0)">预约管理</a></li>
					<li><a _href="" data-title="位置查询" href="javascript:void(0)">位置查询</a></li>
					
					
				</ul>
			</dd>
		</dl>
		<dl id="menu-picture">
			<dt><i class="Hui-iconfont">&#xe613;</i> 厨房管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a onclick="addMenuType()">新增类型</a></li>
					<li><a _href="${pageContext.request.contextPath}/user/add_menu_food.htm" data-title="新增菜品" href="javascript:void(0)">新增菜品</a></li>
					<li><a _href="${pageContext.request.contextPath}/user/menu_list.htm" data-title="菜单管理" href="javascript:void(0)">菜单管理</a></li>
					<li><a _href="${pageContext.request.contextPath}/user/get_order_info_simple.htm" data-title="订单管理" href="javascript:void(0)">订单管理</a></li>
				</ul>
			</dd>
		</dl>
		<dl id="menu-member">
			<dt><i class="Hui-iconfont">&#xe620;</i> 员工管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a _href="" data-title="新增加员工" href="javascript:void(0)">新增加员工</a></li>
					<li><a _href="" data-title="员工列表" href="javascript:void(0)">员工列表</a></li>
					<li><a _href="" data-title="请假列表" href="javascript:void(0)">请假列表</a></li>
					<li><a _href="" data-title="休假列表" href="javascript:void(0)">休假列表</a></li>
				</ul>
			</dd>
		</dl>
		<dl id="menu-system">
			<dt><i class="Hui-iconfont">&#xe63c;</i> 系统管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					
					<li class="tree-menu"><a><i class="Hui-iconfont">&#xe62c;</i> 角色管理</a>
						<ul>
							<li><a _href="" data-title="增加角色" href="javascript:void(0)">增加角色</a></li>
							<li><a _href="" data-title="角色列表" href="javascript:void(0)">角色列表</a></li>
						</ul>
					</li>
					<li class="tree-menu"><a>公告管理</a>
						<ul>
							<li><a _href="" data-title="发布公告" href="javascript:void(0)">发布公告</a></li>
							<li><a _href="" data-title="公告列表" href="javascript:void(0)">公告列表</a></li>
						</ul>
					</li>
					<li class="tree-menu"><a>桌位管理</a>
						<ul>
							<li><a onclick="addTable()">添加桌位</a></li>
							<li><a _href="${pageContext.request.contextPath}/user/table_list.htm" data-title="桌位列表" href="javascript:void(0)">桌位列表</a></li>
						</ul>
					</li>
				</ul>
			</dd>
		</dl>
		
	</div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active"><span title="我的桌面" data-href="welcome.html">我的桌面</span><em></em></li>
			</ul>
		</div>
		<div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
	</div>
	<div id="iframe_box" class="Hui-article">
		<div class="show_iframe">
			<div style="display:none" class="loading"></div>
			<iframe scrolling="yes" frameborder="0" src="welcome.html"></iframe>
		</div>
	</div>
</section>
</body>
<script type="text/javascript">
$(".tree-menu a").bind("click",function(){
	$(this).parent().find("ul").slideToggle(300);
});

function addTable(){
	layer.open({
		 type: 2,
		  title: '添加桌位',
		  shadeClose: true,
		  area: ['600px', '350px'],
		  btn : ['提交','关闭'],
		  content: "${pageContext.request.contextPath}/user/add_table.htm",
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			  iframeWin.submitForm();
		  }
	});
}

function addMenuType(){
	layer.open({
		 type: 2,
		  title: '添加菜单类型',
		  shadeClose: true,
		  area: ['600px', '350px'],
		  btn : ['提交','关闭'],
		  content: "${pageContext.request.contextPath}/user/add_menu_type.htm",
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			  iframeWin.submitForm();
		  }
	});
}


/**
 * 关闭所有layer弹出层
 */
function closeIframe(){
	layer.closeAll();
}
</script>


</html>
