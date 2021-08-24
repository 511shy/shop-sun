<%@ page language="java" import="java.util.*,com.dao.*,com.beans.*,com.utils.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
  <head>    
    <title>订单信息</title>   
	<link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
	<link rel="stylesheet" type="text/css" href="css/maintable.css"></link>
	
  	<style>
  		label{
  			display:block;
  			margin-top:4px;
  			color:red;
  		}
  		
  		.td_input{
  			width:230px;
  		}	
  	</style>
  	
	<script type="text/javascript" src="js/jquery-1.8.0.js"></script> 

  </head>
  
  <body>
  	   <div class="div_title">
		<div class="div_titlename">
			<img src="images/san_jiao.gif"><span>订单商品列表</span>
		</div>
	</div>
	
	<table class="main_table">
			<tr>	
				<th>商品名称</th>
				<th>单位</th>
				<th>单价</th>
				<th>购买数量</th>
			</tr>
			<c:forEach var="goods" items="${goodsList}">
				<tr>
				
					<td>${goods.goodsName }</td>
					<td>${goods.unit }</td>
					<td>${goods.price }</td>
					<td>${goods.saleCount }</td>
			
				</tr>
			</c:forEach>
	</table>
		
     <div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>订单详情列表</span></div>
	 </div>

     <input type="hidden" name="goodsId" value="${member.id}">
	 <table class="edit_table" >
	 		<tr>
	 			 	<td class="td_info">订单号</td>	
	 			 	<td class="td_input"> 
	 			 		<label class="txtbox" >${order.orderNo} </label> 
	 			 	</td>   
	 			 	<td class="td_info">邮费</td>	
	 				<td>
	 					<label class="txtbox" >${order.postage} </label> 
	 				</td> 	
	 		</tr>

	 		<tr>
	 				<td class="td_info">付款方式</td>	
	 				<td>
	 					<label class="txtbox" >${order.payMethod} </label> 
	 				</td>
	 				<td class="td_info">邮递方式</td>	
	 				<td><label class="txtbox" >${order.postMethod} </label>
	 			
	 		</tr>	
	 		
	 		<tr >
	 				<td class="td_info">下单日期</td>	
					<td><label class="txtbox" >${order.orderDate} </label> </td>
	 			    <td class="td_info">邮寄地址</td>	
					<td>
						<label class="txtbox" >${order.address} </label>
					</td>
	 		</tr>

	 		<tr >
	 				<td class="td_info">订单状态</td>	
					<td><label class="txtbox" >${order.orderState} </label></td>
	 			    <td class="td_info">发货日期</td>	
						<td><label class="txtbox" >${order.sendDate} </label> </td>
	 			    <td></td>
	 		</tr>
	 		
	 		<tr >
	 				<td class="td_info">订单金额</td>	
	 				<td id="td_ip"> <label class="txtbox" >${order.amount}</label> </td>
				
	 			    <td class="td_info">会员ID</td>
	 				<td><label class="txtbox" > <c:out value="${order.memberNo}" default="临时用户 非会员"></c:out> </label> </td>
	 		</tr>
	 	
	 		<tr>
	 			<td class="td_info"> </td>	
	 			<td> 
	 				<button class="form_btn" onclick="window.history.back()" >返回 </button>
	 			</td>	
	 			<td></td>
	 			<td></td>
	 		</tr>
	 </table>
  </body>
</html>




