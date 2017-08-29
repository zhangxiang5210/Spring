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

#timeButton span b {
    color: #ff0000;
    font-size: 14px;
}


</style>	  
</head>
  
<body>
  <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 厨房管理 <span class="c-gray en">&gt;</span> 订单列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
  
  <div class="page-container">
	<div class="pd-20">
		<div class="row cl">
			<label class="form-label f-l">状态:</label>
			<div class="formControls col-2 f-l">
				<select class="select select-box" id="status" onchange="doSearch(false)">
					<option value="">请选择</option>
					<option value="1">待处理</option>
					<option value="2">处理中</option>
					<option value="3">做好</option>
					<option value="4">已上</option>
					<option value="9">取消</option>
				</select>
			</div>
			<button class="btn  m-l" onclick="doSearch(false)">查询</button>
		</div>
	</div>
		
	
	
  	<div class="mt-20">
  		<table class="table table-border table-bordered table-hover table-bg table-sort" id="orderList">
  			<thead>
  				<tr>
					<th style="width: 8px;">
						<label  class="checkbox" id="checkAll"></label>
					</th>
					<th>类型</th>
					<th>名称</th>
					<th>编号</th>
					<th>单位</th>
					<th>状态</th>
					<th>订单量</th>
					<th>支付状态</th>
					<th>操作人</th>
					<th>操作</th>
				</tr>
  			</thead>
  			<tbody>
  				
  			</tbody>
  		</table>
  	</div>
  </div>
  
</body>

<script src="${pageContext.request.contextPath}/js/checkbox.js"></script>
<script type="text/javascript">
var orderTable = null;


$(function(){
	getTableList();
	
});



function getTableList(){
	orderTable = $("#orderList").dataTable({
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
			 data.status = $("#status").val();
			 data.receiveType = $("#receiveType").val();
			 data.keyWord = $("#keyWord").val();
			 data.type = $("#type").val();
			 
			 
			 
			$.ajax({
                 type: "post",
                 url: "${pageContext.request.contextPath}/user/get_order_info_simple_handler.htm",
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
				   { data: "" ,
						  render : function(data, type, row, meta) {
							  var str ='';
							  str += '<label class="checkbox"  id="menuId'+row.menuId+'" value="'+row.menuId+'"></label>';
							  return str;
						}
				   },
                  { data: "typeName" },
                  { data: "name" },
                  { data: "nameNumber" },
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
                		  if(data == "" || data == null){
                			  return "未知";
                		  }
                		  if(data == 1){
                			  return '待处理';
                		  }
                		  if(data == 2){
                			  return '处理中';
                		  }
                		  if(data == 3){
                			  return '处理完毕';
                		  }
                		  if(data == 4){
                			  return '已上';
                		  }
                		  if(data == 9){
                			  return '取消';
                		  }
                	  }
                  },
                  { data: "totalNum"},
                  { data: "payStatus",
                	  render : function(data,type,row,meta){
                		  if(data == 1){
                			  return "未付";
                		  }
                		  if(data == 2){
                			  return "已付";
                		  }
                		  
                	  }
                  },
                  
                  
                  { data: "operationPerson",
                	  render : function(data,type,row,meta){
                		  if(data == "" || data == null){
                			  return "";
                		  }else{
                			  return data;
                		  }
                	  }
                  },
                  { data: "",
                	  render : function(data,type,row,meta){
                		  var str = '';
                		  if(row.status == 1){
                			  str += '<a class="a-detail" onclick="editStatus(2,'+row.menuId+')">处理中</a>&nbsp;&nbsp;';
                    		  str += '<a class="a-edit" onclick="editStatus(3,'+row.menuId+')">处理完毕</a>&nbsp;&nbsp;';
                    		  str += '<a class="a-detail" onclick="editStatus(4,'+row.menuId+')">已上</a>';
                		  }
                		  if(row.status == 2){
                			  str += '<a class="a-edit" onclick="editStatus(3,'+row.menuId+')">处理完毕</a>&nbsp;&nbsp;';
                    		  str += '<a class="a-detail" onclick="editStatus(4,'+row.menuId+')">已上</a>';
                		  }
                		  if(row.status == 3){
                    		  str += '<a class="a-detail" onclick="editStatus(4,'+row.menuId+')">已上</a>';
                		  }
                		  return str;
                		  
                	  }
                  },
                  
              ]
		
	});
}

$('#orderList').on('draw.dt',function() {
	pageLoading();
	removeCheckAll();
	activeCheckBox();
});


function doSearch(flag){
	// true:当前页面 (代价是当前页没有数据，页脚信息会出错) false:第一页
	orderTable.fnDraw(flag);
}



function editStatus(status,menuId){
	
	singleCheck("menuId"+menuId);
	top.layer.confirm("您确定要操作选中的数据吗？",function(){
		editStatusSubmit(status,menuId);
	},function(){
		removeCheckAll();
	});
	
	
	
}

function editStatusSubmit(status,menuId){
	$.ajax({
		type: "POST",
    	url: "${pageContext.request.contextPath}/user/kitchen_edit_order_food_status.htm",
    	cache: false,
    	dataType: "json",
    	data:{menuId:menuId,status:status},
    	success : function(result){
    		top.layer.msg(result.msg);
    		if(result.success){
    			doSearch(true);
    		}
    	}
	});
}




</script>


</html>
