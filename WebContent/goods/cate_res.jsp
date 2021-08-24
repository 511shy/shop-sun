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
<script type="text/javascript"  src="js/jquery-1.8.0.js"></script>
<script>
$(function(){
	var b=true;
	 $("input[type=text],textarea").focus(function(){
		  $(this).addClass("input_focus");
		  
		}).blur(function(){
				$(this).removeClass("input_focus");
				
		});
	 $("#cateName").focus(function(){
			showInfo($(this).attr("id"),"2-20位；非空白字符");
		}).blur(function(){
			$.ajax({
				url:"CateServlet.do",
				type:"post",
				data:{cateName:$("#cateName").val(),startName:"${cate.cateName }",flag:"cnki"},
				success:function(data){
					if(data=="?") {
						b = true;
						showOk($("#cateName").attr("id"));
					}
					else{
						b=false;
						showError($("#cateName").attr("id"),data);
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
	$("#"+item+"_msg").html("?");
	$("#"+item+"_msg").className="ok";
}
</script>
</head>
<body>
<div class ="div_title">
	<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>商品管理 ${level }维护</span></div>
</div>
				 
	 <form action="CateServlet.do" method="post">
	 	<input type="hidden" name="flag" value="res">
	 	<input type="hidden" name="id" value="${cate.id }">
		 <table class="edit_table" >
		 		<c:if test="${cate.parentId!=0}">
		 			<tr>
		 			 	<td class="td_info">父级分类:</td>	
		 			 	<td class="td_input_short"> 
		 			 		<select name="parentId">
		 			 			<c:forEach var="bigcate" items="${list }">
		 			 				<c:if test="${bigcate.id==cate.parentId }">
										<option value="${bigcate.id }" selected>${bigcate.cateName }</option>
									</c:if>
									<c:if test="${bigcate.id!=cate.parentId }">
										<option value="${bigcate.id }">${bigcate.cateName }</option>
									</c:if>
		 			 			</c:forEach>
		 			 		</select>
		 			 	</td>   
		 			 	<td>
		 			 		<label class="validate_info" id="parentId_msg"></label>
		 			 	</td> 
		 			</tr>
		 		</c:if>
		 		<tr>
		 			 	<td class="td_info">分类名称:</td>	
		 			 	<td class="td_input_short"> 
		 			 		<input type="text" class="txtbox" id="cateName" name="cateName" value="${cate.cateName }"/> 
		 			 	</td>   
		 			 	<td>
		 			 		<label class="validate_info" id="cateName_msg"></label>
		 			 	</td> 
		 		</tr>
		 		
		 		<tr>
		 			<td class="td_info">分类描述:</td>	
		 			<td><textarea rows="4" cols="27" name="des" class="txtarea" >${cate.des }</textarea> </td>	
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