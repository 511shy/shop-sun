<%@ page language="java" import="java.util.*,com.dao.*,com.beans.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
  <head>    
    <title>用户角色管理</title>   
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/edittable.css"  ></link>  
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/validate.css"  ></link>  

	<script type="text/javascript"  src="${pageContext.request.contextPath }/js/jquery-1.8.0.js"></script>
	<script type="text/javascript"  src="${pageContext.request.contextPath }/js/validate.js"></script>
			<script>		
				$(function(){
					 $("input[type=text],textarea").focus(function(){
						  $(this).addClass("input_focus");
						}).blur(function(){
								$(this).removeClass("input_focus");
						});
	
					$(".form_btn").hover(function(){
							$(this).css("color","red").css("background","#6FB2DB");
						},
						
						function(){
							$(this).css("color","#295568").css("background","#BAD9E3");
						});
					
				});
					
				
			
				
				
				//总验证
				function validateInput(){
					$("#result_msg").html("");  //清除原来的验证信息
					var result=true;

					if(result==true){
						result=confirm('确定提交吗');
					}
					
					return result;
					
				}
				
				function back(){
					window.history.back();
					
				}
	  	</script>
  </head>
  
  <body>
  		<%
  			int adminId= Integer.parseInt(request.getParameter("adminId"));
  		  			AdminInfo adminInfo=new AdminDao().getAdminById(adminId);
  		  			request.setAttribute("adminInfo", adminInfo);
  		  			
  		  			List<RoleInfo> roleList=new RoleDao().getRoleList();
  		  			request.setAttribute("roleList", roleList);
  		%>
     <div class ="div_title">
		 <div class="div_titlename"> <img src="${pageContext.request.contextPath }/images/san_jiao.gif" ><span>管理员添加</span></div>
	 </div>
				 
	 <form action="${pageContext.request.contextPath}/RoleServlet.do" method="post"  onsubmit="return validateInput()">
	 	<input type="hidden" name="flag" value="updateadminrole" />
	 	<input type="hidden" name="adminId" value="${adminInfo.id }" />
		 <table class="edit_table" >
		 		<tr>
		 			 	<td class="td_info">用户账号:</td>	
		 			 	<td class="td_input_short"> 
		 			 		<input type="text" class="txtbox" id="adminName" name="adminName"  readonly="readonly" value="${adminInfo.adminName }"/> 
		 			 	</td>   
		 			 	<td>
		 			 		<label class="validate_info"></label>
		 			 	</td> 

		 		<tr>
		 			<td class="td_info">用户角色:</td>	
		 			<td>
		 				<c:forEach var="role" items="${roleList }">
		 				  <input 
		 				  	type="radio" 
		 				  	name="roleId"  
		 				  	value="${role.id }"  
		 				  	<c:if test="${adminInfo.roleId==role.id }">
		 				  		checked
		 				  	</c:if>
		 				  	/>  ${role.roleName }  <br />
		 				</c:forEach>
		 			</td>	
		 			<td></td>	
		 		</tr>
		 		<tr>
		 			<td class="td_info"> </td>	
		 			<td> 
		 			<input class="form_btn" type="submit" value="提交" /> 
		 			<button id="btnReset" class="form_btn"  onclick="back()">返回 </button></td>	
		 			<td>
		 				<label id="result_msg" class="result_msg">${msg}</label>
		 			</td>	
		 		</tr>
		</table>
	
     </form>
  </body>
</html>
