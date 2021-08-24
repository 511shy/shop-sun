<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
<link rel="stylesheet" type="text/css" href="css/validate.css"  ></link>  
<script type="text/javascript" src="js/jquery-1.8.0.js"></script>
<script>
	$(function(){
		$("#submit").click(function(){
			if($("input[name=roleId]:checked").val()){
				return confirm("确定要提交吗");
			}
			else{
				alert("请选择用户角色");
				return false;
			}
			
		});
	});
</script>
</head>
<body>
<form action="RoleServlet.do" method="post">
<input type="hidden" name="flag" value="res">
<input type="hidden" name="id" value="${admin.id }">
<table class="edit_table" >
<tr>
	 	<td class="td_info">用户账号:</td>	
	 	<td class="td_input_short"> 
	 		<input type="text" readonly class="txtbox" id="adminName" name="adminName" value="${admin.adminName }"/> 
	 	</td>   
	 	<td>
	 		<label class="validate_info" id="adminName_msg"></label>
	 	</td> 
</tr>
<tr>
	<td class="td_info">用户角色:</td>	
	<td>
		
		<c:forEach var="role" items="${roles }">
			
			<c:choose>
				<c:when test="${role.id==admin.roleId }">
					<input type="radio" name="roleId" checked="checked" value="${role.id }">${role.roleName }<br>
				</c:when>
				<c:otherwise>
					<input type="radio" name="roleId" value="${role.id }">${role.roleName }<br>
				</c:otherwise>
			</c:choose>
		
		</c:forEach>
	 </td>	
	<td><label></label></td>	
</tr>
<tr>
	<td class="td_info">${msg } </td>	
	<td> 
	<input class="form_btn" id="submit" type="submit" value="提交" /> 
	<input type="reset"  class="form_btn" value="重置" /> </td>	
	<td>
		<label id="result_msg" class="result_msg"></label>
	</td>	
</tr>
</table>
</form>
</body>
</html>