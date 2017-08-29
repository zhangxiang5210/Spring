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

</style>	   
</head>

<body>
   <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 厨房管理 <span class="c-gray en">&gt;</span> 菜单编辑 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
   <div class="col-md-12">
	  <div class="box-info ">
	        <form  action="${pageContext.request.contextPath}/user/menu_edit.htm" class="form-horizontal" id="form" method="post">
	          <input type="hidden" name="action" value="do">
	          <input type="hidden" name="id" value="${id}">
	          <div class="box-body">
	            <div class="form-group"  >
	              <label for="locationNumber" class="col-sm-1 control-label"><span style="color:red;">*</span>类型</label>
	              <div class="col-sm-4" >
	                <select class="form-control" name="menuType" id="menuType">
	                	<c:forEach items="${menuTypes}" var="item">
	                		<option value="${item.id}" <c:if test="${item.id == food.menuTypeId}">selected="selected"</c:if> >${item.typeName}</option>
	                	</c:forEach>
	                </select>
	              </div>
	              <label for="memo" class="col-sm-1 control-label"><span style="color:red;">*</span>名称</label>
	              <div class="col-sm-4">
	                <input type="text" class="form-control" name="foodName" id="foodName" placeholder="请输入菜单名称" onchange="checkCheckFoodName()" value="${food.name}">
	              </div>
	            </div>
	            
	            <div class="form-group">
	              <label for="memo" class="col-sm-1 control-label"><span style="color:red;">*</span>价格</label>
	              <div class="col-sm-4">
	                <input type="text" class="form-control" name="price" id="price" placeholder="请输入价格" onchange="checkPrice()" value="${food.price}">
	              </div>
	              <label for="memo" class="col-sm-1 control-label"><span style="color:red;">*</span>编号</label>
	              <div class="col-sm-4">
	                <input type="text" class="form-control" name="nameNumber" id="nameNumber" placeholder="请输入编号" onchange="checkNumber()" value="${food.nameNumber}">
	              </div>
	            </div>
	            
	            <div class="form-group">
	              <label for="memo" class="col-sm-1 control-label"><span style="color:red;">*</span>单位</label>
	              <div class="col-sm-4">
	                <select class="form-control" name="unit" id="unit">
	                	<option value="1" <c:if test="${food.unit == 1}">selected="selected"</c:if> >份</option>
	                	<option value="2" <c:if test="${food.unit == 2}">selected="selected"</c:if> >串</option>
	                	<option value="5" <c:if test="${food.unit == 5}">selected="selected"</c:if> >把</option>
	                	<option value="3" <c:if test="${food.unit == 3}">selected="selected"</c:if> >斤</option>
	                	<option value="4" <c:if test="${food.unit == 4}">selected="selected"</c:if> >两</option>
	                	<option value="6" <c:if test="${food.unit == 6}">selected="selected"</c:if> >个</option>
	                	<option value="7" <c:if test="${food.unit == 7}">selected="selected"</c:if> >瓶</option>
	                	<option value="8" <c:if test="${food.unit == 7}">selected="selected"</c:if> >箱</option>
	                </select>
	              </div>
	            </div>
	            
	            <div class="form-group">
	              <label for="memo" class="col-sm-1 control-label">备注</label>
	              <div class="col-sm-9">
	                <textarea rows="3" name="memo" id="memo" class="form-control" placeholder="请输入备注">${food.memo}</textarea>
	              </div>
	            </div>
	            
	            
	            <div class="form-group">
	              <label for="memo" class="col-sm-1 control-label">图片</label>
	              <div id="fileList" class="img-contain"  >
	              	<c:forEach items="${imgList}" var="item">
	              	<div  class="file-item thumbnail upload-state-done" style="margin-left: 1%;">
	              		<img class="timg" src="${annexBasepath }/${item.filePath}" style="height:100px;width:100px" onclick="uploadTmp.showImage('${item.filePath}')">
	              		<img title="点击删除"  style="left: 85px; top: 0px; width: 15px; height: 15px; position: absolute; cursor: pointer;" src="${pageContext.request.contextPath}/js/upload/cancel.png" onclick="delsImg(this,'${item.id}')">
	              	</div>
	              </c:forEach>
	              </div>
	             </div>
	              
	              <div class="form-group">
	              	<div class="uploader-btns" style="margin-left: 9.5%;">
					 	<div id="picker" class="uploader-picker"> 图片上传</div>
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
	var nameNumber = $("#nameNumber").val();
	if(nameNumber == ""){
		layer.tips("请输入编号","#nameNumber",{
			tips:[2,tipsColor],
			tipsMore: true,
		});
		$("#nameNumber").addClass("error-input");
		return false;
	}
}

function submitForm(){
	var flag = true;
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
		return false;
	}
	
	/* top.layer.load(1, {
	  shade: [0.3,'#000'] //0.1透明度的白色背景
	}); */
	
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/menu_edit.htm",
    	cache: false,
    	dataType: "json",
    	data:$('#form').serialize(),
    	success: function(result){
    		if(result.success){
    			top.layer.closeAll();
    			top.layer.msg("修改成功");
    			parent.reload();
    			
    		}else{
    			top.layer.msg(result.msg);
    			top.layer.closeAll('loading');
    		}
    		
    	},
		error: function(xhr, type){
		}
    });
}

/**
 * 删除图片
 */
function delsImg(el,id){
	top.layer.confirm('您确定删除该图片吗？', {
		  btn: ['确定','取消'] //按钮
		}, function(index){
			
			$.ajax({
		    	type: "POST",
		    	url: "${pageContext.request.contextPath}/user/annex_delete.htm",
		    	cache: false,
		    	dataType: "json",
		    	data:{id:id},
		    	success: function(result){
		    		if(result.success){
		    			top.layer.msg("删除成功");
		    			$(el).parent().remove();
		    		}else{
		    			top.layer.msg(result.msg);
		    		}
		    		
		    	},
				error: function(xhr, type){
				}
		    });
  	
		});
}

</script>


</html>
