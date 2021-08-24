<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
  <head>    
    <title></title>   
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/edittable.css"  ></link>  
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/validate.css"  ></link>  
	<style>
		.td_input{
			width:210px;
		}
	 </style>
	<script type="text/javascript"  src="${pageContext.request.contextPath }/js/jquery-1.8.0.js"></script>
	<script type="text/javascript"  src="${pageContext.request.contextPath }/js/validate.js"></script>
			<script>		
				$(function(){
					 $("input[type=password]").focus(function(){
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
					
					 $(":reset").click(function(){
					 	$("label").html(""); //清空信息
					 	$("result_msg").html(""); //清空信息
					 });
				});
				

				//验证密码
				
				function validateOldPassword(item){
					var result=true;
					
					if(item.value==""){
						showError(item,"旧密码不能为空");
					}
					
					if(result==true){
						//showOk(item);  不用显示正确信息
					}
					
					return result;
				}
				
				function validatePassword(item){
				
					var result=true;
					var reg=/^\w{6,20}$/;   //6-20个合法字符
					
					if(!reg.test(item.value)){
						result=false;
						showError(item,"密码格式不正确");
					}
					
					if(result==true){
						showOk(item);
					}
					
					return result;
				}
				
				//验证重复密码
				function validatePwdConfirm(item){
					var result=true;
					
					if(item.value==''){
						result=false;
						showError(item,"重复密码不能为空");	
					}
					
					else if(item.value!=$("#password").val()){
						result=false;
						showError(item,"两次密码输入不一致! ");	
					}
					
					else if(item.value!=$("#password").val()){
						result=false;
						showError(item,"两次密码输入不一致! ");	
					}
					
					if(result==true){
						showOk(item);
					}
					
					return result;
				}
				
				//总验证
				function validateInput(){
					$("#result_msg").html("");  //清除原来的验证信息
					var result=true;
					
					if(validatePassword(document.getElementById("password"))==false){
						result=false;
					}
						
					if(validatePwdConfirm(document.getElementById("pwdconfirm"))==false){
						result=false;
					}
					
					if(result==true){
						result=confirm('确定提交吗');
					}
					
					return result;
					
				}
	  	</script>
  </head>
  
  <body>
     <div class ="div_title">
		 <div class="div_titlename"> <img src="${pageContext.request.contextPath }/images/san_jiao.gif" ><span>用户密码修改</span></div>
	 </div>
				 
	 <form action="${pageContext.request.contextPath}/AdminServlet.do" method="post"  onsubmit="return validateInput()">
	 	<input type="hidden" name="flag" value="updatePassword" />
		 <table class="edit_table" >
		 		<tr>
		 			 	<td class="td_info">用户账号:</td>	
		 			 	<td class="td_input"> 
		 			 		<input  type="text" readonly="readonly" class="txtbox"   value='${admin.adminName }' />
		 			 	</td>   
		 			 	<td>
		 			 	</td> 
		 		</tr>
		 			<tr>
		 				<td class="td_info">原来的密码:</td>	
		 				<td>
		 					<input type="password"  class="txtbox"   id="oldPassword" name="oldPassword" 
			 					onfocus="showInfo(this,'请输入原来的密码')" 
			 					onblur="validateOldPassword(this)" />
		 				</td> 
		 				<td><label  class="validate_info" id="oldPassword_msg" >请输入原来的密码</label></td>	
		 		  </tr>
		 		  <tr>
		 				<td class="td_info">新密码:</td>	
		 				<td>
		 					<input type="password"  class="txtbox"   id="password" name="password"
			 					onfocus="showInfo(this,'数字或英文,6-20位')" 
			 					onblur="validatePassword(this)" />
		 				</td> 
		 				<td><label  class="validate_info" id="password_msg" >数字或英文,6-20位</label></td>	
		 		  </tr>
		 		  
		 			<tr>
		 				<td class="td_info">重复密码:</td>	
		 				<td><input type="password" class="txtbox" id="pwdconfirm"  
		 					onfocus="showInfo(this,'请重复输入密码')" 
		 					onblur="validatePwdConfirm(this)" /> 
		 				</td>
		 				<td><label  class="validate_info"  id="pwdconfirm_msg">请重复输入密码</label></td>	
		 		</tr>

		 		<tr>
		 			<td class="td_info"> </td>	
		 			<td> 
		 			<input class="form_btn" type="submit" value="提交" /> 
		 			<input type="reset"  class="form_btn" value="重置" /> </td>	
		 			<td>
		 				<label id="result_msg" class="result_msg">${msg}</label>
		 			</td>	
		 		</tr>
		</table>
	
     </form>
  </body>
</html>
