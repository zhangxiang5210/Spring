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
	
	<%-- <%@include  file="/WEB-INF/jsp/include/adminLTE.jsp" %> --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/layui/css/layui.css">
	
	
	
<style type="text/css">
.row{
	width: 100%;
	display: inline-block;
	margin-top: 15px;
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
a:hover,.active a{color:#06c}


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
   <nav class="breadcrumb fixed"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 前台管理 <span class="c-gray en">&gt;</span> 账单编辑 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
  
  
  
<div class="page-container" style="padding-top: 30px;">
  	<form  action="" class="form-horizontal" id="form" method="post">
	          <input type="hidden" name="action" value="do">
	          <input type="hidden" id="billId" name="billId" value="${bill.id}">
	          <input type="hidden" id="addFoodId" name="ids">
	          <input type="hidden" id="addFoodIdNum" name="nums">
	          
  	<div class="pd-20" >
		<div class="row cl">
			<label class="form-label f-l">位置:</label>
			<div class="formControls col-2 f-l">
				<select class="select select-box" name="tableNumber" id="tableNumber">
                	<option value="">${bill.locationNumber}</option>
               </select>
			</div>
			<label class="form-label f-l m-l">类型:</label>
			<div class="formControls col-2 f-l">
				<select class="select select-box" name="type" id="type">
	                	<c:if test="${bill.type == 1}">
	                		<option>店内用餐</option>
	                	</c:if>
	                	<c:if test="${bill.type == 2}">
	                		<option>预约</option>
	                		<option value="1">店内用餐</option>
	                	</c:if>
	                	<c:if test="${bill.type == 3}">
	                		<option>外卖</option>
	                	</c:if>
	                </select>
			</div>
			<label class="form-label f-l m-l">人数:</label>
			<div class="formControls col-2 f-l input-group">
				<select class="select select-box" name="peopleNum" id="peopleNum">
	                	
	            </select>
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label f-l">备注:</label>
			<div class="formControls col-8 f-l input-group" style="width: 62%;">
				<textarea  name="billMemo" id="billMemo" class="textarea" placeholder="请输入收单备注">${bill.billMemo}</textarea>
			</div>
		</div>
		
	</div>
    </form>
    
    <!-- 原有订单 -->
    <div class="mt-20">
    	<div class="info-div" >&nbsp;&nbsp;订单信息 </div>
       	<div style="margin-bottom: 8px;">
       		<button class="btn"  onclick="edtiStatusConfirm(4)">已上</button>
       		<button class="btn"  onclick="edtiStatusConfirm(9)" style="margin-left: 5px;">删除</button>
       	</div>
    	<table class="table table-border table-bordered table-hover table-bg table-sort" id="sourceOrder" >
    		<thead>
    			<tr>
					<th style="max-width: 10px;">
						<label  class="checkbox" id="checkAll"></label>
					</th>
					<th style="width: 7%;">编号</th>
					<th style="width: 7%;">类型</th>
					<th style="width: 12%;">名称</th>
					<th style="width: 10%;">壮态</th>
					<th style="width: 7%;">数量</th>
					<th style="width: 9%;">价格</th>
					<th style="width: 5%;">单位</th>
					<th style="width: 9%;">总价</th>
					<th style="width: 8%;">支付状态</th>
					<th style="width: 13%;">创建时间</th>
					<th style="width: 12%;">操作</th>
				</tr>
    		</thead>
    		<tbody>
    			<c:forEach items="${foods}" var="item">
    				<tr>
    					<td><label  class="checkbox" id="foodId${item.id}" value="${item.id}"></label></td>
    					<td>${item.nameNumber}</td>
      					<td>${item.typeName}</td>
      					<td>${item.name}</td>
      					<td id="statausTd${item.id}">
      						<c:if test="${item.status == 1}">待处理</c:if>
      						<c:if test="${item.status == 2}">处理中</c:if>
      						<c:if test="${item.status == 3}">做好</c:if>
      						<c:if test="${item.status == 4}">已上</c:if>
      						<c:if test="${item.status == 9}"><a style="color:red;">已取消</a>(${item.delPerson})</c:if>
      					</td>
      					<td id="tdNum${item.id}">
      						<fmt:formatNumber pattern="#.##">${item.num}</fmt:formatNumber>
      					</td>
      					<td>
      						<fmt:formatNumber pattern="0.00">${item.price}</fmt:formatNumber>
      					</td>
      					<td>
      						<c:if test="${item.unit == 1}">份</c:if>
      						<c:if test="${item.unit == 2}">份</c:if>
      						<c:if test="${item.unit == 3}">斤</c:if>
      						<c:if test="${item.unit == 4}">两</c:if>
       						<c:if test="${item.unit == 5}">把</c:if>
       						<c:if test="${item.unit == 6}">个</c:if>
       						<c:if test="${item.unit == 7}">瓶</c:if>
       						<c:if test="${item.unit == 8}">箱</c:if>
      					</td>
      					<td id="soruceTotalPriceTd${item.id}">
      						<fmt:formatNumber pattern="0.00">${item.num*item.price}</fmt:formatNumber>
      					</td>
      					<td>
      						<c:if test="${item.payStatus == 1}">未付</c:if>
         					<c:if test="${item.payStatus == 2}">已付</c:if>
      					</td>
     						<td>
      						<fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
      					</td>
      					<td>
      						<c:if test="${item.unit == 3 || item.unit == 4}">
      							<c:if test="${item.payStatus == 1}">
      								<c:if test="${item.status != 9}">
      									<a class="a-detail"  onclick="editSourceAmount(${item.id},${item.price})">修改</a>&nbsp;&nbsp;
      								</c:if>
      							</c:if>
      						</c:if>
      						<a class="a-rec" onclick="edtiStatus(${item.id},4)">已上</a>&nbsp;&nbsp;
      						<c:if test="${item.payStatus == 1}"><a class="a-del" onclick="edtiStatus(${item.id},9)">删除</a></c:if>
      						
      					</td>
    				</tr>
    			</c:forEach>
    		</tbody>
    		<tfoot>
			 	<tr>
			 		<td colspan="12">
			 			<div id="sourceOrderPage" style="text-align: center;"></div>
			 		</td>
			 	</tr>
		   </tfoot>
    	</table>
            	
    </div>
    
    <!-- 新增订单 -->
    <div class="mt-20" >
  		<div class="info-div" >&nbsp;&nbsp;新增订单 </div>
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
<script src="${pageContext.request.contextPath}/js/checkbox.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-form/jquery.form.js"></script>
<script type="text/javascript">
$(function(){
	$("#tableNumber").mouseover(function(){
		$("#tableNumber option").eq(0).nextAll().remove();
		getLocationList();
	});
	
	var str = '';
	str += '<option value="">请选择用餐人数</option>';
	for (var int = 0; int < 20; int++) {
		str += '<option value="'+int+'">用餐人数 '+int+' 位</option>';
	}
	$("#peopleNum").append(str);
	$("#peopleNum").val(${bill.userNum});
	
	//sourceOrder分页
	sourceOrderPage();
	
	//菜单
	getTableList();
});




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
    		$("#tableNumber").append(str);
    		
    	},
		error: function(xhr, type){
		}
    });
    
}

/**
 * 原有订单分页
 */
function sourceOrderPage(){
	var length = $("#sourceOrder tbody tr").length;
	var pageSize = 8;
	var totalPage = Math.ceil(length/pageSize);
	
	layui.use(['laypage', 'layer'], function(){
		var laypage = layui.laypage,
		layer = layui.layer;
		  laypage({
		    cont: 'sourceOrderPage',
		    pages: totalPage ,//总页数
		   // groups: 5 ,//连续显示分页数
		    skin: '#1E9FFF',
		    jump: function(obj, first){
		        //得到了当前页，用于向服务端请求对应数据
		        var curr = obj.curr;
		       
		        var start = curr*pageSize-pageSize;
		        var end = curr*pageSize-1;
		        $("#sourceOrder tbody tr").hide();
		        $("#sourceOrder tbody tr").each(function(index,el){
		        	if(start<=index && index<=end){
		        		$(el).show();
		        	}
		        });
		      }
		  });
		  console.log(layer);
	});
}

/**
 * 原有订单操作
 */
function edtiStatus(id,status){
	removeCheckAll();
	singleCheck("foodId"+id);
	edtiStatusConfirm(status);
}

/**
 * 原有订单操作提交确认
 */
function edtiStatusConfirm(status){
	var length = 0;
	$("#sourceOrder tbody tr td label").each(function(){
		if($(this).hasClass("on")){
			length++;
		}
	});
	if(length == 0){
		layer.msg("请选择您要操作的数据");
		return false;
	}
	var msg = "";
	if(status == 4){
		msg = "您确定将您选中的"+length+"条数据更改为已上吗？";
	}
	if(status == 9){
		msg = "您确定将您选中的"+length+"条数据删除掉吗？";
	}
	
	top.layer.confirm(msg,function(){
		edtiStatusSubmit(status);
	},function(){
		removeCheckAll();
	});
}

/**
 * 原有订单操作提交
 */
function edtiStatusSubmit(status){
	var idArray = [];
	$("#sourceOrder tbody tr td label").each(function(){
		if($(this).hasClass("on")){
			idArray.push($(this).attr("value"));
		}
	});
	
	
	var billId = ${bill.id};
	
	
	$.ajax({
		type: "POST",
    	url: "${pageContext.request.contextPath}/user/edit_order_food_status.htm",
    	cache: false,
    	dataType: "json",
    	data:{idArray:idArray.join(","),status:status,billId:billId},
    	success : function(result){
    		top.layer.msg(result.msg);
    		if(result.success){
    			for (var int = 0; int < idArray.length; int++) {
					if(status == 4){
						$("#statausTd"+idArray[int]).html("已上");
					}
					if(status == 9){
						$("#statausTd"+idArray[int]).html('<a style="color:red;">已取消</a>');
					}
				}
    			removeCheckAll();
    		}
    	}
	});
}


/**
 * 以斤论编辑量
 */
function editSourceAmount(id,price){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	var amount = $("#tdNum"+id).text().trim();
	
	
	top.layer.prompt({
		title: '请输入单位计价价格',
		formType: 0,
		value: amount,
	},function(value){
		if(!reg.test(value)){
			top.layer.alert("请输入合法数字");
		}else{
			editSourceAmountSubmit(id,value,price);
		}
	});
	
}

/**
 * 以斤论编辑量提交
 */
function editSourceAmountSubmit(id,value,price){
	var billId = ${bill.id};
	$.ajax({
		type: "POST",
    	url: "${pageContext.request.contextPath}/user/edit_order_food_amount.htm",
    	cache: false,
    	dataType: "json",
    	data:{id:id,amount:value,billId:billId},
    	success : function(result){
    		$("#tdNum"+id).html(value);
    		$("#soruceTotalPriceTd"+id).html(rounded(price*value,2));
			top.layer.closeAll();
    		top.layer.msg(result.msg);
    		if(result.success){
    			
    			removeCheckAll();
    		}
    	}
	});
}




/*********************************************新增订单************************************************/
var menuTable = null;

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
			 data.menuType = $("#menuType").val();
			 data.keyWord = $("#keyWord").val();
			 data.startPrice = $("#startPrice").val();
			 data.endPrice = $("#endPrice").val();
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
				str += '';
				str += '</td>';
				str += '<td id="tdTotalPrice'+food.id+'">'+rounded(food.price,2)+'</td>';
				if(food.unit == 3){
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
		}
	});
	
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
 *账单编辑，新增订单提交
 */
function submitOrderBill(){
	getOrderData();
	var ids = $("#addFoodId").val();
	var nums = $("#addFoodIdNum").val();
	if(ids == "" || nums==""){
		top.layer.alert("请选择菜单");
		closeIframeLoading();
		return false;
	}
	
	var billId = ${bill.id};
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/add_new_bill.htm",
    	cache: false,
    	dataType: "json",
    	data:{ids:ids,nums:nums,billId:billId},
    	success: function(result){
    		top.layer.closeAll();
    		top.layer.msg(result.msg);
    		if(result.success){
    			window.location.reload();
    			parent.doSearch(false);
    		}
    	},
		error: function(xhr, type){
		}
    });
}

/**
 * 获取订单数据
 */
function getOrderData(){
	  submitLoad();
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
	  $("#addFoodId").val(ids.join(","));
	  $("#addFoodIdNum").val(nums.join(","));
}



function submitForm(){
	getOrderData();
	
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/add_new_form_bill.htm",
    	cache: false,
    	dataType: "json",
    	data:$('#form').serialize(),
    	success: function(result){
    		top.layer.closeAll();
    		top.layer.msg(result.msg);
    		if(result.success){
    			window.location.reload();
    			parent.doSearch(false);
    		}
    		
    	},
		error: function(xhr, type){
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
</script>


</html>
