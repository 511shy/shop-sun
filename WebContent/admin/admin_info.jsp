<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
  <head>    
    <title></title>   
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/edittable.css"  ></link>  
	<script type="text/javascript"  src="${pageContext.request.contextPath }/js/jquery-1.8.0.js"></script>

	<style>
	  		label{
	  			display:block;
	  			margin-top:4px;
	  			color:red;
	  		}
		
			.td_input{
				width:80%;
			}
	  	</style>
			
  </head>
  
  <body>
     <div class ="div_title">
		 <div class="div_titlename"> <img src="${pageContext.request.contextPath }/images/san_jiao.gif" ><span>当前用户信息</span></div>
	 </div>
				 
	 <form action="${pageContext.request.contextPath}/AdminServlet.do" method="post"  onsubmit="return validateInput()">
	 	<input type="hidden" name="flag" value="addAdmin" />
		 <table class="edit_table" >
		 		<tr>
		 			 	<td class="td_info">用户账号:</td>	
		 			 	<td class="td_input"> 
		 			 			<label   class="txtbox" >${admin.adminName }</label>
		 			 	</td>   
		 			 
		 		</tr>
		 			<tr>
		 				<td class="td_info">用户密码:</td>	
		 				<td>
		 					<label   class="txtbox" >*******</label>
		 				</td> 
		 			
		 		<tr>
		 			<td class="td_info">备注信息:</td>	
		 			<td>
		 				<label   class="txtbox" >${admin.note }</label>
		 			</td>
		 		
		 		</tr>
		 		
		 		<tr>
		 			<td class="td_info">最后更新日期:</td>	
		 			<td>
		 				<label   class="txtbox" >${admin.editDate }</label>
		 			</td>
		 		</tr>
		 		
		</table>
	
     </form>
  </body>
</html>
