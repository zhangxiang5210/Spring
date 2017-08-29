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


</style>	  
</head>
  
<body>
  <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 前台管理 <span class="c-gray en">&gt;</span> 预约列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
  
  <div class="page-container">
	<div class="pd-20">
		<div class="row cl">
			<label class="form-label f-l">预约时间：</label>
			<div class="formControls col-2 f-l">
				<input type="text"  placeholder="请输入预约时间"  class="laydate-icon" id="startDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss',max:$('#endDate').val()})">
			</div>
			<label class="form-label f-l" style="margin-left: 20px;">--</label>
			<div class="formControls col-2 f-l">
				<input type="text"  placeholder="请输入预约时间"  class="laydate-icon" id="endDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss',min:$('#startDate').val()})">
			</div>
			
			
			<label class="form-label f-l m-l">关键字:</label>
			<div class="formControls col-2 f-l">
				<input type="text"  id="keyWord" placeholder="姓名/电话"  class="input-text">
			</div>
			<button class="btn  m-l" onclick="addReservation()" ><i class="Hui-iconfont">&#xe600;</i>新增预约</button>
			<button class="btn bath-del m-l"  onclick="batchDel()"><i class="Hui-iconfont">&#xe6e2;</i>批量删除</button>
			<button class="btn  m-l" onclick="doSearch(false)">查询</button>
		</div>
	</div>
		
  	<div class="mt-20">
  		<table class="table table-border table-bordered table-hover table-bg table-sort" id="reservationList">
  			<thead>
  				<tr>
					<th style="width: 8px;">
						<label  class="checkbox" id="checkAll"></label>
					</th>
					<th>姓名</th>
					<th>电话</th>
					<th>预约时间(始)</th>
					<th>预约时间(终)</th>
					<th>创建时间</th>
					<th>备注</th>
					<th>有订单</th>
					<th>操作</th>
				</tr>
  			</thead>
  			<tbody>
  				
  			</tbody>
  		</table>
  	</div>
  </div>
  
  
</body>
<script src="${pageContext.request.contextPath}/js/laydate/laydate.js"></script>
<script src="${pageContext.request.contextPath}/js/checkbox.js"></script>
<script type="text/javascript">
var billTable = null;


$(function(){
	getTableList();
});

function getTableList(){
	billTable = $("#reservationList").dataTable({
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
                 url: "${pageContext.request.contextPath}/user/reservation_list_handler.htm",
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
  						  str += '<label class="checkbox"  id="reservationId'+row.id+'" value="'+row.id+'"></label>';
                		  return str;
  					}
				  },
                  { data: "name" },
                  { data: "phone" },
                  { data: "orderTimeStart",
                	  render : function(data,type,row,meta){
                		  if(data!=null && data!= ""){
                			  return getDatatTableTimeFormat(data);
                		  }else{
                			  return '';
                		  }
                		  
                	  }
                  },
                  { data: "orderTimeEnd",
                	  render : function(data,type,row,meta){
                		  if(data!=null && data!= ""){
                			  return getDatatTableTimeFormat(data);
                		  }else{
                			  return '';
                		  }
                		  
                	  }
                  },
                  { data: "createTime",
                	  render : function(data,type,row,meta){
                		  if(data!=null && data!= ""){
                			  return getDatatTableTimeFormat(data);
                		  }else{
                			  return '';
                		  }
                	  }
                  },
                  { data: "memo",
                	  render : function(data,type,row,meta){
                		  if(data != null){
                			  return '<div class="div-text-overflow" title="'+data+'">'+data+'</div>';
                		  }else{
                			  return '';
                		  }
                		 
                	  }
                  },
                  { data: "billId",
                	  render : function(data,type,row,meta){
                		  if(data!=null && data!= ""){
                			  return "是";
                		  }else{
                			  return "否";
                		  }
                	  }
                  },
                  { data: "",
                	  render : function(data,type,row,meta){
                		  var str = '';
                		  if(row.billId != null){
                			  str += '<a class="a-detail" onclick="detail('+row.billId+')">详情<a/>&nbsp;&nbsp;';
                			  str += '<a class="a-edit" onclick="edit('+row.billId+')">编辑<a/>&nbsp;&nbsp;';
                		  }
                		  str += '<a class="a-del" onclick="del('+row.id+')">删除<a/>';
                		  return str;
                	  }
                  },
              ]
		
	});
}


$('#reservationList').on('draw.dt',function() {
	pageLoading();
	removeCheckAll();
	activeCheckBox();
	
});

function doSearch(flag){
	// true:当前页面 (代价是当前页没有数据，页脚信息会出错) false:第一页
	billTable.fnDraw(flag);
}


function detail(billId){
	var index = layer.open({
		 type: 2,
		  title: '账单详情',
		  shadeClose: true,
		  area: ['800px', '460px'],
		  btn : ['关闭'],
		  content: "${pageContext.request.contextPath}/user/bill_detail.htm?id="+billId,
		  
	});
	layer.full(index);
}

function edit(bilId){
	var index = layer.open({
		 type: 2,
		  title: '账单编辑',
		  shadeClose: true,
		  area: ['800px', '460px'],
		  btn : ['提交','关闭'],
		  content: "${pageContext.request.contextPath}/user/bill_edit.htm?id="+bilId,
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			  iframeWin.submitForm();
		  },
	});
	layer.full(index);
}


function addReservation(){
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
			  
			  iframeWin.submitForm();
			  
		  },
		  success:function(){
			  top.layer.alert("如需添加订单，请到【  新增订单 】中预约");
		  }
	});
}

function del(id){
	singleCheck("reservationId"+id);
	batchDel();
}

function batchDel(){
	var idArray = [];
	$("#reservationList tbody tr td label").each(function(){
		if($(this).hasClass("on")){
			idArray.push($(this).attr("value"));
		}
	});
	if(idArray.length == 0){
		top.layer.msg("请选择要删除的数据");
		return false;
	}
	
	top.layer.confirm("删除预约信息，同时会删除账单跟订单信息，您确定要删除吗？",function(){
		delSubmit(idArray.join(","));
	},function(){
		removeCheckAll();
	});
	
}

function delSubmit(ids){
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/del_reservation.htm",
    	cache: false,
    	dataType: "json",
    	data:{ids:ids},
    	success: function(result){
    		top.layer.msg(result.msg);
    		if(result.success){
    			doSearch(false);
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
</script>


</html>
