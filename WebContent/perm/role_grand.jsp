<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/maintable.css" ></link>
<script type="text/javascript" src="js/jquery-1.8.0.js"></script> 
<script type="text/javascript">
$(function(){
	if("${msg}"!=''){
		alert("${msg}");
	}
	$("#top_ch_checkall").click(function(){
		if(this.checked){
			$("input[type=checkbox]").attr("checked","checked");
		}else{
			$("input[type=checkbox]").removeAttr("checked");
		}		
	});
	
	$(".t1 input[type=checkbox]").click(function(){
		if(this.checked){
			$(".t2 input[fid="+this.id+"]").attr("checked","checked");
		}else{
			
			$(".t2 input[fid="+this.id+"]").removeAttr("checked");
		}		
	});
	$(".t2 input[type=checkbox]").click(function(){
		var fid = this.getAttribute("fid");
		if(this.checked){
			$(".t1 input[id="+fid+"]").attr("checked","checked");
		}else{
			if(!$(".t2 input[fid="+fid+"]").is(":checked")){
				$(".t1 input[id="+fid+"]").removeAttr("checked");
			}
		}		
	});
});


</script>
</head>
<body>
<div class ="div_title">
<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>角色权限管理 当前角色：${roleName }</span></div>
<div class="div_titleoper">
	<input type="checkbox" id="top_ch_checkall"/> 全选 </div>
 </div>
 <form action="RoleServlet.do"  name="form1">
 <input type="hidden" name="flag" value="grandRes">
<input type="hidden" id="p" name="id" value="${id }" />
 <table class="main_table" >
 <tr>
	<th>一级菜单</th> 	<th>二级菜单</th>
 </tr>
 <c:forEach var="l" items="${list }">
	 <tr>
	 	<td class="t1">
	 	<c:if test="${grandlist.contains(l.id)==true }">
			<input type="checkbox" name="ids" value="${l.id }" checked id="${l.id }"/>${l.menuName }
		</c:if>
		<c:if test="${grandlist.contains(l.id)==false }">
			<input type="checkbox" name="ids" value="${l.id }" id="${l.id }"/>${l.menuName }
		</c:if>
	 	</td>
	 	<td class="t2">
	 		<c:forEach var="sl" items="${l.subMenuList }">
	 			<c:if test="${grandlist.contains(sl.id)==true }">
	 				<input type="checkbox" name="ids" value="${sl.id }" checked fid="${l.id }" id="${sl.id }"/>${sl.menuName }<br>
	 			</c:if>
				<c:if test="${grandlist.contains(sl.id)==false }">
					<input type="checkbox" name="ids" value="${sl.id }" fid="${l.id }" id="${sl.id }"/>${sl.menuName }<br>
				</c:if>
	 		</c:forEach>
	 	</td>
	 </tr>
 </c:forEach>
 </table>
	<input type="submit" value="保存修改">
 </form>
</body>
</html>