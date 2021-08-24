<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css" href="css/maintable.css" ></link>
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.8.0.js"></script>
<script type="text/javascript">
		$(function(){
			if("${msg}"!=''){
				alert("${msg}");
			}
			
			$("table tr").mouseover(function(){
				$(this).css("background","#D3EAEF");
				$(this).siblings().css("background","white");
			});
			
		});
		function del(){
			return confirm("此操作将删除当前一级分类及其包含的全部二级分类，是否继续？");
		}
</script>
</head>
<body>
<div class ="div_title">
<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>商品维护分类管理</span></div>
</div>
<table class="main_table" >
       <tr>
 			<th colspan="2">一级分类</th> 	<th colspan="2">二级分类</th>
 		</tr>
 		<c:forEach var="bigcate" items="${list }">
			<tr>
				<td>
					${bigcate.cateName }
				</td>
				<td>
					<a href="CateServlet.do?flag=select&id=${bigcate.id }">修改</a> |
			    	<a onclick="return del()" href="CateServlet.do?flag=del&id=${bigcate.id }">删除</a>
				</td>
				<td>
				<c:forEach var="smallcate" items="${bigcate.subCateList }">
					${smallcate.cateName }<br>
				</c:forEach>
				</td>
				<td>
				<c:forEach var="smallcate" items="${bigcate.subCateList }">
					<a href="CateServlet.do?flag=select&id=${smallcate.id }">修改</a> |
			    	<a href="CateServlet.do?flag=del&id=${smallcate.id }">删除</a><br>
				</c:forEach>
					
				</td>
				
			</tr>
		</c:forEach>
	 
 	
</table>
</body>
</html>