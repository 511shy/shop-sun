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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/maintable.css" ></link>

<script type="text/javascript" src="js/jquery-1.8.0.js"></script>
<script type="text/javascript">
		$(function(){
			$("table tr").mouseover(function(){
				$(this).css("background","#D3EAEF");
				$(this).siblings().css("background","white");
			});
		});
</script>
</head>
<body>
<div class ="div_title">
				<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理员基本信息列表</span></div>
		 </div>

		 <table class="main_table" >
		       <tr>
		 			<th>账号</th><th>状态</th><th>用户角色</th><th>最后更新日期</th><th>操作</th>
		 		</tr>
		 		<c:forEach var="admin" items="${list }">
		 		<tr>
		 				<td>${admin.adminName }</td>	
		 				<td>
			 				<c:choose>
			 					<c:when test="${admin.state==2}">已锁定</c:when>
			 					<c:when test="${admin.state==1}"></c:when>	
			 				</c:choose>
		 				</td>	
		 				<td>${admin.roleName }</td>	
		 				<td><fmt:formatDate value="${admin.editDate}"   pattern="yyyy-MM-dd - hh:mm" /></td>	
		 				<td>	
		 					<c:if test="${admin.state=='1' }">
		 						 <a href="${pageContext.request.contextPath }/perm/adminrole_edit.jsp?adminId=${admin.id}">角色分配</a> 
		 					</c:if>
		 				</td>
		 		</tr>
		   		 </c:forEach>
		 </table>
</body>
</html>