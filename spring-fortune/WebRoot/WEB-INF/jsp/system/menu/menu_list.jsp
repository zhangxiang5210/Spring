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



.m-l{
	margin-left: 2%;
}
</style>	  

</head>
  
<body>
  <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 厨房管理 <span class="c-gray en">&gt;</span> 菜单列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
  
  <div class="page-container">
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
		<button class="btn bath-del" onclick="batchDel()"><i class="Hui-iconfont">&#xe6e2;</i>批量删除</button>
		<button class="btn m-l" onclick="addFood()"><i class="Hui-iconfont">&#xe600;</i>新增菜品</button>
		<!-- <span class="l"> 
			<a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>批量删除</a>
			<a href="javascript:;" onclick="addFood()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i>新增菜品</a>
		</span>  -->
	</div>
	<div class="pd-20">
		<div class="row cl" style="overflow: hidden;">
			<label class="form-label f-l">类型:</label>
			<div class="formControls col-2 f-l">
				<select class="select select-box" id="menuType" onchange="doSearch()">
					<option value="">请选择</option>
					<c:forEach items="${menuTypes}" var="item">
						<option value="${item.id}">${item.typeName}</option>
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
			<button class="btn m-l " onclick="doSearch()">查询</button>
		</div>
	</div>
		
	
	
  	<div class="mt-20">
  		<table class="table table-border table-bordered table-hover table-bg table-sort" id="menuFoodList">
  			<thead>
  				<tr>
					<!-- <th style="width: 8px;"><input type="checkbox"></th> -->
					<th style="width: 8px;">
						<label  class="checkbox" id="checkAll"></label>
					</th>
					<th>类型</th>
					<th>名称</th>
					<th>编号</th>
					<th>价格</th>
					<th>创建人</th>
					<th>创建时间</th>
					<th>修改人</th>
					<th>修改时间</th>
					<th>状态</th>
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
				  { data: "" ,
					  render : function(data, type, row, meta) {
  						  var str ='';
  						  //str += '<input type="checkbox" name="menuFoodId" id="menuFoodId'+row.id+'" value="'+row.id+'">';
  						  str += '<label class="checkbox"  id="menuFoodId'+row.id+'" value="'+row.id+'"></label>';
                		  return str;
  					}
				  },
                  { data: "typeName" },
                  { data: "name" },
                  { data: "nameNumber" },
                  { data: "price" },
                  { data: "creator",
                	  render : function(data,type,row,meta){
                		  if(data!=null){
                			  return data;
                		  }else{
                			  return "";
                		  }
                	  }
                  },
                  { data: "createTime" ,
                	  render : function(data,type,row,meta){
                		  if(data!=null && data!= ""){
                			  return getDatatTableTimeFormat(data);
                		  }else{
                			  return "";
                		  }
                	  }
                  },
                  { data: "modifer",
                	  render : function(data,type,row,meta){
                		  if(data!=null){
                			  return data;
                		  }else{
                			  return "";
                		  }
                	  }
                  },
                  { data: "editTime",
                	  render : function(data,type,row,meta){
                		  if(data!=null && data!= ""){
                			  var createTime = getDatatTableTimeFormat(row.createTime);
                			  var editTime = getDatatTableTimeFormat(row.editTime);
                			  if(createTime == editTime){
                				  return "";
                			  }else{
                				  return editTime;
                			  }
                			  return editTime;
                		  }else{
                			  return "";
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
  						  str += '<a class="a-detail" onclick="detail('+row.id+')">详情<a/>&nbsp;&nbsp;';
  						  str += '<a class="a-edit" onclick="edit('+row.id+')">编辑<a/>&nbsp;&nbsp;';
  						  str += '<a class="a-del" onclick="del('+row.id+')">删除<a/>&nbsp;&nbsp;';
  						  if(row.status == 0){
  							str += '<a style="cursor:pointer;color:#A29B9B;" onclick="updateStatus('+row.id+',1)">缺料<a/>';
  						  }
  						  if(row.status == 1){
  							str += '<a style="cursor:pointer;color:#11C9E0;" onclick="updateStatus('+row.id+',0)">恢复<a/>';
  						  }
  						  
                		  return str;
  					}
                  },
              ]
		
	});
}


$('#menuFoodList').on('draw.dt',function() {
	pageLoading();
	removeCheckAll();
	activeCheckBox();
});

function doSearch(){
	// true:当前页面 (代价是当前页没有数据，页脚信息会出错) false:第一页
	menuTable.fnDraw(false);
}

function addFood(){
	var index = layer.open({
		 type: 2,
		  title: '新增菜品',
		  shadeClose: true,
		  area: ['600px', '350px'],
		  btn : ['提交','关闭'],
		  content: "${pageContext.request.contextPath}/user/add_menu_food.htm?iframeOpen=yes",
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			  iframeWin.submitForm();
		  },
		  success:function(layero, index){
			  var body = layer.getChildFrame('body', index);
			  body.find("#submitId").remove();
		  }
	});
	layer.full(index);
}

function reload(){
	doSearch();
	layer.closeAll('iframe');
}

function del(id){
	removeCheckAll();
	singleCheck("menuFoodId"+id);
	batchDel();
}

/**
 * 批量删除
 */
function batchDel(){
	var idArray = [];
	$("#menuFoodList tbody tr td label").each(function(){
		if($(this).hasClass("on")){
			idArray.push($(this).attr("value"));
		}
	});
	if(idArray.length == 0){
		top.layer.msg("请选择要删除的数据");
		return false;
	}
	
	top.layer.confirm("删除后不可恢复，您确定要删除吗？",function(){
		delSubmit(idArray.join(","));
	},function(){
		removeCheckAll();
	});
}

function delSubmit(idArray){
	$.ajax({
		type: "POST",
    	url: "${pageContext.request.contextPath}/user/del_menu_food.htm",
    	cache: false,
    	dataType: "json",
    	data:{idArray:idArray},
    	success : function(result){
    		top.layer.msg(result.msg);
    		if(result.success){
    			doSearch();
    		}
    	}
	});
}

/**
 * 详情
 */
function detail(id){
	top.layer.open({
		 type: 2,
		  title: '菜单详情',
		  shadeClose: true,
		  area: ['500px', '450px'],
		  btn : ['关闭'],
		  content: "${pageContext.request.contextPath}/user/menu_detail.htm?id="+id,
	});
}

/**
 * 编辑
 */
function edit(id){
	var index = layer.open({
		 type: 2,
		  title: '菜单编辑',
		  shadeClose: true,
		  area: ['600px', '350px'],
		  btn : ['提交','关闭'],
		  content: "${pageContext.request.contextPath}/user/menu_edit.htm?id="+id,
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			  iframeWin.submitForm();
		  },
		  success:function(layero, index){
			 
		  }
	});
	layer.full(index);
}

/**
 * 更改状态
 */
function updateStatus(id,status){
	var msg = "";
	if(status == 1){
		msg = "设为缺料后，该菜品不可再点，您确定设为缺料吗？";
	}
	if(status == 0){
		msg = "您确定恢复该菜品吗？";
	}
	
	top.layer.confirm(msg,function(){
		$.ajax({
			type: "POST",
	    	url: "${pageContext.request.contextPath}/user/update_menu_food_status.htm",
	    	cache: false,
	    	dataType: "json",
	    	data:{id:id,status:status},
	    	success : function(result){
	    		top.layer.msg(result.msg);
	    		if(result.success){
	    			doSearch();
	    		}
	    	}
		});
	});
}

</script>


</html>
