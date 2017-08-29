<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML>
<html lang="en">
  <head>
    
    <title>春和发点菜单</title>
    
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<%@ include file="/WEB-INF/jsp/include/base.jsp"%>	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/phone.css">

<style type="text/css">
.people-num{
	width: 100%;
	text-align: center;
	margin: 20px 20px;
}
.people-num input{
	line-height: 30px;
	padding-left: 8px;
}
</style>
  </head>
  
<body>
	<!-- <header>我是头部</header> -->
	<div class="main">
		<div class="div-left">
			<c:forEach items="${types}" var="item">
				<div class="div-type" onclick="getMenuFood(${item.id},this)" value="${item.id}">${item.typeName}</div>
			</c:forEach>
			
		</div>
		<div class="div-right">
			<%-- <div class="title">凉菜</div>
			<div class="div-content">
				<div class="foo-pic-wrap">
					<img alt="" src="${pageContext.request.contextPath}/images/4.jpg">
				</div>
				<div class="food-cont-wrap">
					<div class="food-name">茴香煎饼</div>
					<div class="food-sell">月销售 109</div>
					<div class="food-price">
						<fmt:formatNumber type="currency">55</fmt:formatNumber>
						<a style="margin-right: 10px;float: right;">
							<img src="${pageContext.request.contextPath}/images/sub1.png">
							<span class="order-num" >5</span>
							<img src="${pageContext.request.contextPath}/images/add1.png">
						</a>
					 </div>
				</div>
			</div> --%>
			
		
			
			
			
			
		</div>
	</div>
	
	
	<div class="footer">
		<div class="car-wrap">
			<%-- <img alt="" src="${pageContext.request.contextPath}/images/shopping.png"> --%>
			<i class="icon-car" onclick="showOrder()">&nbsp;</i>
			<span class="icon-num" >55</span>
			<span class="totalPirce">购物车是空的</span>
		</div>
		<div class="div-order" onclick="submitOrderBill()">去下单</div>
	</div>
	
	<div id="shoppingCar" class="shopping-car">
		<div class="remove-all" onclick="removeShopping()">清空购物车&nbsp;&nbsp;</div>
		
	</div><input type="number" placeholder="请输入用餐人数">
	
</body>
<script src="${pageContext.request.contextPath}/js/hui/lib/jquery/1.9.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/util.js"></script>
<script src="${pageContext.request.contextPath}/js/layer_mobile/layer.js"></script>

<script type="text/javascript">
//picShoppingData购物车
//picMenuFoodData菜单
//picFooter底部
//picBillInfo上次的订单


$(function(e){
	
	//localStorage.clear();
	
	//查看原来是否有订单
	var picBillInfo = localStorage.getItem("picBillInfo");
	if(picBillInfo != null){
		layer.open({
			 // anim: 'up',
	 		  content: '您已有订单，是否要查看订单',
	 		  btn: ['查看订单', '取消'],
	 		  yes:function(){
	 			 window.location.href = "${pageContext.request.contextPath}/phone/bill_detail.htm?billInfo="+picBillInfo;
	 		  },
	 		  no:function(){
	 			 
	 		  }
	 		});
	}
	
	//考虑到要获取月销量，以及已选的菜单，数据保存最近3小时的
	var lastTimeOperation = localStorage.getItem("lastTimeOperation");
	var date = new Date();
	if((date.getTime()-lastTimeOperation)/(1000*60*60*3)>3){
		//清除所有的数据
		localStorage.clear();
	}else{
		//购物车数据
		var picShoppingData = localStorage.getItem("picShoppingData");
		if(picShoppingData != null){
			$("#shoppingCar").html(picShoppingData);
		}
		//菜单数据    
		var picMenuFoodData = localStorage.getItem("picMenuFoodData");
		if(picMenuFoodData != null){
			$(".div-right").html(picMenuFoodData);
		}
		//底部
		var picFooter = localStorage.getItem("picFooter");
		if(picFooter != null){
			$(".footer").html(picFooter);
		}
		
	}
	
	
 	
	
	/* var date = new Date();
	localStorage.setItem("date", date.getTime()); */
	
	/* var dateTime = localStorage.getItem("date");
	var date = new Date();
	alert((date.getTime()-dateTime)/1000); */
	
	
	
	
	
	
	
	//底部高度
	var footerHight = $(".footer").height();
	//浏览器显示窗口高度
	var innerHeight = window.innerHeight;
	var mainHeight = innerHeight-footerHight+"px";
	$(".main").css("height",mainHeight);
	
	$(".div-right .div-content").eq(0).css("margin-top","30px");
	
	//默认加载第一个
	var id = $(".div-left .div-type").eq(0).attr("value");
	var shoppingBottom = footerHight+"px";
	$("#shoppingCar").css("bottom",shoppingBottom);
	getMenuFood(id);
	
	
});



/**
 * 获取类型下的菜单
 */
function getMenuFood(menuTypeId,el){
	$(".div-left .div-type").removeClass("active");
	if(el == null){
		$(".div-left .div-type").eq(0).addClass("active");
	}else{
		$(el).addClass("active");
	}
	
	
	var html = $("#showFood"+menuTypeId).html();
	if(html != null){
		$(".div-right div[data-wrap=food]").hide();
		$(".div-right #showFood"+menuTypeId).show();
		return false;
	}
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/phone/menu_food_list.htm",
    	cache: false,
    	dataType: "json",
    	data:{menuTypeId:menuTypeId},
    	success: function(result){
    		$(".div-right div[data-wrap=food]").hide();
    		for (var int = 0; int < result.length; int++) {
				var data = result[int];
				var str = '';
	    		str += '<div data-wrap="food" id="showFood'+data.menuTypeId+'">';
	    		if(int == 0){
	    			str += '<div class="title">'+data.menuTypeName+'</div>';
	    			str += '<div class="div-content" style="margin-top:30px;">';
	    		}else{
	    			str += '<div class="div-content">';
	    		}
	    		
	    		
	    		str += '<div class="foo-pic-wrap">';
	    		if(data.filePath !=null && data.filePath !=""){
	    			str += '<img alt="" src="${annexBasepath }/'+data.filePath+'">';
	    		}else{
	    			str += '<img alt="" src="${pageContext.request.contextPath}/images/no_food_pic.jpg">';
	    		}
	    		
	    		str += '</div>';
	    		str += '<div class="food-cont-wrap">';
	    		str += '<div class="food-name" id="foodName'+data.id+'">'+data.name+'</div>';
	    		str += '<div class="food-sell">月销售 109</div>';
	    		str += '<div class="food-price">';
	    		str += '￥'+rounded(data.price, 2)+'';
	    		str += '<a style="margin-right: 0px;float: right;">';
	    		str += '<img src="${pageContext.request.contextPath}/images/sub1.png" id="subNum'+data.id+'" class="sub-img" style="display: none;" onclick="subNum('+data.id+','+data.price+')">';
	    		str += '<span class="order-num" id="orderNum'+data.id+'">0</span>';
	    		str += '<img src="${pageContext.request.contextPath}/images/add1.png" onclick="addNum('+data.id+','+data.price+')">';
	    		str += '</a>';
	    		str += '</div>';
	    		str += '</div>';
	    		str += '</div>';
	    		str += '';
	    		if(int == result.length-1){
	    			str += '<div class="no-more">没有更多了</div>';
	    		}
	    		str += '</div>';
	    		$(".div-right").append(str);
	    		
			}
    		
    		
    		keepMenuFood();
    		
    	},
		error: function(xhr, type){
		}
    });
	
	
}



/**
 * 减少数量
 */
function subNum(id,price){
	var currentNum = parseInt($("#orderNum"+id).html());
	if(currentNum>0){
		currentNum -=1;
		$("#orderNum"+id).html(currentNum);
		if(currentNum == 0){
			$("#subNum"+id).hide();
			$("#orderNum"+id).hide();
		}
		
		getStatistics(id,price);
	}
}

/**
 * 增加数量
 */
function addNum(id,price){
	var currentNum = parseInt($("#orderNum"+id).html());
	currentNum +=1;
	$("#orderNum"+id).html(currentNum);
	$("#subNum"+id).show();
	$("#orderNum"+id).show();
	getStatistics(id,price);
}


/**
 * 购物车统计
 */
function getStatistics(id,price){
	var currentNum = $("#orderNum"+id).html();
	currentNum = parseInt(currentNum);
	price = parseFloat(price);
	
	var isEmpty = $("#shoppingDiv"+id).html();
	if(isEmpty == null){
		var foodName = $("#foodName"+id).html();
		var str = '';
		str += '<div class="shopping-info" id="shoppingDiv'+id+'" value="'+id+'">';
		str += '<div class="food-name">'+foodName+'</div>';
		str += '<div class="food-price" value="'+price+'">￥'+rounded(price, 2)+'</div>';
		str += '<div class="operator-num">';
		str += '<a style="margin-right: 10px;float: right;">';
		str += '<img src="${pageContext.request.contextPath}/images/sub1.png"  onclick="subNum('+id+','+price+')">';
		str += '<span class="spopping-num"  id="shoppingNum'+id+'">'+currentNum+'</span>';
		str += '<img src="${pageContext.request.contextPath}/images/add1.png" onclick="addNum('+id+','+price+')">';
		str += '</a>';
		str += '</div>';
		str += '</div>';
		str += '</div>';
		$("#shoppingCar").append(str);
	}else{
		if(currentNum == 0){
			$("#shoppingDiv"+id).remove();
		}else{
			$("#shoppingNum"+id).html(currentNum);
		}
	}
	
	var totalNum = 0;
	var numArray = [];
	var priceArray = [];
	$("#shoppingCar .spopping-num").each(function(){
		var num = parseInt($(this).html());
		numArray.push(num);
		totalNum += num;
	});
	$("#shoppingCar .food-price").each(function(){
		priceArray.push($(this).attr("value"));
	});
	
	
	
	if(totalNum != 0){
		$(".footer .icon-num").html(totalNum);
		$(".footer .icon-num").show();
		$(".footer .icon-car").addClass("on");
	}else{
		$(".footer .icon-num").html(totalNum);
		$(".footer .icon-num").hide();
		$(".footer .icon-car").removeClass("on");
	}
	
	var totalPrice = 0;
	for (var int = 0; int < numArray.length; int++) {
		var num = parseInt(numArray[int]);
		var price = parseFloat(priceArray[int]);
		totalPrice += num*price;
	}
	totalPrice = rounded(totalPrice, 2);
	if(totalPrice == 0){
		$(".footer .totalPirce").html("购物车是空的");
	}else{
		$(".footer .totalPirce").html("共￥"+totalPrice);
	}
	
	
	//购物车数据
	var picShoppingData = $("#shoppingCar").html();
	localStorage.setItem("picShoppingData", picShoppingData);
	
	//底部
	var picFooter = $(".footer").html();
	localStorage.setItem("picFooter", picFooter);
	
	keepMenuFood();
}



/**
 * 显示购物车
 */
function showOrder(){
	if($("#shoppingCar").is(":hidden")){
		var length = $("#shoppingCar .shopping-info").length;
		if(length == 0){
			return false;
		}
		$("#shoppingCar").show();
	}else{
		$("#shoppingCar").hide();
	}
}


/**
 * 清空购物车
 
 */
function removeShopping(){
	
	
	layer.open({
		  content: '您确定要删除购物车吗？',
		  btn: ['确定', '取消'],
		  yes:function(index){
			    $(".div-right .order-num").html(0);
				$(".div-right .order-num").hide();
				$(".div-right .sub-img").hide();
				$("#shoppingCar .shopping-info").remove();
				showOrder();
				$(".footer .totalPirce").html("购物车是空的");
				$(".footer .icon-num").hide();
				$(".footer .icon-car").removeClass("on");
				localStorage.removeItem("picShoppingData");
				layer.close(index);
		  },
		  no:function(){
			
		  }
		});
		
}


/**
 * 清空购物车(没有提醒)  提交保留相应的数据
 
 */
function removeShoppingNoConfirm(){
	$(".div-right .order-num").html(0);
	$(".div-right .order-num").hide();
	$(".div-right .sub-img").hide();
	$("#shoppingCar .shopping-info").remove();
	showOrder();
	$(".footer .totalPirce").html("购物车是空的");
	$(".footer .icon-num").hide();
	$(".footer .icon-car").removeClass("on");
	//清除购物车数据
	localStorage.removeItem("picShoppingData");
	
	//清除底部数据
	localStorage.removeItem("picFooter");
	
	//保存菜单数据   最后一次操作
	keepMenuFood();
}

/**
 * 保存菜单数据   最后一次操作
 */
function keepMenuFood(){
	var picMenuFoodData = $(".div-right").html();
	localStorage.setItem("picMenuFoodData", picMenuFoodData);
	localStorage.setItem("lastTimeOperation", new Date().getTime());
}


/**
 * 订单提交
 */
function submitOrderBill(){
 	var tableId = "${tableId}";
 	if(tableId == ""){
 		 layer.open({
 		    content: '请扫一下桌子上的二维码，或者联系服务员',
 		    btn: '我知道了',
 		    type:0,
 		  });
 		 return false;
 	}
	var length = $("#shoppingCar .shopping-info").length;
 	if(length == 0){
 		return false;
 	}
 	
 	layer.open({
 		  /* title: [
 		    '提交订单',
 		    'background-color:#31abe8; color:#fff;'
 		  ], */
 		  anim: 'up',
 		  content: '提交后您不能再删除您的订单，但您可继续下订单，您确定提交吗？',
 		  btn: ['确认', '取消'],
 		  yes:function(){
 			 
 			//查看原来是否有订单
			var picBillInfo = localStorage.getItem("picBillInfo");
 			
 			if(picBillInfo != null){
 				addNewBillSubmit();
 			}else{
 				getPeopleNum();
 			}
 			
 		  }
 		});
 	
	
 }

/**
 * 获取用餐数
 */
function getPeopleNum(){
	var str = '';
	str += '<div class="people-num">';
	str += '<input type="number" placeholder="请您输入用餐人数" id="people-num">';
	str += '</div>';
	 layer.open({
	    type: 1,
	    content: str,
	    anim: 'up',
	    btn: ['提交', '取消'],
	    style: 'position:fixed; bottom:0; left:0; width: 100%; height: 200px; padding:10px 0; border:none;',
	    yes:function(){
	    	var peopleNum = $("#people-num").val();
	    	ajaxSubmit(peopleNum);
	    }
	  });
}

function ajaxSubmit(peopleNum){
	
	var index = layer.open({
	     type: 2,
	     shadeClose:false,
	});
	
	var tableId = "${tableId}";
	var id = [];
 	var num = [];
 	$("#shoppingCar .shopping-info").each(function(){
 		id.push($(this).attr("value"));
 	});
 	
 	$("#shoppingCar .spopping-num").each(function(){
 		num.push($(this).text());
 	});
 	
 	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/phone/add_bill.htm",
    	cache: false,
    	dataType: "json",
    	data:{id:id.join(","),num:num.join(","),tableId:tableId,peopleNum:peopleNum},
    	success: function(result){
    	  
    	   layer.close(index);
    	  //信息框
    	  layer.open({
  		    content: result.msg,
  		    btn: '我知道了',
  		    yes:function(){
  		    	if(result.success){
  		    		//清空购物车
  		    		removeShoppingNoConfirm();
  		    		
  		    		var picBillInfo = result.value;
  		    		localStorage.setItem("picBillInfo", picBillInfo);
  		    		layer.closeAll();
  		    		window.location.href = "${pageContext.request.contextPath}/phone/bill_detail.htm?billInfo="+picBillInfo;
  		    	}else{
  		    		layer.closeAll();
  		    	}
  		    	
  		    }
  		  });
    		
    	},
		error: function(xhr, type){
		}
    });
}

/**
 * 再次下单
 */
function addNewBillSubmit(){
	var index = layer.open({
	     type: 2,
	     shadeClose:false,
	});
	
	var tableId = "${tableId}";
	var id = [];
	var num = [];
 	$("#shoppingCar .shopping-info").each(function(){
 		id.push($(this).attr("value"));
 	});
 	
 	$("#shoppingCar .spopping-num").each(function(){
 		num.push($(this).text());
 	});
 	var picBillInfo = localStorage.getItem("picBillInfo");
 	
 	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/phone/add_new_bill.htm",
    	cache: false,
    	dataType: "json",
    	data:{id:id.join(","),num:num.join(","),tableId:tableId,billInfo:picBillInfo},
    	success: function(result){
    	  layer.close(index);
    	  //信息框
    	  layer.open({
  		    content: result.msg,
  		    btn: '我知道了',
  		    yes:function(){
  		    	if(result.success){
  		    		//清空购物车
  		    		removeShoppingNoConfirm();
  		    		layer.closeAll();
  		    		window.location.href = "${pageContext.request.contextPath}/phone/bill_detail.htm?billInfo="+picBillInfo;
  		    	}else{
  		    		layer.closeAll();
  		    	}
  		    	
  		    }
  		  });
    		
    	},
		error: function(xhr, type){
		}
    });
}

/* function stopDrop() {
    var lastY;//最后一次y坐标点
    $(document.body).on('touchstart', function(event) {
        lastY = event.originalEvent.changedTouches[0].clientY;//点击屏幕时记录最后一次Y度坐标。
    });
    $(document.body).on('touchmove', function(event) {
        var y = event.originalEvent.changedTouches[0].clientY;
        var st = $(this).scrollTop(); //滚动条高度  
        if (y >= lastY && st <= 10) {//如果滚动条高度小于0，可以理解为到顶了，且是下拉情况下，阻止touchmove事件。
            lastY = y;
            event.preventDefault();
        }
        lastY = y;
 
    });
}
 */


    
</script>



</html>
