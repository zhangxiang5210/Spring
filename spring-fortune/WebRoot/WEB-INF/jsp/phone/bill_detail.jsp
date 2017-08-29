<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>

<html lang="en">
<head>
	<title>账单详情</title>
	
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<%@ include file="/WEB-INF/jsp/include/base.jsp"%>	
	<%@include  file="/WEB-INF/jsp/include/hui.jsp" %>
	
	
	
<style type="text/css">
.m-l{
	margin-left: 5%;
	float: left;
}
.row{
	display: inline-table;
	width: 100%;
}

</style>	  
</head>
  
<body>
   <div class="page-container">
   		<div class="row">
   			<label class="form-label m-l" >账单编号:</label>
   			<label class="form-label m-l">${bill.billNumber}</label>
   		</div>
   		<div class="row">
   			<label class="form-label m-l" >应付金额:</label>
   			<label class="form-label m-l">
   				<fmt:formatNumber pattern="0.00">${bill.arMoney}</fmt:formatNumber>元
   			</label>
   			<label class="form-label m-l" >已付金额:</label>
   			<label class="form-label m-l"> 
   				<fmt:formatNumber pattern="0.00">${bill.payMoney }</fmt:formatNumber>元
   			</label>
   		</div>
   		<div class="row">
   			<label class="form-label m-l" >下单时间:</label>
   			<label class="form-label m-l"> 
   				<fmt:formatDate value="${bill.createTime }" pattern="yyyy-MM-dd hh:mm:ss"/>
   			</label>
   		</div>
   		
   		<div class="mt-20" >
   			<table class="table table-border table-bordered table-hover table-bg table-sort" id="menuFoodList" >
   				<thead>
	 				<tr>
	 					<th>名称</th>
	 					<!-- <th>编号</th> -->
	 					<th>数量</th>
						<th>单价</th>
						<th>单位</th>
						<th>状态</th>
	 				</tr>
	 			</thead>
	 			<tbody>
	 				<c:forEach items="${foods}" var="item">
	 					<tr>
	 						<td>${item.name}</td>
	 						<%-- <td>${item.nameNumber}</td> --%>
	 						<td>
	 							<fmt:formatNumber pattern="#.##">${item.num}</fmt:formatNumber>
	 						</td>
	 						<td>
	 							<fmt:formatNumber pattern="#.##">${item.price}</fmt:formatNumber>
	 						</td>
	 						<td>
	 							<c:if test="${item.unit == 1}">份</c:if>
	      						<c:if test="${item.unit == 2}">份</c:if>
	      						<c:if test="${item.unit == 3}">斤</c:if>
	      						<c:if test="${item.unit == 4}">两</c:if>
	       						<c:if test="${item.unit == 5}">把</c:if>
	       						<c:if test="${item.unit == 6}">个</c:if>
	       						<c:if test="${item.unit == 7}">瓶</c:if>
	       						<c:if test="${item.unit == 8}">箱</c:if>
	 						</td>
	 						<td>
          						<c:if test="${item.status == 1}">待处理</c:if>
          						<c:if test="${item.status == 2}">处理中</c:if>
          						<c:if test="${item.status == 3}">做好</c:if>
          						<c:if test="${item.status == 4}">已上</c:if>
          						<c:if test="${item.status == 9}"><a style="color:red;">已取消</a></c:if>
          					</td>
	 					</tr>
	 				</c:forEach>
	 			</tbody>
   			</table>
   		</div>
   </div>
</body>
</html>
