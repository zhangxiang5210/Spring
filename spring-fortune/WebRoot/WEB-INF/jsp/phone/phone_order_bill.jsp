<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>

<html lang="en">
<head>
	<title>春和发点菜单</title>
	
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<%@ include file="/WEB-INF/jsp/include/base.jsp"%>	
	<%-- <%@include  file="/WEB-INF/jsp/include/hui.jsp" %> --%>
	
	
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/hui/static/h-ui/css/H-ui.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/hui/static/h-ui.admin/css/H-ui.admin.css">
	
	
<style type="text/css">


#shopping span img{
	width: 20px;
	height: 20px;
	cursor: pointer;
}

.info-div{
	margin-bottom: -15px;
	color: black;
	background-color: #e2dfdf;
	width: 100%;
	line-height: 30px;
	font-family: cursive;
}


.f-l{
	float: left;
}
.form-label{
	text-align: left;
	padding-top: 3px;
}

</style>	  
</head>
  
<body>
  
  <div class="page-container">
	<div style="padding-top: -5px;padding-bottom: 20px;">
		<label class="form-label f-l" >类型:</label>
		<div class="formControls col-2 f-l">
			<select class="select select-box" id="menuType" onchange="doSearch(false)" style="width: 100px;">
				<option value="">请选择</option>
				<c:forEach items="${menuTypes}" var="item">
					<option value="${item.id}" >${item.typeName}</option>
				</c:forEach>
			</select>
		</div>
		
		
		<div class="formControls col-2 f-l" style="width: 180px;margin-left: 50px">
				<input type="text"  id="keyWord" placeholder="请输入名称/编号"  class="input-text" style="height: 28px;" onkeyup="doSearch(false)">
		</div>
		
		<%-- <div class="formControls col-2 f-l" style="padding-left: 50%;">
			<img src="${pageContext.request.contextPath}/images/serach.png" style="width: 40px;height: 40px;margin-top: -8px;"/>
		</div> --%>
	</div>
		
	
	
  	<div class="mt-20">
  		<table class="table table-border table-bordered table-hover table-bg table-sort" id="menuFoodList" >
  			<thead>
  				<tr>
  					<th>ID</th>
  					<th>状态</th>
  					<th>名称</th>
  					<th>编号</th>
					<th>价格</th>
					<th>单位</th>
  				</tr>
  			</thead>
  			<tbody>
  				
  			</tbody>
  		</table>
  		
  	</div>
  	
  	<table class="info-div">
  		<tr><td>&nbsp;&nbsp;订单信息</td></tr>
  	</table>
  	<div class="mt-20"  id="shopping" >
  		<table class="table table-border table-bordered table-hover table-bg table-sort"  >
  			<thead>
  				<tr>
  					<th>名称</th>
					<th>单价</th>
					<th>单位</th>
					<th>操作</th>
  				</tr>
  			</thead>
  			<tbody>
  			</tbody>
  			<tfoot style="display: none;">
				 	
				 	<tr >
				 		<td>总计</td>
				 		<td id="tfootTotalPirce" colspan="2"></td>
				 		<td style="text-align: center;">
				 			<button class="btn submit-btn" onclick="submitOrderBill()">提交</button>
				 		</td>
				 	</tr>
				 	<tr>
				 		<td colspan="4">
				 			<div id="page" style="text-align: center;"></div>
				 		</td>
				 	</tr>
				 </tfoot>
  		</table>
  	</div>
  	
  </div>
<input type="hidden" id="peopleNum">
<input type="hidden" id="memo">
</body>
<script src="${pageContext.request.contextPath}/js/hui/lib/jquery/1.9.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/hui/static/h-ui/js/H-ui.js"></script>
<script src="${pageContext.request.contextPath}/js/hui/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hui/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>

<script src="${pageContext.request.contextPath}/js/laypage/laypage.js"></script>
<script src="${pageContext.request.contextPath}/js/layer_mobile/layer.js"></script>
<script src="${pageContext.request.contextPath}/js/util.js"></script>

<script type="text/javascript">
//shopping 订单信息
//billInfo 账单信息



var menuTable = null;
$(function(){
	
	
	layer.open({
		 // anim: 'up',
		  content: '是否要切换到有图模式',
		  btn: ['切换', '取消'],
		  yes:function(){
			 window.location.href = "${pageContext.request.contextPath}/phone/phone_order_bill_pic.htm?tableId=${tableId}";
		  },
		  no:function(){
			 
		  }
		});
	
	getTableList();
	
	var shoppingBill = localStorage.getItem("shoppingBill");
	if(shoppingBill != null){
		$("#shopping").html(shoppingBill);
	}
	
	//针对UC浏览器   display:none 不行
	$("#menuFoodList thead tr th").eq(0).hide();
	$("#menuFoodList thead tr th").eq(1).hide();
	
	
	//查看原来是否有订单
	var billInfo = localStorage.getItem("billInfo");
	if(billInfo != null){
		layer.open({
	 		  title: [
	 		    '欢迎再次光临',
	 		    'background-color:#31abe8; color:#fff;'
	 		  ],
	 		  anim: 'up',
	 		  content: '检测到您已有订单，如果是您上次的订单，您可删除后再下单，如果是本次订单，点击空白处即可加餐',
	 		  btn: ['查看订单', '删除'],
	 		  yes:function(){
	 			 window.location.href = "${pageContext.request.contextPath}/phone/bill_detail.htm?billInfo="+billInfo;
	 		  },
	 		  no:function(){
	 			 localStorage.removeItem("billInfo");
	 		  }
	 		});
	}
});

function getTableList(){
	menuTable = $("#menuFoodList").dataTable({
		/* columnDefs: [
		                { "hide": false, "targets": 0 ,}
		   ], */
		/* initComplete: function () {
			var api = this.api();
			api.$('tr').click( function () {
				addBill(this);
			} );
		}, */
		 
		
		bLengthChange: false, //改变每页显示数据数量  
		bFilter: false, //过滤功能  
		bSort: false, //排序功能  
		bInfo: false,//页脚信息  
		bAutoWidth: true,//自动宽度  
		processing:true,
		bServerSide: true,//开启服务器模式 
		pageLength :10,
		bDestory: true,//如果需要重新加载的时候请加上这个
		ajax:function(data, callback, settings){
			 data.menuType = $("#menuType").val();
			 data.keyWord = $("#keyWord").val();
			$.ajax({
                 type: "post",
                 url: "${pageContext.request.contextPath}/phone/menu_list_hander.htm",
                 cache : false,  //禁用缓存
                 data: data, 
                 dataType: "json",
                 success: function(result) {
                	 //封装返回数据
                     var returnData = {};
                     returnData.draw = result.draw;
                     returnData.recordsTotal = result.recordsTotal;
                     returnData.recordsFiltered = result.recordsFiltered;
                     returnData.data = result.data;
                     //调用DataTables提供的callback方法，代表数据已封装完成并传回DataTables进行渲染
                     //此时的数据需确保正确无误，异常判断应在执行此回调前自行处理完毕
                     callback(returnData);
                 },
                 error: function(XMLHttpRequest, textStatus, errorThrown) {
                   //TODO
                 },
                 
             });
		},
		
		columns: [
		          { data: "id"},
		          { data: "status"},
                  { data: "name" },
                  { data: "nameNumber" },
                  { data: "price" },
                  { data: "unit" ,
                	  render : function(data,type,row,meta){
                		  if(data==1){
                			  return "份";
                		  }
                		  if(data==2){
                			  return "串";
                		  }
                		  if(data==3){
                			  return "斤";
                		  }
                		  if(data==4){
                			  return "两";
                		  }
                		  if(data==5){
                			  return "把";
                		  }
                		  if(data==6){
                			  return "个";
                		  }
                		  if(data==7){
                			  return "瓶";
                		  }
                		  if(data==8){
                			  return "箱";
                		  }
                	  }
                  },
              ]
		
	});
}

$('#menuFoodList').on('draw.dt',function() {
	//pageLoading();
	
	$("#menuFoodList tbody tr").each(function(){
		$(this).find("td").eq(0).hide();
		$(this).find("td").eq(1).hide();
	});
	$("#menuFoodList tbody tr").click(function(){
		addBill(this);
	});
	
});

function doSearch(flag){
	// true:当前页面 (代价是当前页没有数据，页脚信息会出错) false:第一页
	menuTable.fnDraw(flag);
}


function addBill(el){
	//状态0:正常1：缺料
	var id = $(el).find("td").eq(0).text();
	var status = $(el).find("td").eq(1).text();
	
	if(status == 1){
		 layer.open({
		    content: '对不起，您点的菜已售完',
		    btn: '我知道了',
		  });
		return false;
	}
	
	var hasBill = false;
	var totalNum = 0;
	$("#shopping tbody tr").each(function(){
		var goalId = $(this).attr("value");
		
		if(id == goalId){
			hasBill = true;
			var num = $("#shoppingId"+id).attr("num");
			
			num = parseInt(num)+1;
			
			totalNum += num;
			$("#shoppingId"+id).attr("num",num);
			$("#shoppingNum"+id).text(num);
		}else{
			var num = $("#shoppingId"+goalId).attr("num");
			totalNum += parseInt(num);
		}
	});
	
	if(!hasBill){
		var name = $(el).find("td").eq(2).text();
		var price = $(el).find("td").eq(4).text();
		var unit = $(el).find("td").eq(5).text();
		
		var str = '';
		str += '<tr id="shoppingId'+id+'" value="'+id+'" num="1" price="'+price+'">';
		str += '<td>'+name+'</td>';
		str += '<td>'+price+'</td>';
		str += '<td>'+unit+'</td>';
		str += '<td>';
		str += '<span><img src="${pageContext.request.contextPath}/images/sub.png" onclick="subNum('+id+')" /></span>';
		str += '<span id="shoppingNum'+id+'" style="margin:0px 5px;">1</span>';
		str += '<span><img src="${pageContext.request.contextPath}/images/add.png" onclick="addNum('+id+')" /></span>  ';
		str += '<span style="padding-left:5px;"><img src="${pageContext.request.contextPath}/images/del.png" onclick="del('+id+')" /></span>';
		str += '</tr>';
		$("#shopping tbody").append(str);
		totalNum += 1;
	}
	
	//普通提
	  layer.open({
	    content: '已加入购物车（'+totalNum+'）',
	    skin: 'msg',
	    shade:false,
	    time:1,
	  });
	
	 shoppingListPage();
	 
	
}



/**
 * 增加数量
 */
function addNum(id){
	var currentNum = parseInt($("#shoppingNum"+id).html());
	currentNum +=1;
	$("#shoppingId"+id).attr("num",currentNum);
	$("#shoppingNum"+id).html(currentNum);
	getAllBillPrice();
}

/**
 * 减少数量
 */
function subNum(id){
	var currentNum = parseInt($("#shoppingNum"+id).html());
	currentNum -=1;
	if(currentNum>0){
		$("#shoppingId"+id).attr("num",currentNum);
		$("#shoppingNum"+id).html(currentNum);
	}
	getAllBillPrice();
}

/**
 * 删除
 */
function del(id){
	//询问框
	  layer.open({
	    content: '您确定要删除吗？',
	    btn: ['确定', '取消'],
	    skin: 'footer',
	    yes: function(index){
	      $("#shoppingId"+id).remove();
	      shoppingListPage();  
	      layer.closeAll();
	    }
	  });
}


function shoppingListPage(){
	var length = $("#shopping tbody tr").length;
	var pageSize = 8;
	var totalPage = Math.ceil(length/pageSize);
	
	 laypage({
		    cont: 'page',
		    pages: totalPage ,//总页数
		    groups: 4 ,//连续显示分页数
		    first:false,
		    last:false,
		    skin: '#1E9FFF',
		    jump: function(obj, first){
		        //得到了当前页，用于向服务端请求对应数据
		        var curr = obj.curr;
		       
		        var start = curr*pageSize-pageSize;
		        var end = curr*pageSize-1;
		        $("#shopping tbody tr").hide();
		        $("#shopping tbody tr").each(function(index,el){
		        	if(start<=index && index<=end){
		        		$(el).show();
		        	}
		        });
		      }
	    });
	 getAllBillPrice();
};

/**
 * 订单总价
 */
function getAllBillPrice(){
	var length = $("#shopping tbody tr").length;
	if(length == 0){
		$("#shopping tfoot").hide();
	}else{
		$("#shopping tfoot").show();
	}
	
	var totalPrice = 0;
	$("#shopping tbody tr").each(function(){
		var price = parseFloat($(this).attr("price"));
		var num = parseInt($(this).attr("num"));
		totalPrice += price*num;
	});
	$("#tfootTotalPirce").html(rounded(totalPrice, 2)+"元");
	
	//存储数据
	localStorage.removeItem("shopping");
	var shoppingBill = $("#shopping").html();
	localStorage.setItem("shoppingBill", shoppingBill);
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
	
 	
 	layer.open({
 		  title: [
 		    '提交订单',
 		    'background-color:#31abe8; color:#fff;'
 		  ],
 		  anim: 'up',
 		  content: '提交后您不能再删除您的订单，但您可继续下订单，您确定提交吗？',
 		  btn: ['确认', '取消'],
 		  yes:function(){
 			
 			//查看原来是否有订单
			var billInfo = localStorage.getItem("billInfo");
 			if(billInfo != null){
 				addNewBillSubmit();
 			}else{
 				ajaxSubmit();
 			}
 			
 		  }
 		});
 	
	
 }
 
function ajaxSubmit(){
	var index = layer.open({
	     type: 2,
	     shadeClose:false,
	  });
	
	var tableId = "${tableId}";
	var id = [];
 	var num = [];
 	$("#shopping tbody tr").each(function(){
 		id.push($(this).attr("value"));
 		num.push($(this).attr("num"));
 	});
 	
 	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/phone/add_bill.htm",
    	cache: false,
    	dataType: "json",
    	data:{id:id.join(","),num:num.join(","),tableId:tableId},
    	success: function(result){
    	 layer.close(index);
    	  //信息框
    	  layer.open({
  		    content: result.msg,
  		    btn: '我知道了',
  		    yes:function(){
  		    	if(result.success){
  		    		//清除已点过的订单
  		    		localStorage.removeItem("shoppingBill");
  		    		var billInfo = result.value;
  		    		localStorage.removeItem("billInfo");
  		    		localStorage.setItem("billInfo", billInfo);
  		    		window.location.href = "${pageContext.request.contextPath}/phone/bill_detail.htm?billInfo="+billInfo;
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

function addNewBillSubmit(){
	var index = layer.open({
	     type: 2,
	     shadeClose:false,
	  });
	
	var tableId = "${tableId}";
	var id = [];
 	var num = [];
 	$("#shopping tbody tr").each(function(){
 		id.push($(this).attr("value"));
 		num.push($(this).attr("num"));
 	});
 	var billInfo = localStorage.getItem("billInfo");
 	
 	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/phone/add_new_bill.htm",
    	cache: false,
    	dataType: "json",
    	data:{id:id.join(","),num:num.join(","),tableId:tableId,billInfo:billInfo},
    	success: function(result){
    	  layer.close(index);
    	  //信息框
    	  layer.open({
  		    content: result.msg,
  		    btn: '我知道了',
  		    yes:function(){
  		    	if(result.success){
  		    		//清除已点过的订单
  		    		localStorage.removeItem("shoppingBill");
  		    		window.location.href = "${pageContext.request.contextPath}/phone/bill_detail.htm?billInfo="+billInfo;
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
</script>


</html>
