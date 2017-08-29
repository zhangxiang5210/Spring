<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>

<html lang="en">
<head>
	<title>春和发管理平台</title>
	<%@ include file="/WEB-INF/jsp/include/base.jsp"%>	
	<%@ include file="/WEB-INF/jsp/include/adminLTE.jsp"%>	
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	
	
<style type="text/css">

</style>	   
</head>

<body>
   <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 前台管理 <span class="c-gray en">&gt;</span> 外卖信息 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
   <div class="col-md-12">
	  <div class="box-info ">
	        <form  action="${pageContext.request.contextPath}/user/order_bill_info.htm" class="form-horizontal" id="form" method="post">
	          <input type="hidden" name="action" value="do">
	          <input type="hidden" name="idArray" id="idArray">
	          <input type="hidden" name="numArray" id="numArray">
	          <input type="hidden" name="peopleNum" id="peopleNum">
	          <div class="box-body">
	            <div class="form-group"  >
	              <label for="locationNumber" class="col-sm-2 control-label"><span style="color:red;">*</span>姓名</label>
	              <div class="col-sm-4" >
	                <input type="text" class="form-control" name="name" id="name" placeholder="请输入预约人姓名" onchange="checkName()">
	              </div>
	              <label for="memo" class="col-sm-2 control-label"><span style="color:red;">*</span>手机</label>
	              <div class="col-sm-4">
	                <input type="text" class="form-control" name="phone" id="phone" placeholder="请输入预约人手机号" onchange="checkPhone()">
	              </div>
	            </div>
	            
	            <div class="form-group">
	              <label for="memo" class="col-sm-2 control-label"><span style="color:red;">*</span>地址</label>
	              <div class="col-sm-10">
	                <input type="text" class="form-control" name="address" id="address" placeholder="请输入外卖地址" onchange="checkAddress()">
	              </div>
	            </div>
	            <div class="form-group">
	              <label for="memo" class="col-sm-2 control-label">备注</label>
	              <div class="col-sm-10">
	                <textarea rows="3" name="memo" id="memo" class="form-control" placeholder="请输入备注"></textarea>
	              </div>
	            </div>
	            
	          </div>
	          <!-- /.box-body -->
	        </form>
	      </div>
      </div>
</body>
<script type="text/javascript">
function checkName(){
	var name = $.trim($("#name").val());
	if(name==""){
		layer.tips("请输入姓名","#name",{
			tips:[2,tipsColor],
			tipsMore: true,
		});
		$("#name").addClass("error-input");
		return false;
	}
	$("#name").removeClass("error-input");
}

function checkPhone(){
	var reg = /^1[3|4|5|7|8|9]\d{9}$/;
	var phone = $.trim($("#phone").val());
	if(phone==""){
		layer.tips("请输入手机号","#phone",{
			tips:[2,tipsColor],
			tipsMore: true,
		});
		$("#phone").addClass("error-input");
		return false;
	}
	if(!reg.test(phone)){
		layer.tips("手机号非法","#phone",{
			tips:[2,tipsColor],
			tipsMore: true,
		});
		$("#phone").addClass("error-input");
		return false;
	}
	$("#phone").removeClass("error-input");
}

function checkAddress(){
	var address = $.trim($("#address").val());
	if(address==""){
		layer.tips("请输入地址","#address",{
			tips:[2,tipsColor],
			tipsMore: true,
		});
		$("#address").addClass("error-input");
		return false;
	}
	$("#address").removeClass("error-input");
}

function submitForm(){
	var flag = true;
	if(checkName() == false){
		flag = false;
	}
	if(checkPhone() == false){
		flag = false;
	}
	if(checkAddress() == false){
		flag = false;
	}
	if(!flag){
		top.layer.closeAll('loading');
		return false;
	}
	
	$.ajax({
    	type: "POST",
    	url: "${pageContext.request.contextPath}/user/take_away_bill.htm",
    	cache: false,
    	dataType: "json",
    	data:$('#form').serialize(),
    	success: function(result){
    		if(result.success){
    			top.layer.closeAll();
        		top.layer.msg(result.msg);
    		}else{
    			top.layer.closeAll('loading');
        		top.layer.msg(result.msg);
    		}
    		
    	},
		error: function(xhr, type){
		}
    });
}
</script>


</html>
