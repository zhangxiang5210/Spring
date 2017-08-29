<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>

<html lang="en">
<head>
	<title>春和发管理平台</title>
	<%@ include file="/WEB-INF/jsp/include/base.jsp"%>	
	<%@ include file="/WEB-INF/jsp/include/adminLTE.jsp"%>	
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/upload/webuploader.css">
	
<style type="text/css">
.a{
	display: inline-block;
}
</style>	  


<body>
   <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 厨房管理 <span class="c-gray en">&gt;</span> 新增菜品 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
   <div class="col-md-12">
	  <div class="box-info ">
	        <form  action="${pageContext.request.contextPath}/user/add_menu_food.htm" class="form-horizontal" id="form" method="post">
	          <input type="hidden" name="action" value="do">
	          <input type="hidden" id="iframeOpen" value="${iframeOpen}">
	          <div class="box-body">
	            <div class="form-group"  >
	              <label for="locationNumber" class="col-sm-1 control-label"><span style="color:red;">*</span>类型</label>
	              <div class="col-sm-4" >
	                <select class="form-control" name="menuType" id="menuType">
	                	<c:forEach items="${menuTypes}" var="item">
	                		<option value="${item.id}">${item.typeName}</option>
	                	</c:forEach>
	                </select>
	              </div>
	              <label for="memo" class="col-sm-1 control-label"><span style="color:red;">*</span>名称</label>
	              <div class="col-sm-4">
	                <input type="text" class="form-control" name="foodName" id="foodName" placeholder="请输入菜单名称" onchange="checkCheckFoodName()">
	              </div>
	            </div>
	            
	            <div class="form-group">
	              <label for="memo" class="col-sm-1 control-label"><span style="color:red;">*</span>价格</label>
	              <div class="col-sm-4">
	                <input type="text" class="form-control" name="price" id="price" placeholder="请输入价格" onchange="checkPrice()">
	              </div>
	              <label for="memo" class="col-sm-1 control-label"><span style="color:red;">*</span>编号</label>
	              <div class="col-sm-4">
	                <input type="text" class="form-control" name="number" id="number" placeholder="请输入编号" onchange="checkNumber()">
	              </div>
	            </div>
	            
	            <div class="form-group">
	              <label for="memo" class="col-sm-1 control-label"><span style="color:red;">*</span>单位</label>
	              <div class="col-sm-4">
	                <select class="form-control" name="unit" id="unit">
	                	<option value="1">份</option>
	                	<option value="2">串</option>
	                	<option value="5">把</option>
	                	<option value="3">斤</option>
	                	<option value="4">两</option>
	                	<option value="6">个</option>
	                	<option value="7">瓶</option>
	                	<option value="8">箱</option>
	                </select>
	              </div>
	            </div>
	            
	            <div class="form-group">
	              <label for="memo" class="col-sm-1 control-label">备注</label>
	              <div class="col-sm-9">
	                <textarea rows="3" name="memo" id="memo" class="form-control" placeholder="请输入备注"></textarea>
	              </div>
	            </div>
	            
	             <!-- 图片上传 -->
	             <div class="form-group">
	              	 <ul id="fileList" class="uploader-list" style="margin-left: 6%;"></ul>
	            </div>
	             <div class="form-group">
	              	<div class="uploader-btns" style="margin-left: 9.5%;">
					 	<div id="picker" class="uploader-picker"> 图片上传</div>
					</div>
	            </div>
	            
	             <div class="form-group" id="submitId">
	             	<div class="col-sm-10" style="text-align: center;">
	             		<button type="button" class="btn" onclick="submitForm()">提交</button>
	             	</div>
	             	
	             </div>
	            
	          </div>
	          <!-- /.box-body -->
	        </form>
	      </div>
      </div>
</body>
<script src="${pageContext.request.contextPath}/js/upload/webuploader.min.js"></script>
<script src="${pageContext.request.contextPath}/js/upload/uploadTmp.js"></script>
<script type="text/javascript">
var swf = '${pageContext.request.contextPath}/js/upload/Uploader.swf';  // swf文件路径
var imgServer = '${pageContext.request.contextPath}/user/upload_images.htm'; // 图片接收服务端。
var fileServer = '${pageContext.request.contextPath}/user/upload_files.htm';// 文件接收服务端。
var deleteIcon = '${pageContext.request.contextPath}/js/upload/cancel.png'; //删除图片图标路径
var fjIcon = '${pageContext.request.contextPath}/images/fj.jpg';  //附件图片路径
var basePath = '${annexBasepath}';	
var delFilePath = '${pageContext.request.contextPath}/user/local_file_del.htm';
var uploader = null;

$(function(){
	uploader = uploadTmp.imgUpload('fileList','picker','imgPath');
});


var existNameFlag = true;//true存在
var existNumberFlag = true;//true存在
function checkMenuType(){
	var menuType = $("#menuType").val();
	if(menuType==null){
		top.layer.alert("请先去增加类型",function(){
			top.layer.closeAll();
			addMenuType();
		});
		return false;
	}
}

function checkCheckFoodName(){
	var foodName = $.trim($("#foodName").val());
	if(foodName == ""){
		layer.tips("请输入菜单名称","#foodName",{
			tips:[2,tipsColor],
			tipsMore: true,
		});
		$("#foodName").addClass("error-input");
		return false;
	}
	
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/is_exist_menu_food.htm",
    	cache: false,
    	dataType: "json",
    	data:{foodName:foodName},
    	success: function(result){
    		if(result.success){
    			layer.tips(result.msg,"#foodName",{
    				tips:[2,tipsColor],
    				tipsMore: true,
    			});
    			$("#foodName").addClass("error-input");
    		}else{
    			$("#foodName").removeClass("error-input");
    		}
    		existNameFlag = result.success; 
    		
    	},
		error: function(xhr, type){
		}
    });
}

function checkPrice(){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	var price = $("#price").val();
	if(!reg.test(price)){
		layer.tips("请输入合法金额","#price",{
			tips:[2,tipsColor],
			tipsMore: true,
		});
		$("#price").addClass("error-input");
		return false;
	}else{
		$("#price").removeClass("error-input");
	}
}

function checkNumber(){
	var number = $("#number").val();
	if(number == ""){
		layer.tips("请输入编号","#number",{
			tips:[2,tipsColor],
			tipsMore: true,
		});
		$("#number").addClass("error-input");
		return false;
	}
	
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/is_exist_menu_food_number.htm",
    	cache: false,
    	dataType: "json",
    	data:{number:number},
    	success: function(result){
    		if(result.success){
    			layer.tips(result.msg,"#number",{
    				tips:[2,tipsColor],
    				tipsMore: true,
    			});
    			$("#number").addClass("error-input");
    		}else{
    			$("#number").removeClass("error-input");
    		}
    		existNumberFlag = result.success; 
    		
    	},
		error: function(xhr, type){
		}
    });
	
}


function addMenuType(){
	top.layer.open({
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
function submitForm(){
	submitLoad();
	var flag = true;
	if(checkMenuType() == false){
		flag = false;
	}
	if(checkCheckFoodName() == false){
		flag = false;
	}
	if(checkPrice() == false){
		flag = false;
	}
	if(checkNumber() == false){
		flag = false;
	}
	
	
	if(!flag){
		closeIframeLoading();
		return false;
	}
	if(existNameFlag || existNumberFlag){
		closeIframeLoading();
		return false;
	}
	top.layer.load(1, {
		  shade: [0.3,'#000'] //0.1透明度的白色背景
	});
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/add_menu_food.htm",
    	cache: false,
    	dataType: "json",
    	data:$('#form').serialize(),
    	success: function(result){
    		closeIframeLoading();
    		if(result.success){
    			top.layer.closeAll();
    			top.layer.msg("添加成功");
    			var iframeOpen = $("#iframeOpen").val();
    			if(iframeOpen =="yes"){
    				parent.reload();
    			}else{
    				top.removeIframe();
    			}
    			
    		}else{
    			layer.msg(result.msg);
    			top.layer.closeAll('loading');
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
