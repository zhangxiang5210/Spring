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
.btn:hover{
	color:#2d6dcc;
	border-color: #29e;
}

</style>	  
</head>
  
<body>
  <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 前台管理 <span class="c-gray en">&gt;</span> 账单列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
  
  <div class="page-container">
	<div class="cl pd-5 bg-1 bk-gray mt-20" id="timeButton"> 
		<button class="btn" value="1">今日</button>
		<button class="btn  m-l" value="3">近3日</button>
		<button class="btn  m-l" value="7">近1周</button>
		<button class="btn  m-l" value="30">近1个月</button>
		<button class="btn  m-l" value="31">当月</button>
		<button class="btn  m-l" value="366">当年</button>
		<button class="btn  m-l" value="">全部</button>
	</div>
	<div class="pd-20">
		<div class="row cl">
			<label class="form-label f-l">收款状态:</label>
			<div class="formControls col-2 f-l">
				<select class="select select-box" id="status" onchange="doSearch(false)">
					<option value="">请选择</option>
					<option value="1">未付</option>
					<option value="2">已付</option>
					<option value="9">已删除</option>
				</select>
			</div>
			<label class="form-label f-l">类型:</label>
			<div class="formControls col-2 f-l">
				<select class="select select-box" id="type" onchange="doSearch(false)">
					<option value="">请选择</option>
					<option value="1">店内用餐 </option>
					<option value="2">预约 </option>
					<option value="3">外卖</option>
				</select>
			</div>
			<label class="form-label f-l">收款类型:</label>
			<div class="formControls col-2 f-l">
				<select class="select select-box" id="receiveType" onchange="doSearch(false)">
					<option value="">请选择</option>
					<option value="1">现金</option>
					<option value="2">支付宝</option>
					<option value="3">微信</option>
					<option value="4">百付宝</option>
					<option value="5">其它</option>
				</select>
			</div>
			<label class="form-label f-l m-l">关键字:</label>
			<div class="formControls col-2 f-l">
				<input type="text"  id="keyWord" placeholder="请输入位置/账单编号"  class="input-text">
			</div>
			<button class="btn  m-l" onclick="doSearch(false)">查询</button>
		</div>
	</div>
		
	
	
  	<div class="mt-20">
  		<table class="table table-border table-bordered table-hover table-bg table-sort" id="menuFoodList">
  			<thead>
  				<tr>
					<th  style="min-width: 45px;">位置</th>
					<th>账单编号</th>
					<th>状态</th>
					<th>应收金额</th>
					<th>实收金额</th>
					<th>类型</th>
					<th>收款类型</th>
					<th>收款方式</th>
					<th>收款人</th>
					<th>用餐人数</th>
					<th>操作</th>
				</tr>
  			</thead>
  			<tbody>
  				
  			</tbody>
  		</table>
  	</div>
  </div>
  
</body>

<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=2114812" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/share.js"></script>
<script src="${pageContext.request.contextPath}/js/clipboard.min.js"></script>
<script type="text/javascript">
var billTable = null;


$(function(){
	getTableList();
	
	$("#timeButton button").click(function(){
		if(!$(this).hasClass("active")){
			$(this).parent().find("button").each(function(){
				$(this).removeClass("active");
			});
			$(this).addClass("active");
			doSearch(false);
		}
	});
	
	//复制模块
	var clipboard = new Clipboard('.btn2', {
	    text: function(el) {
	    	var id = $(el).attr("copyId");
	    	var url = shareUrl+"?id="+id;
	    	return url;
	    }
	});

	clipboard.on('success', function(e) {
		top.layer.msg("复制成功，请去粘贴");
		console.log(e);
	});

	clipboard.on('error', function(e) {
		top.layer.msg("复制失败，请联系管理员");
	});
	
});



function getTableList(){
	billTable = $("#menuFoodList").dataTable({
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
			 
			 $("#timeButton").find("button").each(function(){
				 if($(this).hasClass("active")){
					 data.time = $(this).attr("value");
				 }
			 });
			 
			$.ajax({
                 type: "post",
                 url: "${pageContext.request.contextPath}/user/bill_list_hander.htm",
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
                     
                     //统计
                     $("#timeButton span").remove();
                     var str = '';
                     str += '<span class="m-l">';
                     str += '应收款：';
                     str += '<b>'+rounded(result.arTotalMoney, 2)+'</b>&nbsp;&nbsp;';
                     str += '<small>('+result.arNum+')单</small>';
                     str += '</span>';
                     
                     
                     str += '<span class="m-l">';
                     str += '实收款：';
                     str += '<b>'+rounded(result.payTotalMoney, 2)+'</b>&nbsp;&nbsp;';
                     str += '<small>('+result.payNum+')单</small>';
                     str += '</span>';
                     
                     $("#timeButton").append(str);
                     
                     
                     
                     
                 },
                 error: function(XMLHttpRequest, textStatus, errorThrown) {
                   //TODO
                 },
                 
             });
		},
		
		columns: [
                  { data: "locationNumber" },
                  { data: "billNumber" },
                  { data: "status",
                	  render : function(data,type,row,meta){
                		  if(data == "" || data == null){
                			  return "未知";
                		  }
                		  if(data == 1){
                			  return '<a style="color:#06ABF5;">未付</a>';
                		  }
                		  if(data == 2){
                			  return '<a style="color:#00c319;">已付</a>';
                		  }
                		  if(data == 9){
                			  return '<a style="color:red;">已删除</a>';
                		  }
                	  }
                  },
                  { data: "arMoney"},
                  { data: "payMoney"},
                  { data: "type",
                	  render : function(data,type,row,meta){
                		  if(data == "" || data == null){
                			  return "";
                		  }
                		  if(data == 1){
                			  return "店内用餐";
                		  }
                		  if(data == 2){
                			  return "预约 ";
                		  }
                		  if(data == 3){
                			  return "外卖";
                		  }
                	  }
                  },
                  { data: "receiveType" ,
                	  render : function(data,type,row,meta){
                		  if(data == "" || data == null){
                			  return "";
                		  }
                		  if(data == 1){
                			  return "现金";
                		  }
                		  if(data == 2){
                			  return "支付宝";
                		  }
                		  if(data == 3){
                			  return "微信";
                		  }
                		  if(data == 4){
                			  return "百付宝";
                		  }
                		  if(data == 5){
                			  return "其它";
                		  }
                		  
                		  
                	  }
                  },
                  { data: "receiveWay",
                	  render : function(data,type,row,meta){
                		  if(data == "" || data == null){
                			  return "";
                		  }
                		  if(data == 1){
                			  return "手动";
                		  }
                		  if(data == 2){
                			  return "系统";
                		  }
                	  }
                  },
                  { data: "receiveLonginName" },
                  { data: "userNum",
                	  render : function(data,type,row,meta){
                		  if(data == "" || data == null || data == 0){
                			  return "";
                		  }else{
                			  return data;
                		  }
                		  
                		  
                	  }
                  },
                  { data: "",
                	  render : function(data,type,row,meta){
                		  var str ='';
                		  if(row.status == 9){
                			  str += '<a class="a-detail" onclick="detail('+row.id+')">详情<a/>&nbsp;&nbsp;';
                		  }
                		  if(row.status == 2){
                			  str += '<a class="a-detail" onclick="detail('+row.id+')">详情<a/>&nbsp;&nbsp;';
      						  str += '<a class="a-edit" onclick="edit('+row.id+')">编辑<a/>&nbsp;&nbsp;';
                		  }
                		  if(row.status == 1){
                			  str += '<a class="a-detail" onclick="detail('+row.id+')">详情<a/>&nbsp;&nbsp;';
      						  str += '<a class="a-edit" onclick="edit('+row.id+')">编辑<a/>&nbsp;&nbsp;';
      						  str += '<a class="a-del" onclick="del('+row.id+')">删除<a/>&nbsp;&nbsp;';
      						  str += '<a class="a-rec" onclick="rec('+row.id+')">收款<a/>&nbsp;&nbsp;';
      						  str += '<a class="a-rec" onclick="codeRec('+row.id+')">二维码收款<a/>&nbsp;&nbsp;';
      						  str += '<a class="a-rec" onclick="share('+row.id+')">分享<a/>&nbsp;&nbsp;';
                		  }
                		  
                		  str += '<a class="a-rec btn2" copyId="'+row.id+'"  title="复制菜单链接">复制<a/>';
  						  
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
	billTable.fnDraw(flag);
}




function reload(){
	doSearch();
	layer.closeAll('iframe');
}


/**
 * 详情
 */
function detail(id){
	var index = layer.open({
		 type: 2,
		  title: '账单详情',
		  shadeClose: true,
		  area: ['800px', '460px'],
		  btn : ['关闭'],
		  content: "${pageContext.request.contextPath}/user/bill_detail.htm?id="+id,
		  
	});
	layer.full(index);
}


/**
 * 编辑
 */
function edit(id){
	var index = layer.open({
		 type: 2,
		  title: '账单编辑',
		  shadeClose: true,
		  area: ['800px', '460px'],
		  btn : ['提交','关闭'],
		  content: "${pageContext.request.contextPath}/user/bill_edit.htm?id="+id,
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			  iframeWin.submitForm();
		  },
	});
	layer.full(index);
}

/**
 * 删除
 */
function del(id){
	top.layer.confirm("删除后不可恢复，您确定要删除吗？",function(){
		$.ajax({
	    	type: "POST",
	    	url: "${pageContext.request.contextPath}/user/del_bill.htm",
	    	cache: false,
	    	dataType: "json",
	    	data:{id:id},
	    	async:true,//false同步执行 true异步 默认true
	    	success: function(result){
	    		if(result.success){
	    			top.layer.closeAll();
		    		top.layer.msg(result.msg);
	    			doSearch(false);
	    		}else{
	    			top.layer.msg(result.msg);
	    		}
	    	},
			error: function(xhr, type){
			}
	    });
	 });
}


/**
 * 收款
 */
function rec(id){
	var bill = getBill(id);
	/* if(bill.status == 9){
		return;
	} */
	var str = '';
	str += '<div style="margin:30px;">';
	
	str += '<div style="width:90%;margin-left:7%;margin-top:20px;">';
	str += '<label>应收金额:<label>';
	str += '<label style="margin-left:15px;">'+rounded(bill.arMoney, 2)+'元</label>';
	str += '</div>';
	
	str += '<div style="width:90%;margin-left:7%;margin-top:20px;">';
	str += '<label>已收金额:<label>';
	str += '<label style="margin-left:15px;">'+rounded(bill.payMoney, 2)+'元</label>';
	str += '</div>';
	
	str += '<div style="width:90%;margin-left:7%;margin-top:20px;">';
	str += '<label>实收金额:<label>';
	str += '<label style="width:50%;margin-left:15px;"><input id="payMoney" name="payMoney" value="'+rounded(bill.arMoney-bill.payMoney, 2)+'" class="input-text" style="width:70%;"></label>';
	str += '</div>';
	
	
	str += '<div style="width:90%;margin-left:7%;margin-top:20px;">';
	str += '<label>收款类型:<label>';
	str += '<label style="width:50%;margin-left:15px;">';
	str += '<select class="select select-box" id="receiveType" style="width:70%;">';
	str += '<option value="1">现金</option>';
	str += '<option value="2">支付宝</option>';
	str += '<option value="3">微信</option>';
	str += '<option value="4">百付宝</option>';
	str += '<option value="5">其它</option>';
	str += '</select>';
	str += '</label>';
	str += '</div>';
	
	str += '<div style="width:90%;margin-left:7%;margin-top:20px;">';
	str += '<label>收款备注:<label>';
	str += '<label style="width:50%;margin-left:15px;"><input id="billMemo" name="billMemo" value="'+bill.billMemo+'" class="input-text" style="width:70%;"></label>';
	str += '</div>';
	
	str += '</div>';
	
	
	top.layer.open({
		 type: 1,
		  title: '账单收款('+bill.locationNumber+')',
		  shadeClose: true,
		  area: ['450px', '380px'],
		  btn : ['提交','关闭'],
		  content: str,
		  yes:function(index,layero){//该回调携带两个参数，分别为当前层索引、当前层DOM对象
			  recSubmit(id,rounded(bill.arMoney-bill.payMoney, 2),bill.menuCount);
		  },
		  success:function(){
			    top.$("#payMoney").mouseleave(function(){
			    	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
			    	if(!reg.test($(this).val())){
			    		$(this).addClass("error-input");
			    	}else{
			    		$(this).removeClass("error-input");
			    	}
			  });
		  }
		  
	});
}

/**
 * 收款提交
 */
function recSubmit(id,sourcePayMoney,menuCount){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	var payMoney = top.$("#payMoney").val();
	var receiveType = top.$("#receiveType").val();
	var billMemo = top.$("#billMemo").val();
	if(!reg.test(payMoney)){
		top.layer.alert("请输入合法金额");
		return false;
	}
	var msg ="您确定提交吗？";
	if(sourcePayMoney>payMoney){
		msg = "实收金额小于应付款金额(优惠："+rounded(sourcePayMoney-payMoney, 2)+"元)，您确定提交吗？";
	}
	
	
	
	top.layer.confirm(msg,function(){
		$.ajax({
	    	type: "POST",
	    	url: "${pageContext.request.contextPath}/user/receive_bill.htm",
	    	cache: false,
	    	dataType: "json",
	    	data:{id:id,payMoney:payMoney,receiveType:receiveType,billMemo:billMemo,menuCount:menuCount},
	    	async:true,//false同步执行 true异步 默认true
	    	success: function(result){
	    		if(result.success){
	    			top.layer.closeAll();
		    		top.layer.msg(result.msg);
	    			doSearch(false);
	    		}else{
	    			top.layer.msg(result.msg);
	    		}
	    	},
			error: function(xhr, type){
			}
	    });
	});
	
	
}

/**
 * 获取账单
 */
function getBill(id){
	var bill = "";
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/get_bill.htm",
    	cache: false,
    	dataType: "json",
    	data:{id:id},
    	async:false,//false同步执行 true异步 默认true
    	success: function(result){
    		bill = result.bill;
    	},
		error: function(xhr, type){
		}
    });
	return bill;
}



/**
 * 扫码收款
 */
function codeRec(id){
	top.layer.msg("暂未开放");
}

/**
 * 分享
 */
var jiathis_config = {};
function share(id){
	/* $.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/share_data.htm",
    	cache: false,
    	async:false,//false为同步
    	dataType: "json",
    	data:{id:id},
    	success: function(result){
    		var str = '';
    		str += ' \n信息：'+result.info+' \n';
    		str += '备注：'+result.memo+'\n';
    		if(result.foods != null){
    			for (var int = 0; int < result.foods.length; int++) {
    				var food = result.foods[int];
    				str += food.name+'('+food.num+')\n';
    			}
    		}
    	
    		jiathis_config = {
    	     		data_track_clickback:true,
    	     		url:"http://zhangxiang.pub",
    	     	    title:"春和发菜单分享",
    	     		summary:"",
    	     		siteNum:15,
    	     		
    	     };
    		jiathis_sendto('cqq');
    		
    		
    	},
		error: function(xhr, type){
		}
    }); */
    var url = shareUrl+"?id="+id;
    jiathis_config = {
     		data_track_clickback:true,
     		url:url,
     	    title:"",
     		summary:"",
     		siteNum:15,
     		
     };
	jiathis_sendto('cqq');
   
    
    //window.open("http://www.jiathis.com/share?uid=2114812");
}



</script>


</html>
