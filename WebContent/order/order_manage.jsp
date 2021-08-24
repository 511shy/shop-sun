<%@ page language="java" import="java.util.*,com.beans.*,com.common.*"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML">
<html>
<head>
<title>订单管理</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.0.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	$(function() {
		$("#ch_checkall").click(function() {
			if ($("#ch_checkall").attr("checked") == "checked") {
				$("input[name=ck_id]").attr("checked", "checked");
			} else {
				$("input[name=ck_id]").removeAttr("checked");
			}
		});

		$("table tr").mouseover(function() {
			$(this).css("background", "#D3EAEF");
			$(this).siblings().css("background", "white");
		});
	});
</script>

<script>
	function subForm(pageIndex) {
		//pageIndex 不传入,表示,是点击"转到"按钮的时候触发的
		if (pageIndex) {
			$("#pageIndex").val(pageIndex);
			document.form1.submit();
		} else {
			document.form1.submit();
		}
	}

	//点击上方的删除按钮,进行多项删除
	function delMuti() {
		//判断用户至少选了一项
		if ($("input[name=ck_id]:checked").size() == 0) {
			alert("请至少选一项!");
		} else {
			if (confirm('确定要删除所选项吗')) {
				alert("此功能尚未完成!");
			}

		}
	}
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/maintable.css"></link>
<style>
.div_tools {
	width: 99.5%;
	height: 28px;
	background: #D3EAEF;
	margin: 0px auto;
	margin-top: 5px;
	margin-bottom: 5px;
	font-size: 12px;
	position: relative;
}

.div_tools select {
	height: 22px;
	font-size: 12px;
	margin-top: 3px;
}

#btnsubmit {
	width: 40px;
	height: 20px;
	font-size: 12px;
}
</style>

</head>

<body>

	<div class="div_title">
		<div class="div_titlename">
			<img src="images/san_jiao.gif"><span>订单列表</span>
		</div>
		<div class="div_titleoper">
			<input type="checkbox" /> 全选 <a href="#"> <img
				src="images/add.gif" />添加
			</a> <a href="javascript:delMuti()"><img src="images/del.gif" />删除</a> <a
				href="#"> <img src="images/edit.gif" />编辑
			</a>
		</div>
	</div>
	<form  action="OrderServlet.do?flag=manage"  name="form1">
		<div class="div_tools">
			&nbsp; &nbsp; &nbsp; 订单号: <input type="text" name="orderNo"
				value="${param.orderNo }"></input> 下单日期从: <input type="text"
				name="beginDate" onclick="WdatePicker()" value="${param.beginDate}" />
			到: <input type="text" name="endDate" onclick="WdatePicker()"
				value="${param.endDate}" /> 订单状态:

			<select name="orderState">
				<option value="">全部</option>
				<c:forEach var="state" items="${orderStateList}">
					<option value="${state.value }">${state}</option>
				</c:forEach>
			</select> 
			
			<input id="btnsubmit" type="submit" value="查询" />
		</div>

		<input type="hidden" name="flag" value="delAdmins" />
		<table class="main_table">
			<tr>
				<th><input type="checkbox" id="ch_checkall" /></th>
				<th>订单号</th>
				<th>付款方式</th>
				<th>-定单金额</th>
				<th>订单状态</th>
				<th>邮寄方式</th>
				<th>生成日期</th>
				<th>发货地址</th>
				<th>操作</th>
			</tr>
			<c:forEach var="order" items="${orderList}">
				<tr>
					<td><input type="checkbox" name="ck_id" value="${order.id}" />
					</td>
					<td>${order.orderNo }</td>
					<td>${order.payMethod }</td>
					<td>${order.amount }</td>
					<td>${order.orderState }</td>
					<td>${order.postMethod }</td>
					<td>${order.orderDate }</td>
					<td>${order.address }</td>
					<td>
						<c:set var="weifukuan" value="<%=Enums.EnumOrderState.未付款%>"></c:set> 
						<c:set var="yifukuan" value="<%=Enums.EnumOrderState.已支付%>"> </c:set> 
						<c:set var="yifahuo" value="<%=Enums.EnumOrderState.已发货%>"></c:set> 
						
						<a href="OrderServlet.do?flag=orderview&id=${order.id}">查看</a> | 
					    <c:if test="${order.orderState == yifukuan}">
							<a onclick="return confirm('确定要进行发货操作吗')" href="OrderServlet.do?pageIndex=${pageInfo.pageIndex}&flag=sendgoods&id=${order.id}">发货</a> |   
				 		</c:if> 
				 		<c:if test="${order.orderState eq weifukuan}">
							<a onclick="return confirm('确定要删除该订单吗?')"  
								href="OrderServlet.do?flag=del&id=${order.id}">刪除</a> |  
				 		</c:if> 
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>

		<div class="div_page">
			<div class="div_page_left">
				共有 <label>${pageInfo.rowCount }</label> 条记录，当前第 <label>${pageInfo.pageIndex }</label>
				页，共 <label>${pageInfo.pageCount }</label> 页
			</div>


			<div class="div_page_right">
				<c:choose>
					<c:when test="${pageInfo.hasPre }">
						<button onclick="subForm(1)">首页</button>
						<button onclick="subForm(${pageInfo.pageIndex-1})">上一页</button>
					</c:when>

					<c:otherwise>
						  			 首页
					  	 			 上一页
						  		</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${pageInfo.hasNext}">
						<button onclick="subForm(${pageInfo.pageIndex+1})">下一页</button>
						<button onclick="subForm(${pageInfo.pageCount})">尾页</button>
					</c:when>

					<c:otherwise>
						  			下一页 
					  	 		         尾页
						  		</c:otherwise>
				</c:choose>

				<button onclick="subForm()">转到</button>
				<input type="text" name="pageIndex" id="pageIndex"
					value="${pageInfo.pageIndex }" /> 页

			</div>
		</div>

</body>
</html>
