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
.m-l{
	margin-left: 2%;
}
</style>	
	  
</head>
  
<body>
  <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 桌位管理 <span class="c-gray en">&gt;</span> 桌位列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
 
  <div class="page-container">
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
		<button class="btn bath-del"  onclick="batchDel()"><i class="Hui-iconfont">&#xe6e2;</i>批量删除</button>
		<button class="btn m-l" onclick="addTable()"><i class="Hui-iconfont">&#xe600;</i>添加桌位</button>
		<button class="btn m-l" onclick="editStatusConfirmt(1)">可用</button>
		<button class="btn m-l" onclick="editStatusConfirmt(2)">用餐中</button>
		<button class="btn m-l" onclick="editStatusConfirmt(3)">预约</button>
		<!-- <span class="l"> 
			<a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>批量删除</a>
			<a href="javascript:;" onclick="addTable()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i>添加桌位</a>
		</span>  -->
	</div>
  	<div class="mt-20">
  		<table class="table table-border table-bordered table-hover table-bg table-sort" id="tableList">
  			<thead>
  				<tr>
					<th style="width: 8px;">
						<label  class="checkbox" id="checkAll"></label>
					</th>
					<th>位置编号</th>
					<th>状态</th>
					<th>备注</th>
					<th style="width: 20%;">操作</th>
				</tr>
  			</thead>
  			<tbody>
  				
  			</tbody>
  		</table>
  	</div>
  </div>
  
</body>
<script src="${pageContext.request.contextPath}/js/checkbox.js"></script>
<script src="${pageContext.request.contextPath}/js/share.js"></script>
<script type="text/javascript">
var table = null;
$(function(){
	getTableList();
	
	
});

function getTableList(){
	table = $("#tableList").dataTable({
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
			 $.ajax({
                 type: "post",
                 url: "${pageContext.request.contextPath}/user/table_list_hander.htm",
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
  						  //str += '<input type="checkbox" name="tableId" id="tableId'+row.id+'" value="'+row.id+'">';
  						  str += '<label  class="checkbox" id="tableId'+row.id+'" value="'+row.id+'"></label>';
                		  return str;
  					}
				  },
                  { data: "locationNumber" },
                  { data: "status",
                	  render : function(data,type,row,meta){
                		  if(data == 1){
                			  return "可用";
                		  }
                		  if(data == 2){
                			  return "用餐中";
                		  }
                		  if(data == 3){
                			  return "预定";
                		  }
                	  }
                  },
                  { data: "memo" },
                  { data: "" ,
                	  render : function(data, type, row, meta) {
  						  var str ='';
  						  str += '<a class="a-del" onclick="del('+row.id+')">删除<a/>&nbsp;&nbsp;&nbsp;';
  						  str += '<a class="a-edit" onclick="editStatus('+row.id+',1)">可用<a/>&nbsp;&nbsp;&nbsp;';
  						  str += '<a class="a-detail" onclick="editStatus('+row.id+',2)">用餐中<a/>&nbsp;&nbsp;&nbsp;';
  						  str += '<a class="a-edit" onclick="editStatus('+row.id+',3)">预约<a/>&nbsp;&nbsp;&nbsp;';
  						  
  						str += '<a class="a-edit" onclick="qrcode('+row.id+')">二维码<a/>';
                		  return str;
  					}
                  },
              ]
		
	});
}

$('#tableList').on('draw.dt',function() {
	pageLoading();
	removeCheckAll();
	activeCheckBox();
});

/**
 * 增加桌位
 */
function addTable(){
	parent.addTable();
}


function doSearch(){
	// true:当前页面 (代价是当前页没有数据，页脚信息会出错) false:第一页
	table.fnDraw(false);
}


function del(id){
	singleCheck("tableId"+id);
	batchDel();
}
/**
 * 批量删除
 */
function batchDel(){
	var idArray = [];
	$("#tableList tbody tr td label").each(function(){
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
    	url: "${pageContext.request.contextPath}/user/del_table.htm",
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
 * 更改状态
 */
function editStatus(id,status){
	removeCheckAll();
	singleCheck("tableId"+id);
	editStatusConfirmt(status);
}

function editStatusConfirmt(status){
	var length = 0;
	$("#tableList tbody tr td label").each(function(){
		if($(this).hasClass("on")){
			length++;
		}
	});
	if(length == 0){
		layer.msg("请选择您要操作的数据");
		return false;
	}
	
	var msg = "";
	if(status == 1){
		msg = "您确定将您选中的"+length+"条数据更改为可用吗？";
	}
	if(status == 2){
		msg = "您确定将您选中的"+length+"条数据改为用餐中吗？";
	}
	if(status == 3){
		msg = "您确定将您选中的"+length+"条数据改为预约吗？";
	}
	
	top.layer.confirm(msg,function(){
		editStatusSubmit(status);
	},function(){
		removeCheckAll();
	});
	
}

function editStatusSubmit(status){
	var idArray = [];
	$("#tableList tbody tr td label").each(function(){
		if($(this).hasClass("on")){
			idArray.push($(this).attr("value"));
		}
	});
	
	$.ajax({
		type: "POST",
    	url: "${pageContext.request.contextPath}/user/edit_table_status.htm",
    	cache: false,
    	dataType: "json",
    	data:{idArray:idArray.join(","),status:status},
    	success : function(result){
    		top.layer.msg(result.msg);
    		if(result.success){
    			doSearch();
    			removeCheckAll();
    		}
    	}
	});
}

/**
 * 查看二维码
 */
function qrcode(id){
	//singleCheck("tableId"+id);
	//拿回去的长宽转化后不能实现扫码，先放着
	
	/* var str = '';
	str += '<div style="margin:30px;">';
	
	str += '<div style="width:90%;margin-left:7%;margin-top:20px;">';
	str += '<label>宽度:<label>';
	str += '<label style="width:50%;margin-left:15px;"><input id="width" name="width" value="200" class="input-text" style="width:70%;"></label>';
	str += '</div>';
	
	str += '<div style="width:90%;margin-left:7%;margin-top:20px;">';
	str += '<label>高度:<label>';
	str += '<label style="width:50%;margin-left:15px;"><input id="height" name="height" value="200" class="input-text" style="width:70%;"></label>';
	str += '</div>';
	
	str += '</div>';
	
	top.layer.open({
		 type: 1,
		  title: '二维码',
		  shadeClose: true,
		  area: ['450px', '250px'],
		  btn : ['提交','关闭'],
		  content: str,
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  getQrcode(id);
		  },
		  success:function(){
			    
		  },
		  cancel:function(){
			  removeCheckAll();
		  }
		  
	}); */
	
	getQrcode(id);
}

function getQrcode(id){
	var width = top.$("#width").val();
	var height = top.$("#height").val();
	var content = tableQrcode+"?id=" +id;
	
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/qrcode.htm",
    	cache: false,
    	dataType: "json",
    	data:{width:width,height:height,content:content},
    	async:true,//false同步执行 true异步 默认true
    	success: function(result){
    		if(result.success){
    			top.layer.closeAll();
    			showQrcode(result.value);
    			
    		}else{
    			top.layer.msg(result.msg);
    		}
    	},
		error: function(xhr, type){
		}
    });
}

function showQrcode(value){
	
	var img = new Image();
	img.src =value ;
	/* var w = parseInt(img.width);
	var h = parseInt(img.height); */
	var w = 235;
	var h = 235;
	
	
	var divW = w+20+"px";
	var divH = h+20+"px";
	
	var left = (200-20)/2+"px";
	
	var str = '';
	
	str += '<div style="width:'+divW+';height:'+divH+';border: 1px solid #0fccea;left:'+left+';top:15%;position: absolute;" >';
	str += '<img id="img" src="'+value+'" style="padding:10px;">';
	str += '</div>';
	
	
	var openIframeW = w+200+"px";
	var openIframeH = h+200+"px";
	


	
	top.layer.open({
		 type: 1,
		  title: '二维码',
		  shadeClose: true,
		  area: [openIframeW, openIframeH],
		  btn : ['关闭'],
		  content: str,
		  
		  
	});
}
</script>


</html>
