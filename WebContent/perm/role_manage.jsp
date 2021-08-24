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
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css" href="css/maintable.css" ></link>
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.8.0.js"></script>
<script type="text/javascript">
		$(function(){
			if("${msg}"!=''){
				alert("${msg}");
			}
			
			$("table tr").mouseover(function(){
				$(this).css("background","#D3EAEF");
				$(this).siblings().css("background","white");
			});
		});
</script>
</head>
<body>
<div class ="div_title">
<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>用户角色基本信息列表</span></div>
</div>
<table class="main_table" >
       <tr>
 			<th>角色名称</th> 	<th>角色描述</th>	<th>操作</th>
 		</tr>
	 <c:forEach var="role" items="${list }">
		<tr>
			<td>${role.roleName }</td>
			
			<td>${role.des }</td>
			<td>
			    <a href="RoleServlet.do?flag=select&id=${role.id }">修改</a> |
			    <a href="RoleServlet.do?flag=del&id=${role.id }">删除</a> |
			    <a href="RoleServlet.do?flag=grand&id=${role.id }">权限分配</a> 
			</td>
		</tr>
	</c:forEach>
 	
</table>
</body>
</html>