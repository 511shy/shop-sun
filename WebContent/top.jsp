<%@ page language="java" import="java.text.*,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>"> 
    <title></title>  
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	
	<link rel="stylesheet" type="text/css" href="css/top.css" ></link>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.0.js"></script>
	<script type="text/javascript">
		setInterval("refreshPage()", 60*1000);  //每分钟
		
		//刷新时间,刷session 防止网页过期
		function refreshPage()
		{
			$.ajax({
				url:"LoginServlet",
				type:"post",
				data:{flag:"refresh"},
				cache:false,
				success:function(data){
					$("#div_date").html(data);
				}
			});
		}
		
		//用户注销,退出系统
		function logout(){
			if(confirm('确定要注销退出吗?')){
				$.post("${pageContext.request.contextPath}/LoginServlet",{flag:"logout"},function(){
					window.top.location.href="${pageContext.request.contextPath}/login.jsp";
				});
			}
		}
	</script>
  </head>

  <body>
      <table id="t_head">
		   		<tr>
		   			<td id="td1" ></td>
		   			<td id="td2">&nbsp;</td>
		   			<td id="td3">
		   				<a id="td3_a1"  target="centerFrame" href="${pageContext.request.contextPath }/admin/password_edit.jsp"><img src="images/btn_head_bg1.jpg"/>修改密码</a>
		   				<a  target="centerFrame" href="${pageContext.request.contextPath }/admin/admin_info.jsp"><img src="images/btn_head_bg1.jpg"/>用户信息</a>
		   				<a href="javascript:logout()"><img src="images/btn_head_bg1.jpg"/>退出系统</a>
		   			</td>
		
		   		</tr>
		   </table>
			<table id="t_bar" >
					<tr>
							<td id="bar_td1"></td>
							<td id="bar_td2">
								<div id="div_date"><%= new SimpleDateFormat("yyyy-MM-dd E hh:mm").format( new Date()) %></div>
							</td>
							
						<td id="bar_td3">
							 商城后台管理系统</td>
					
					</tr>
			</table>
			<table id="t_title">
					<tr>
							<td id="title_td1">
									<img src="images/main_28.gif"/>
							</td>	
							<td id="title_td2"><img src="images/main_29.gif" /></td>	
							<td id="title_td3"><img src="images/main_30.gif" /></td>	
							<td id="title_td4">&nbsp;
									<label class="admininfo">当前登录用户: ${admin.adminName } 用户状态  :  
									<c:if test="${admin.state=='1' }">正常</c:if>
									<c:if test="${admin.state=='0' }">删除</c:if> 
									<c:if test="${admin.state=='2' }">锁定</c:if>  
									
									<!--这里只是做个演示,实际上非正常状态的用户,是不能登录系统的  -->
								</label>
							</td>	
							<td id="title_td5"><img src="images/main_32.gif" /></td>
					</tr>
			</table>
  </body>
</html>
