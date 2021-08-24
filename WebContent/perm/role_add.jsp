<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
<link rel="stylesheet" type="text/css" href="css/validate.css"  ></link>  
<script type="text/javascript"  src="js/jquery-1.8.0.js"></script>
<script>
$(function(){
	var b=false;
	 $("input[type=text],textarea").focus(function(){
		  $(this).addClass("input_focus");
		  
		}).blur(function(){
				$(this).removeClass("input_focus");
				
		});
	 $("#roleName").focus(function(){
			showInfo($(this).attr("id"),"2-15位；非空白字符");
		}).blur(function(){
			$.ajax({
				url:"RoleServlet.do",
				type:"post",
				data:{roleName:$("#roleName").val(),flag:"cnki"},
				success:function(data){
					if(data=="OK") {
						b = true;
						showOk($("#roleName").attr("id"));
					}
					else{
						b[0]=false;
						showError($("#roleName").attr("id"),data);
					}
				 }
				
			});
		});
		$("#submit").click(function(){
			if(b){
				return confirm("验证通过,是否提交");
			}
			else{
				alert("存在错误 请检查");
				return false;
			}
			
		});
	
});
function showInfo(item,msg){
		$("#"+item+"_msg").html(msg);
		$("#"+item+"_msg").className="info";
}

function showError(item,msg){
	  $("#"+item+"_msg").html(msg);
	  $("#"+item+"_msg").className="error";
}

function showOk(item){
		$("#"+item+"_msg").html("OK");
		$("#"+item+"_msg").className="ok";
}


</script>
</head>
<body>
 <div class ="div_title">
	 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>角色添加</span></div>
 </div>
 <form action="RoleServlet.do" method="post">
	 	<input type="hidden" name="flag" value="add">
		 <table class="edit_table" >
		 		<tr>
		 			 	<td class="td_info">角色名称:</td>	
		 			 	<td class="td_input_short"> 
		 			 		<input type="text" class="txtbox" id="roleName" name="roleName" value="${param.roleName }"/> 
		 			 	</td>   
		 			 	<td>
		 			 		<label class="validate_info" id="roleName_msg"></label>
		 			 	</td> 
		 		</tr>
		 			<tr>
		 			<td class="td_info">角色描述:</td>	
		 			<td><textarea rows="4" style="resize: none;" cols="27" name="des" class="txtarea" >${param.des }</textarea> </td>	
		 			<td><label></label></td>	
		 				
		 		</tr>
		 			
		 		<tr>
		 			<td class="td_info">${msg } </td>	
		 			<td> 
		 			<input class="form_btn" id="submit"type="submit" value="提交" /> 
		 			<input type="reset"  class="form_btn" value="重置" /> </td>	
		 			<td>
		 				<label id="result_msg" class="result_msg"></label>
		 			</td>	
		 		</tr>
		</table>
     </form>
	 
</body>
</html>