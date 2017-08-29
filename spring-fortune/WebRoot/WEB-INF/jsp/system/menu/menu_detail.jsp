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
   <div class="col-md-12">
	  <div class="box-info ">
	          <div class="box-body">
	            <div class="form-group"  >
	              <label class="col-sm-1 control-label">类型</label>
	              <label class="control-text">${food.menuTypeName}</label>
	            </div>
	            <div class="form-group"  >
	              <label class="col-sm-1 control-label">名称</label>
	              <label class="control-text">${food.name}</label>
	            </div>
	            <div class="form-group"  >
	              <label class="col-sm-1 control-label">价格</label>
	              <label class="control-text">
	              	<fmt:formatNumber pattern="#.##">${food.price}</fmt:formatNumber>元
	              </label>
	            </div>
	            <div class="form-group"  >
	              <label class="col-sm-1 control-label">编号</label>
	              <label class="control-text">${food.nameNumber}</label>
	            </div>
	            <div class="form-group"  >
	              <label class="col-sm-1 control-label">备注</label>
	              <label class="control-text">${food.memo}</label>
	            </div>
	            <div class="form-group">
	              <label for="memo" class="col-sm-1 control-label">图片</label>
	              <div id="fileList" class="img-contain"  >
	              	<c:forEach items="${imgList}" var="item">
	              	<div  class="file-item thumbnail upload-state-done" style="margin-left: 1%;">
	              		<img class="timg" src="${annexBasepath }/${item.filePath}" style="height:100px;width:100px" onclick="uploadTmp.showImage('${item.filePath}')">
	              	</div>
	              </c:forEach>
	              </div>
	             </div>
	            
	            
	          </div>
	          <!-- /.box-body -->
	      </div>
      </div>
</body>
<script src="${pageContext.request.contextPath}/js/upload/webuploader.min.js"></script>
<script src="${pageContext.request.contextPath}/js/upload/uploadTmp.js"></script>
<script type="text/javascript">
var basePath = '${annexBasepath}';	

</script>


</html>
