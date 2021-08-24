<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
	<link rel="stylesheet" type="text/css" href="css/validate.css"  ></link>  
	<script type="text/javascript"  src="js/jquery-1.8.0.js"></script>
	<script>	
	$(function(){
	$.ajax({
		url:"AdminServlet.do",
		type:"post",
		data:{adminName:$("#adminName").val(),flag:"ajax"},
		success:function(data){
			
			if(data=="√") {
				b[0] = true;
				
				showOk($("#adminName").attr("id"));
				
			}
			else{
				b[0]=false;
				showError($("#adminName").attr("id"),data);
				
			}
		 }
		
	});
});
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
			function $(id){
 		 		return document.getElementById(id);
 		 }
 		 
 		 //这三个方法分别用来显示提示信息,错误信息,正确信息
	 	   function showInfo(item,msg){
	 	   		$(item.id+"_msg").innerHTML=msg;
	 	   		$(item.id+"_msg").className="info";
	 	   }
	 	   
	 	   function showError(item,msg){
	 	   	  $(item.id+"_msg").innerHTML=msg;
	 	   	  $(item.id+"_msg").className="error";
	 	   }
	 	   
	 	   function showOk(item){
	 	   		$(item.id+"_msg").innerHTML="√";
	 	   		$(item.id+"_msg").className="ok";
	 	   }
	 	  function validateUserName(item){
	 	   		var result=true;
	 	   		
	 	   		var reg=/^\w{4,15}$/;   //\w 可以是字母数字_  -不可以,$不可以,空格也不可以
	 	   		if(!reg.test(item.value)){
	 	   				result=false;
	 	   				showError(item,"用户名格式非法! ");
	 	   		} 
	 	   		else{
	 	   				showOk(item);
	 	   		}

	 	   		return result;
	 	   }
	 	
	 		 //验证密码
	 		 function validatePassword(item){
	 		 		var result=true;
	 	   		
	 	   		var reg=/^[a-zA-Z0-9]{6,20}$/;  
	 	   		if(!reg.test(item.value)){
	 	   				result=false;
	 	   				showError(item,"密码格式非法! ");
	 	   		} 
	 	   		else{
	 	   				showOk(item);
	 	   		}

	 	   		return result;
	 		 }
	 		 
	 		 //验证重复输入密码
	 		 function validateConfirm(item){
	 		 		var result=true;
	 		 		
	 		 		if(item.value==""){
	 		 			result=false;
	 		 			showError(item,"请输入重复密码!");
	 		 		}
	 		 		else{
	 		 			if(item.value!=$("password").value){
	 		 				result=false;
	 		 				showError(item,"两次输入的密码不一致");
	 		 			}
	 		 			else{
	 		 				showOk(item);
	 		 			}
	 		 		}

	 		 		return result;
	 		 }
	 		function validate(){
 		 		var result=true;
 		 		
 		 		//验证用户名
 		 		if(validateUserName($("username"))==false){
 		 				result=false;
 		 		}
 			
 		 		//验证密码
 		 		if(validatePassword($("password"))==false){
 		 				result=false;
 		 		}
 		 		
 		 		//验证重复密码
 		 		if(validateConfirm($("confrimpassword"))==false){
 		 				result=false;
 		 		}
 		 		if(result==true){
		 				return confirm("确定要提交吗");
 		 		}

				return result;
 		 }
	</script>
	<style type="text/css">
	.info{
			 				display:block;
			 				height:25px;
			 				font-size:12px;
			 				color:blue;
			 				font-weight:bold;
			 				line-height:25px;
			 				padding-left:10px;	
			 		}
			 		
			 		.ok{
			 				display:block;
			 				height:25px;
			 				font-size:12px;
			 				color:green;
			 				font-weight:bold;
			 				line-height:25px;
			 				padding-left:10px;	
			 		}
			 		
			 		.error{
			 				display:block;
			 				height:25px;
			 				font-size:12px;
			 				color:red;
			 				font-weight:bold;
			 				line-height:25px;
			 				padding-left:10px;	
			 		}
	</style>
  </head>

<body>
	<div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理员添加</span></div>
	 </div>
				 
	 <form action="AdminServlet.do" method="post">
		 <table class="edit_table" >
		 		<tr>
		 			 	<td class="td_info">用户账号:</td>	
		 			 	<td class="td_input_short"> 
		 			 		<input type="text" class="txtbox" id="adminName" name="adminName" onfocus="showInfo(this,'4-15位；只限数字(0-9)和英文(a-z),不区分大小写字')"  onblur="validateUserName(this)" /> 
		 			 	</td>   
		 			 	<td>
		 			 		<label class="validate_info" id="adminName_msg" ></label>
		 			 	</td> 
		 		</tr>
		 			<tr>
		 				<td class="td_info">用户密码:</td>	
		 				<td>
		 					<input type="text"  class="txtbox"  name="password"  id="password" onfocus="showInfo(this,'数字或英文,6-20位')" onblur="validatePassword(this)"/>
		 				</td> 
		 				<td><label  class="validate_info" id="password_msg" ></label></td>	
		 		</tr>
		 			<tr>
		 				<td class="td_info">重复密码:</td>	
		 				<td><input type="text" class="txtbox" id="pwdconfirm"  onfocus="showInfo(this,'请输入重复密码')" onblur="validateConfirm(this)"/> 
		 				</td>
		 				<td><label  class="validate_info"  id="pwdconfirm_msg"></label></td>	
		 		</tr>
		 		<tr>
		 			<td class="td_info">备注信息:</td>	
		 			<td><textarea rows="4" cols="27" name="note" class="txtarea"></textarea> </td>	
		 			<td><label></label></td>	
		 		</tr>
		 		<tr>
		 			<td class="td_info"> </td>	
		 			<td> 
		 			<input class="form_btn" type="submit" value="提交" id="form_btn" onclick="validate()"/> 
		 			<input type="reset"  class="form_btn" value="重置" /> </td>	
		 			<td>
		 				<label id="result_msg" class="result_msg">${msg }</label>
		 			</td>	
		 		</tr>
		</table>
     </form>
</body>
</html>