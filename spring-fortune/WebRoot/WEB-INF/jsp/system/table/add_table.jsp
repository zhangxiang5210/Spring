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
	
	
<style type="text/css">
form{
	margin:20px;
}
</style>	   
</head>

<body>
   <div class="col-md-12">
	  <div class="box-info ">
	        <form class="form-horizontal">
	          <div class="box-body">
	            <div class="form-group"  >
	              <label for="locationNumber" class="col-sm-2 control-label"><span style="color:red;">*</span>编号</label>
	              <div class="col-sm-4" >
	                <input type="text" class="form-control" name="locationNumber" id="locationNumber" placeholder="请输入桌位编号"  onchange="checkLocationNumber()">
	              </div>
	            </div>
	            <div class="form-group">
	              <label for="memo" class="col-sm-2 control-label">备注</label>
	
	              <div class="col-sm-4">
	                <input type="text" class="form-control" name="memo" id="memo" placeholder="请输入备注">
	              </div>
	            </div>
	            
	          </div>
	          <!-- /.box-body -->
	        </form>
	      </div>
      </div>
</body>
<script type="text/javascript">
var numberFlag = true;
function checkLocationNumber(){
	var locationNumber = $("#locationNumber").val().replace(/\s+/g,"");//去除所有空格
	if(locationNumber==""){
		layer.tips("请输入桌位编号","#locationNumber",{
			tips:[1,tipsColor],
			tipsMore: true,
		});
		numberFlag = false;
		$("#locationNumber").addClass("error-input");
		return false;
	}else{
		$("#locationNumber").removeClass("error-input");
	}
	
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/add_table_submit.htm",
    	cache: false,
    	dataType: "json",
    	data:{locationNumber:locationNumber},
    	success: function(result){
    		if(!result.success){
    			layer.msg(result.msg);
    			$("#locationNumber").addClass("error-input");
    			numberFlag = false; 
    		}else{
    			numberFlag = true;
    			$("#locationNumber").removeClass("error-input");
    		}
    		
    	},
		error: function(xhr, type){
		}
    });
	
}

function submitForm(){
	checkLocationNumber();
	if(!numberFlag){
		return false;
	}
	var locationNumber = $("#locationNumber").val().replace(/\s+/g,"");
	var memo = $("#memo").val();
	submitLoad();
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/add_table_submit.htm",
    	cache: false,
    	dataType: "json",
    	data:{locationNumber:locationNumber,memo:memo,action:"do"},
    	success: function(result){
    		if(result.success){
    			top.layer.closeAll();
    			top.layer.msg("添加成功");
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
