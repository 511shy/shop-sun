<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	
	<link rel="stylesheet" type="text/css" href="css/login.css" ></link>
	<script type="text/javascript" src="js/jquery-1.8.0.js"></script>
	<script type="text/javascript">
		$(function(){
				$("#btn_img").click(function(){
					var aname=$("#adminName").val();
					var pwd=$("#password").val();
					
					if(aname==""){
						alert("用户名不能为空!");
						return;
					}
					if(pwd==""){
						alert("密码不能为空!");
						return;
					}
				
					$.ajax({
						url:"LoginServlet",
						type:"post",
						data:{adminName:aname,password:pwd,flag:"login"},
						success:function(data){
					
							if("0"==data){
								alert("用户名或密码错误! ");
							}
							else if("2"==data){
								alert("您的账号已被管理员锁定,不能进行登录 ");
							}
							else{
								//转向
								window.location.href="main.html";
							}
						}
						
					});
				});
		});
	</script>

  </head>
  
  <body>
	     <div id="div_center">
				<div id="div_inputbox">
					<input type="text" id="adminName"  />
					<input type="password" id="password" />
				</div>
				<input id="btn_img" type="image" src="images/bg_login_btn.jpg" />
	 	 </div>
  </body>
  
  <script> 
  	var loginflag='${param.loginflag}';
  	if(loginflag!=''){
  		alert("未登录或登录超时,请重新登录 !");
  	}
  	
  	
  </script>

</html>
