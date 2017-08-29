<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>

<html lang="en">
<head>
	<title>春和发管理平台</title>
	
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<%@ include file="/WEB-INF/jsp/include/base.jsp"%>	
	<%@include  file="/WEB-INF/jsp/include/hui.jsp" %>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/layui/css/layui.css">
	
<style type="text/css">

.row{
	width: 100%;
	display: inline-block;
}
.form-label{
	text-align: left;
	padding-top: 3px;
}
.f-l{
	float: left;
}
.pd-20{
	padding-bottom: 0px;
}
.m-l{
	margin-left: 3%;
}


.table-left{
	width: 50%;
	float: left;
}
.table-right{
	width: 50%;
	float: left;
}
#addBill tbody td span img{
	width: 20px;
	height: 20px;
	cursor: pointer;
}

#addBill tfoot {
	display: none;
}


</style>	  
</head>
  
<body>
  <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 前台管理<span class="c-gray en">&gt;</span> 新增订单<a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
  
  <div class="page-container">
	<div class="pd-20">
		<div class="row cl">
			<label class="form-label f-l" >类型:</label>
			<div class="formControls col-2 f-l">
				<select class="select select-box" id="menuType" onchange="doSearch(false)">
					<option value="">请选择</option>
					<c:forEach items="${menuTypes}" var="item">
						<option value="${item.id}" >${item.typeName}</option>
					</c:forEach>
				</select>
			</div>
			<label class="form-label f-l m-l">关键字:</label>
			<div class="formControls col-3 f-l">
				<input type="text"  id="keyWord" placeholder="请输入名称/编号/创建人"  class="input-text">
			</div>
			<label class="form-label f-l m-l">价格:</label>
			<div class="formControls col-1 f-l input-group">
				<input type="text"  id="startPrice" placeholder="价格"  class="input-text">
			</div>
			<label class="form-label f-l">--</label>
			<div class="formControls col-1 f-l">
				<input type="text"  id="endPrice" placeholder="价格"  class="input-text">
			</div>
			<button class="btn m-l" onclick="doSearch(false)">查询</button>
		</div>
	</div>
		
	
	
  	<div class="mt-20" >
  		<div class="table-left">
  			<table class="table table-border table-bordered table-hover table-bg table-sort" id="menuFoodList" style="float: left;">
	  			<thead>
	  				<tr>
						<th>名称</th>
						<th>编号</th>
						<th>价格</th>
						<th>单位</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
	  			</thead>
	  			<tbody>
	  				
	  			</tbody>
	  			
	  		</table>
  		</div>
  		<div class="table-right" >
  			<table class="table table-border table-bordered table-hover table-bg table-sort" id="addBill" style="float: left;">
	  			<thead>
	  				<tr>
						<th style="width: 21%;">名称</th>
						<th style="width: 14%;">数量</th>
						<th style="width: 15%;">价格</th>
						<th style="width: 12%;">单位</th>
						<th style="width: 16%;">总价</th>
						<th style="width: 22%;">操作</th>
					</tr>
	  			</thead>
	  			<tbody>
	  				
	  			</tbody>
				 <tfoot>
				 	<tr>
				 		<td>总计</td>
				 		<td id="tfootTotalNum"></td>
				 		<td id="tfootPirce"></td>
				 		<td id="tfootTotalPrice" colspan="2" style="text-align: center;"></td>
				 		<td style="text-align: center;">
				 			<button class="btn submit-btn" onclick="submitOrderBill()">提交</button>
				 		</td>
				 	</tr>
				 	<tr>
				 		<td colspan="6">
				 			<div id="page" style="text-align: center;"></div>
				 		</td>
				 	</tr>
				 </tfoot>
				
	  		</table>
  		</div>
  		
  		
  	</div>
  </div>

  
</body>

<script src="${pageContext.request.contextPath}/js/layui/layui.js"></script>
<script type="text/javascript">
var menuTable = null;


$(function(){
	getTableList();
});


function getTableList(){
	menuTable = $("#menuFoodList").dataTable({
		bLengthChange: false, //改变每页显示数据数量  
		bFilter: false, //过滤功能  
		bSort: false, //排序功能  
		bInfo: true,//页脚信息  
		bAutoWidth: true,//自动宽度  
		processing:true,
		bServerSide: true,//开启服务器模式 
		pageLength :10,
		bDestory: true,//如果需要重新加载的时候请加上这个
		ajax:function(data, callback, settings){
			 /* data.menuType = $("#menuType").val();
			 data.keyWord = $("#keyWord").val(); */
			$.ajax({
                 type: "post",
                 url: "${pageContext.request.contextPath}/user/menu_list_hander.htm",
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
                  { data: "status",
                	  render : function(data,type,row,meta){
                		  if(data==0){
                			  return "正常";
                		  }
                		  if(data==1){
                			  return '<label style="color:red;">缺料</label>';
                		  }
                	  }
                  },
                  { data: "" ,
                	  render : function(data, type, row, meta) {
  						  var str ='';
  						  if(row.status == 0){
  							str += '<a style="cursor:pointer;color:#0A9CE2;" onclick="addFood('+row.id+')">添加<a/>';
  						  }
  						  if(row.status == 1){
  							str += '<a style="cursor:pointer;color:#A29B9B;">添加<a/>';
  						  }
  						  
                		  return str;
  					}
                  },
              ]
		
	});
}

$('#menuFoodList').on('draw.dt',function() {
	pageLoading();
});

function doSearch(flag){
	// true:当前页面 (代价是当前页没有数据，页脚信息会出错) false:第一页
	menuTable.fnDraw(flag);
}


/**
 * 添加菜单
 */
function addFood(id){
	$.ajax({
		type: "POST",
    	url: "${pageContext.request.contextPath}/user/get_menu_food.htm",
    	cache: false,
    	dataType: "json",
    	data:{id:id},
    	success : function(result){
    		var food = result.food;
    		var havFoodFlag = false;
    		$("#addBill tbody td[menu=name]").each(function(){
    			var id = $(this).attr("id");
    			if(id == food.id){
    				havFoodFlag = true;
    				var num = parseInt($("#tdNum"+id).html());
    				num += 1;
    				$("#tdNum"+id).html(num);
    				$("#tdNum2"+id).html(num);
    				var totalPrice = food.price*num;
    				$("#tdTotalPrice"+id).html(rounded(totalPrice,2));
    			}
    		});
    		if(!havFoodFlag){
    			var str = '';
				str += '<tr>';
				str += '<td menu="name" id="'+food.id+'">'+food.name+'</td>';
				str += '<td id="tdNum'+food.id+'" num="num">1</td>';
				
				
				str += '<td>'+rounded(food.price,2)+'</td>';
				str += '<td>';
				if(food.unit == 1){
					str += '份';
				}
				if(food.unit == 2){
					str += '串';
				}
				if(food.unit == 3){
					str += '斤';
				}
				if(food.unit == 4){
					str += '两';
				}
				if(food.unit == 5){
					str += '把';
				}
				if(food.unit == 6){
					str += '个';
				}
				if(food.unit == 7){
					str += '瓶';
				}
				if(food.unit == 8){
					str += '箱';
				}
				str += '';
				str += '</td>';
				str += '<td id="tdTotalPrice'+food.id+'">'+rounded(food.price,2)+'</td>';
				if(food.unit == 3 || food.unit == 4){
					str += '<td>';
					str += '<a onclick="editAmount('+food.id+','+food.price+')">操作</a>&nbsp;&nbsp;';
					str += '<a class="a-del" onclick="del(this)">删除</a>';
					str += '</td>';
				}else{
					str += '<td>';
					str += '<span><img src="${pageContext.request.contextPath}/images/sub.png" onclick="subNum('+food.id+','+food.price+')"></span>&nbsp;&nbsp;';
					str += '<span id="tdNum2'+food.id+'" style="margin:0px 5px;">1</span>';
					str += '<span><img src="${pageContext.request.contextPath}/images/add.png" onclick="addNum('+food.id+','+food.price+')"></span>&nbsp;&nbsp;';
					str += '<a class="a-del" onclick="del(this)">删除</a>';
					str += '</td>';
				}
				
				str += '</tr>';
				$("#addBill tbody").append(str);
				
				$("#addBill tfoot").show();
				
				var length = $("#addBill tbody tr").length;
				var pageSize = 8;
				var totalPage = Math.ceil(length/pageSize);
				
				layui.use(['laypage', 'layer'], function(){
					var laypage = layui.laypage,
					layer = layui.layer;
					  laypage({
					    cont: 'page',
					    pages: totalPage ,//总页数
					   // groups: 5 ,//连续显示分页数
					    skin: '#1E9FFF',
					    jump: function(obj, first){
					        //得到了当前页，用于向服务端请求对应数据
					        var curr = obj.curr;
					       
					        var start = curr*pageSize-pageSize;
					        var end = curr*pageSize-1;
					        $("#addBill tbody tr").hide();
					        $("#addBill tbody tr").each(function(index,el){
					        	if(start<=index && index<=end){
					        		$(el).show();
					        	}
					        });
					      }
					  });
					  console.log(layer);
				});
    		}
    		getStatistics();
    	}
	});
}

/**
 * 删除
 */
function del(el){
	$(el).parent().parent().remove();
	var length = $("#addBill tbody tr").length;
	if(length == 0){
		$("#addBill tfoot").hide();
	}else{
		getStatistics();
	}
	
}

/**
 * 增加数量
 */
function addNum(id,price){
	var currentNum = parseInt($("#tdNum"+id).html());
	currentNum +=1;
	$("#tdNum"+id).html(currentNum);
	$("#tdNum2"+id).html(currentNum);
	var totalPrice = rounded(price*currentNum, 2);
	$("#tdTotalPrice"+id).html(totalPrice);
	getStatistics();
}

/**
 * 减少数量
 */
function subNum(id,price){
	var currentNum = parseInt($("#tdNum"+id).html());
	if(currentNum>1){
		currentNum -=1;
		$("#tdNum"+id).html(currentNum);
		$("#tdNum2"+id).html(currentNum);
		var totalPrice = rounded(price*currentNum, 2);
		$("#tdTotalPrice"+id).html(totalPrice);
		getStatistics();
	}
}

/**
 * tfoot统计
 */
function getStatistics(){
	var tfootTotalNum = 0;
	var tfootPirce = 0;
	var tfootTotalPrice = 0;
	$("#addBill tbody tr").each(function(){
		var num = $(this).find("td").eq(1).html();
		tfootTotalNum += parseInt(num);
		var price = $(this).find("td").eq(2).html();
		tfootPirce += parseFloat(price);
		var totalPrice = $(this).find("td").eq(4).html();
		tfootTotalPrice += parseFloat(totalPrice);
		
	});
	$("#tfootTotalNum").html(tfootTotalNum);
	$("#tfootPirce").html(rounded(tfootPirce, 2));
	$("#tfootTotalPrice").html(rounded(tfootTotalPrice, 2));
	
}

/**
 * 提交订单
 */
function submitOrderBill(){
	var str = '';
	str += '<div style="margin:20px;">';
	
	str += '<div style="width:100%;">';
	
	str += '<div style="float:left;width:20%;margin-left:5%;">';
	str += '<select class="select select-box" id="tableNumber">';
	str += '<option value="">请选择桌位</option>';
	str += '</select>';
	str += '</div>';
	
	str += '<div style="float:left;width:25%;margin-left:5%;">';
	str += '<select class="select select-box" id="peopleNum">';
	str += '<option value="">请选择用餐人数</option>';
	for (var int = 1; int < 21; int++) {
		str += '<option value="'+int+'">用餐人数 '+int+' 位</option>';
	}
	str += '</select>';
	str += '</div>';
	
	str += '<div style="float:left;width:15%;margin-left:5%;">';
	str += '<button class="btn" id="order" style="width:80px;background-color: #11a2ef;color: #fff;">预约</button>';
	str += '</div>';
	
	str += '<div style="float:left;width:15%;margin-left:5%;">';
	str += '<button class="btn" id="takeAway" style="width:80px;background-color: #11a2ef;color: #fff;">外卖</button>';
	str += '</div>';
	
	str += '</div>';
	
	str += '<div style="width:90%;float:left;margin-left:5%;margin-top:20px;">';
	str += '<label>备注:<label>';
	str += '<label style="width:50%;margin-left:15px;"><input id="memo" name="memo" class="input-text" style="width:90%;"></label>';
	str += '</div>';
	
	
	str += '</div>';
	
	
	
	top.layer.open({
		 type: 1,
		  title: '提交订单',
		  shadeClose: true,
		  area: ['620px', '350px'],
		  btn : ['提交','关闭'],
		  content: str,
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  var tableNumber = top.$("#tableNumber").val();
		  	  var msg = "您确定提交吗？";
		  	  if(tableNumber == ""){
		  		  msg = "您没有选择桌位，确定提交订单吗？";
		  	  }
		  	  var peopleNum = top.$("#peopleNum").val();
		  	  var memo = top.$("#memo").val();
		  	  top.layer.confirm(msg,function(){
		  		  submitLoad();
		  		  addShopBill(tableNumber,peopleNum,memo);
		  	  });
		  },
		  success:function(layero, index){
			  top.$("#order").click(function(){
				  var tableNum = top.$("#tableNumber").val();
				  var peopleNum = top.$("#peopleNum").val();
				  orderBill(tableNum,peopleNum);
			  });
			  top.$("#takeAway").click(function(){
				  var tableNum = top.$("#tableNumber").val();
				  var peopleNum = top.$("#peopleNum").val();
				  takeAwayBill(tableNum,peopleNum);
			  });
			  getLocationList();
		  }
	});
	
}

/**
 * 获取可用的桌位
 */
function getLocationList(){
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/get_table_list.htm",
    	cache: false,
    	dataType: "json",
    	data:{},
    	success: function(result){
    		var str = '';
    		for (var int = 0; int < result.length; int++) {
				var data = result[int];
				if(data.status == 3){
					str += '<option value="'+data.id+'" style="background-color: #adcfec;">'+data.locationNumber+'</option>';
				}else{
					str += '<option value="'+data.id+'">'+data.locationNumber+'</option>';
				}
				
			}
    		top.$("#tableNumber").append(str);
    		
    	},
		error: function(xhr, type){
		}
    });
    
}

/**
 * 店内订单
 */
function addShopBill(tableNumber,peopleNum,memo){
	  var ids = [];
	  var nums = [];
	  $("#addBill tbody td[menu=name]").each(function(){
		 var id = $(this).attr("id");
		 ids.push(id);
	  });
	  $("#addBill tbody td[num=num]").each(function(){
		 var num = $(this).html();
		 nums.push(num);
	  });
	  if(ids.length<1){
		  closeIframeLoading();
		  top.layer.alert("请选择菜单");
		  return false;
	  }
	  
	 
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/add_shop_bill.htm",
    	cache: false,
    	dataType: "json",
    	data:{tableNumber:tableNumber,peopleNum:peopleNum,ids:ids.join(","),nums:nums.join(","),memo:memo},
    	success: function(result){
    		if(result.success){
    			top.layer.closeAll();
        		top.layer.msg(result.msg);
        		
    		}else{
    			closeIframeLoading();
        		top.layer.msg(result.msg);
    		}
    		
    	},
		error: function(xhr, type){
		}
    });
}

/**
 * 预约
 */
function orderBill(tableNum,peopleNum){
	top.layer.open({
		 type: 2,
		  title: '预约信息',
		  shadeClose: true,
		  area: ['800px', '460px'],
		  btn : ['提交','关闭'],
		  content: "${pageContext.request.contextPath}/user/order_bill_info.htm",
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  submitLoad();
			  
			  var iframeWin = top.window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			  var body = top.layer.getChildFrame('body');
			  
			  var ids = [];
			  var nums = [];
			  $("#addBill tbody td[menu=name]").each(function(){
				 var id = $(this).attr("id");
				 ids.push(id);
			  });
			  $("#addBill tbody td[num=num]").each(function(){
				 var num = $(this).html();
				 nums.push(num);
			  });
			 
			  body.find("#idArray").val(ids.join(","));
			  body.find("#numArray").val(nums.join(","));
			  
			  
			  body.find("#tableNum").val(tableNum);
			  body.find("#peopleNum").val(peopleNum);
			  
			  iframeWin.submitForm();
			  
			 
		  },
		  success:function(){
			 /* var body = top.layer.getChildFrame('body');
			 var ids = [];
			 var nums = [];
			 $("#addBill tbody td[menu=name]").each(function(){
				 var id = $(this).attr("id");
				 ids.push(id);
			 });
			 $("#addBill tbody td[num=num]").each(function(){
				 var num = $(this).html();
				 nums.push(num);
			 });
			 
			 body.find("#idArray").val(ids.join(","));
			 body.find("#numArray").val(nums.join(",")); */
		  }
	});
	
}

/**
 *外卖订单
 */
function takeAwayBill(tableNum,peopleNum){
	top.layer.open({
		 type: 2,
		  title: '外卖信息',
		  shadeClose: true,
		  area: ['800px', '460px'],
		  btn : ['提交','关闭'],
		  content: "${pageContext.request.contextPath}/user/take_away_bill.htm",
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  submitLoad();
			  
			  var iframeWin = top.window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			  var body = top.layer.getChildFrame('body');
			  
			  var ids = [];
			  var nums = [];
			  $("#addBill tbody td[menu=name]").each(function(){
				 var id = $(this).attr("id");
				 ids.push(id);
			  });
			  $("#addBill tbody td[num=num]").each(function(){
				 var num = $(this).html();
				 nums.push(num);
			  });
			 
			  body.find("#idArray").val(ids.join(","));
			  body.find("#numArray").val(nums.join(","));
			  
			  
			  body.find("#tableNum").val(tableNum);
			  body.find("#peopleNum").val(peopleNum);
			  
			  
			  iframeWin.submitForm();
			  
			 
		  },
		  success:function(){
			  
		  }
	});
}

function submitLoad(){
	top.layer.load(1, {
		  shade: [0.3,'#000'] //0.1透明度的白色背景
	  });
};

function closeIframeLoading(){
	top.layer.closeAll('loading');
}

/**
 * 以斤论编辑量
 */
function editAmount(id,price){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	var amount = $("#tdNum"+id).html();
	
	top.layer.prompt({
		title: '请输入单位计价价格',
		formType: 0,
		value: amount,
	},function(value){
		if(!reg.test(value)){
			top.layer.alert("请输入合法数字");
		}else{
			$("#tdNum"+id).html(value);
			$("#tdTotalPrice"+id).html(rounded(price*value,2));
			top.layer.closeAll();
			getStatistics();
		}
	});
	
}
</script>


</html>
