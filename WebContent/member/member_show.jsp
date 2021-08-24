<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
<link rel="stylesheet" type="text/css" href="css/validate.css"  ></link>  
<script type="text/javascript"  src="js/jquery-1.8.0.js"></script>
<script>
$(function(){
	
	var ipstr = "${member.ip}";
	var ips = ipstr.split(",");
	for(var i = 0; i < ips.length; i++){
		var str = "<input type='text' class='txtbox' readonly value='"+ips[i]+"'/> <br>";
		$("#ip").append(str);
	};
	$("input[type=text],textarea").css("color","red");
});
</script>
</head>
<body>
<div class ="div_title">
<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>会员管理 会员信息</span></div>
</div>
<table class="edit_table" >
<tr>
 	<td class="td_info">会员账号:</td>	
 	<td class="td_input_short"> 
 		<input type="text" class="txtbox" readonly value="${member.memberNo }"/> 
 	</td>   
 	<td class="td_info">会员姓名:</td>	
 	<td class="td_input_short"> 
 		<input type="text" class="txtbox" readonly value="${member.memberName }"/> 
 	</td>
</tr>
<tr>
 	<td class="td_info">联系电话:</td>	
 	<td class="td_input_short"> 
 		<input type="text" class="txtbox" readonly value="${member.phone }"/> 
 	</td>   
 	<td class="td_info">电子邮箱:</td>	
 	<td class="td_input_short"> 
 		<input type="text" class="txtbox" readonly value="${member.email }"/> 
 	</td>
</tr>
<tr>
 	<td class="td_info">注册日期:</td>	
 	<td class="td_input_short"> 
 		<input type="text" class="txtbox" readonly value="${member.registerDate }"/> 
 	</td>   
 	<td class="td_info">身份证号:</td>	
 	<td class="td_input_short"> 
 		<input type="text" class="txtbox" readonly value="${member.idCard }"/> 
 	</td>
</tr>
<tr>
 	<td class="td_info">登录次数:</td>	
 	<td class="td_input_short"> 
 		<input type="text" class="txtbox" readonly value="${member.loginCounts }"/> 
 	</td>   
 	<td class="td_info">最后登录时间:</td>	
 	<td class="td_input_short"> 
 		<input type="text" class="txtbox" readonly value="${member.lastLoginDate }"/> 
 	</td>
</tr>
<tr>
 	<td class="td_info">会员常用ip:</td>	
 	<td class="td_input_short" id="ip"> 
 	
 	</td>   
 	<td class="td_info">会员等级:</td>	
 	<td class="td_input_short"> 
 		<input type="text" class="txtbox" readonly value="${member.memberLevel }"/> 
 	</td>
</tr>
<tr>
<td></td>
	<td><button class="form_btn" onclick="javascript:history.go(-1)">返回</button></td>
</tr>
</table>
</body>
</html>