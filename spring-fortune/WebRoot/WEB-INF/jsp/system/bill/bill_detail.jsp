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
</style>	   
</head>

<body>
<nav class="breadcrumb fixed"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 前台管理 <span class="c-gray en">&gt;</span> 账单详情 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
   <div class="col-md-12" style="margin-top: 50px;">
	  <div class="box-info ">
	          <div class="box-body">
	            
	            <%--  <div class="form-group" >
	             	<label class="col-sm-1 control-label">账单编号</label>
	             	<label class="col-sm-4 control-label">${bill.billNumber}</label>
	             </div> --%>
	            
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
		              		<c:if test="${bill.status==9}">删除 </c:if>
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
	            
	            <div class="form-group"  >
		              <label class="col-sm-1 control-label">收款人</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">${bill.receiveLonginName}</label>
		              </div>
		              <label class="col-sm-1 control-label">应收金额</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		<fmt:formatNumber pattern="#.##">${bill.arMoney}</fmt:formatNumber>
		              	</label>
		              </div>
		              <label class="col-sm-1 control-label">实收金额</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		<fmt:formatNumber pattern="#.##">${bill.payMoney}</fmt:formatNumber>
		              	</label>
		              </div>
	            </div>
	            
	            
	            <div class="form-group" >
		               <label class="col-sm-1 control-label">收款类型</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		<c:if test="${bill.receiveType == 1}">现金</c:if>
		              		<c:if test="${bill.receiveType == 2}">支付宝 </c:if>
		              		<c:if test="${bill.receiveType == 3}">微信</c:if>
		              		<c:if test="${bill.receiveType == 4}">百付宝</c:if>
		              		<c:if test="${bill.receiveType == 5}">其它</c:if>
		              	</label>
		              </div>
		              <label class="col-sm-1 control-label">收款方式</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		<c:if test="${bill.receiveType == 1}">手动</c:if>
		              		<c:if test="${bill.receiveType == 2}">系统</c:if>
		              	</label>
		              </div>
		               <label class="col-sm-1 control-label">收款时间</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		<fmt:formatDate value="${bill.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
		              	</label>
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
		               <label class="col-sm-1 control-label">账单备注</label>
		              <div class="col-sm-3" >
		              	<label class="control-text">
		              		${bill.billMemo}
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
	            	<div class="info-div" >&nbsp;&nbsp;订单信息 </div>
	            	<table class="table table-border table-bordered table-hover table-bg table-sort" id="sourceOrder">
	            		<thead>
	            			<tr>
								<th>编号</th>
								<th>类型</th>
								<th>名称</th>
								<th>壮态</th>
								<th>数量</th>
								<th>价格</th>
								<th>单位</th>
								<th>总价</th>
								<th>支付状态</th>
								<th>创建人</th>
								<th>创建时间</th>
								<th>操作人</th>
							</tr>
	            		</thead>
	            		<tbody>
	            			<c:forEach items="${foods}" var="item">
	            				<tr>
	            					<td>${item.nameNumber}</td>
	            					<td>${item.typeName}</td>
	            					<td>${item.name}</td>
	            					<td>
	            						<c:if test="${item.status == 1}">待处理</c:if>
	            						<c:if test="${item.status == 2}">处理中</c:if>
	            						<c:if test="${item.status == 3}">做好</c:if>
	            						<c:if test="${item.status == 4}">已上</c:if>
	            						<c:if test="${item.status == 9}"><a style="color:red;">已取消</a>(${item.delPerson})</c:if>
	            					</td>
	            					<td>
	            						<fmt:formatNumber pattern="#.##">${item.num}</fmt:formatNumber>
	            					</td>
	            					<td>
	            						<fmt:formatNumber pattern="0.00">${item.price}</fmt:formatNumber>
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
	            						<fmt:formatNumber pattern="0.00">${item.num*item.price}</fmt:formatNumber>
	            					</td>
	            					<td>
	            						<c:if test="${item.payStatus == 1}">未付</c:if>
	            						<c:if test="${item.payStatus == 2}">已付</c:if>
	            					</td>
	            					<td>${item.creator}</td>
	            					<td>
	            						<fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
	            					</td>
	            					<td>
	            						<div style="width: 50px;overflow:hidden;text-overflow:ellipsis;" title="${item.operationPerson}">${item.operationPerson}</div>
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
});

</script>


</html>
