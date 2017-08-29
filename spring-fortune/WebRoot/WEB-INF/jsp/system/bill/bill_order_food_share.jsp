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
.form-group{
	margin-bottom: 15px;
	display: inline-block;
	width: 100%;
}
#sourceOrder td,#sourceOrder th{
	border: 1px solid #ddd;
	vertical-align: middle;
}

#refresh{
	margin-left: 60%;
	background-color: #f0f0f0;
}
</style>	   
</head>

<body>
   <div class="col-md-12" >
	  <div class="box-info ">
	          <div class="box-body">
	            
	            <div class="form-group" >
	            	 <div class="info-div" >&nbsp;&nbsp;基本信息 </div>
	            	 <label class="col-sm-1 control-label">位置</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">${bill.locationNumber}</label>
		              </div>
		              <label class="col-sm-1 control-label">账单编号</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">${bill.billNumber}</label>
		              </div>
		              <label class="col-sm-1 control-label">类型</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		<c:if test="${bill.type==1}">店内用餐 </c:if>
		              		<c:if test="${bill.type==2}">预约 </c:if>
		              		<c:if test="${bill.type==3}">外卖 </c:if>
		              	</label>
		              </div>
	            </div>
	            
	            
	             <div class="form-group"  >
		              <label class="col-sm-1 control-label">状态</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		<c:if test="${bill.status==1}">未付 </c:if>
		              		<c:if test="${bill.status==2}">已付 </c:if>
		              		<c:if test="${bill.status==9}"><a style="color:red;">删除</a> </c:if>
		              	</label>
		              </div>
		               <label class="col-sm-1 control-label">创建时间</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		<fmt:formatDate value="${bill.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
		              	</label>
		              </div>
		               <label class="col-sm-1 control-label">创建人</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">${bill.creator}</label>
		              </div>
	            </div>
	            
	            <div class="form-group" >
	            	<label class="col-sm-1 control-label">用餐人数</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		<c:if test="${bill.userNum !=0}">${bill.userNum}</c:if>
		              	</label>
		              </div>
		              <label class="col-sm-1 control-label">用户备注</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		${bill.memo}
		              	</label>
		              </div>
	            </div>
	            
	            
	            <!-- 预约信息 -->
	            <div id="reservationInfo" style="display: none;">
		            <div class="info-div" >&nbsp;&nbsp;预约信息 </div>
		            <div class="form-group"  >
		            	  <label class="col-sm-1 control-label">姓名</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">${reservationInfo.name}</label>
			              </div>
			              <label class="col-sm-1 control-label">电话</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">${reservationInfo.phone}</label>
			              </div>
			              <label class="col-sm-1 control-label">备注</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">${reservationInfo.memo}</label>
			              </div>
		            </div>
		            
		            <div class="form-group"  >
		            	  <label class="col-sm-1 control-label">时间(起)</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">
			              		<fmt:formatDate value="${reservationInfo.orderTimeStart}" pattern="yyyy-MM-dd HH:mm"/>
			              	</label>
			              </div>
			              <label class="col-sm-1 control-label">时间(终)</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">
			              		<fmt:formatDate value="${reservationInfo.orderTimeEnd}" pattern="yyyy-MM-dd HH:mm"/>
			              	</label>
			              </div>
			              <label class="col-sm-1 control-label">创建时间</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">
			              		<fmt:formatDate value="${reservationInfo.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			              	</label>
			              </div>
		            </div>
	            </div>
	            
	            <div id="takeOut" style="display: none;">
	            	<div class="info-div" >&nbsp;&nbsp;外卖信息 </div>
		            <div class="form-group"  >
		            	  <label class="col-sm-1 control-label">姓名</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">${takeOutInfo.name}</label>
			              </div>
			              <label class="col-sm-1 control-label">电话</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">${takeOutInfo.pnhone}</label>
			              </div>
			              <label class="col-sm-1 control-label">备注</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">${takeOutInfo.memo}</label>
			              </div>
		            </div>
		            <div class="form-group"  >
		            	  <label class="col-sm-1 control-label">创建时间</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">
			              		<fmt:formatDate value="${takeOutInfo.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			              	</label>
			              </div>
			              <label class="col-sm-1 control-label">地址</label>
			              <div class="col-sm-3" >
			              	<label class="control-text">${takeOutInfo.address}</label>
			              </div>
		            </div>
	            </div>
	            
	            
	            <div>
	            	<div class="info-div" >&nbsp;&nbsp;订单信息 <button class="btn" id="refresh">刷新</button></div>
	            	<table class="table table-border table-bordered table-hover table-bg table-sort" id="sourceOrder">
	            		<thead>
	            			<tr>
								<th>编号</th>
								<th>名称</th>
								<th>壮态</th>
								<th>数量</th>
								<!-- <th>价格</th> -->
								<th>单位</th>
								<!-- <th>总价</th> -->
								<th>支付状态</th>
								<th>创建时间</th>
							</tr>
	            		</thead>
	            		<tbody>
	            			<c:forEach items="${foods}" var="item">
	            				<tr>
	            					<td>${item.nameNumber}</td>
	            					<td>${item.name}</td>
	            					<td>
	            						<c:if test="${item.status == 1}">待处理</c:if>
	            						<c:if test="${item.status == 2}">处理中</c:if>
	            						<c:if test="${item.status == 3}">做好</c:if>
	            						<c:if test="${item.status == 4}">已上</c:if>
	            						<c:if test="${item.status == 9}"><a style="color:red;">已取消</a></c:if>
	            					</td>
	            					<td>
	            						<fmt:formatNumber pattern="#.##">${item.num}</fmt:formatNumber>
	            					</td>
	            					<%-- <td>
	            						<fmt:formatNumber pattern="0.00">${item.price}</fmt:formatNumber>
	            					</td> --%>
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
	            					<%-- <td>
	            						<fmt:formatNumber pattern="0.00">${item.num*item.price}</fmt:formatNumber>
	            					</td> --%>
	            					<td>
	            						<c:if test="${item.payStatus == 1}">未付</c:if>
	            						<c:if test="${item.payStatus == 2}">已付</c:if>
	            					</td>
	            					<td>
	            						<fmt:formatDate value="${item.createTime}" pattern="HH:mm"/>
	            					</td>
	            				</tr>
	            			</c:forEach>
	            		</tbody>
	            	</table>
	            </div>
	            
	            
	            
	          </div>
	          <!-- /.box-body -->
	      </div>
      </div>
</body>
<script type="text/javascript">
$(function(){
	if(${bill.type} == 2){
		$("#reservationInfo").show();
	}
	if(${bill.type} == 3){
		$("#takeOut").show();
	}
	
	$("#refresh").click(function(){
		window.location.reload();
	});
});

</script>


</html>
