<%@ page language="java" import="com.beans.*,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<title>用户维护</title>
<script type="text/javascript" src="js/jquery-1.8.0.js"></script> 
	<script type="text/javascript">
		$(function(){
			if("${msg}"!=''){
				alert("${msg}");
			}
			
			$("#ch_checkall,#top_ch_checkall").click(function(){
				if(this.checked){
					$("input[name=ck_id]").attr("checked","checked");
				}else{
					$("input[name=ck_id]").removeAttr("checked");
				}		
			});
					
			$("table tr").mouseover(function(){
				$(this).css("background","#D3EAEF");
				$(this).siblings().css("background","white");
			});
		});
		function ZhuanDao(val){
			var reg = /^[0-9]+$/
			if(val>${page.pageCount }||val<1){
				alert("输入错误");
				return false;
			} 
			else if(!reg.test(val)){
				alert("必须输入数字！");
				return false;
			}
			else{
				$("#p").val(val);
				$("form").submit();
			}
		} 
		function delMore(){
			var sele=$(":checkbox:checked");
			var ids = [];
			if(sele.length>0){
				sele.each(function(){
					ids.push($(this).val());
				})
				if(confirm("确定要删除这"+sele.length+"项数据吗？")){
					$.ajax({
						url:"AdminServlet.do",
						type:"post",
						traditional: true,
						data:{ids:ids,flag:"delMore"},
						success:function(data){
							
							alert(data);
							$("input[name=ck_id]").removeAttr("checked");
							window.location.reload();
						 }
						
					});
					
				}
				
			}
			else{
				alert("至少选择一项！");
			}
		}
	</script>

	<link rel="stylesheet" type="text/css" href="css/maintable.css" ></link>
</head>
<body>
<div class ="div_title">
<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理人员基本信息列表</span></div>
<div class="div_titleoper">
	<input type="checkbox" id="top_ch_checkall"/> 全选 <a href="admin/admin_add.jsp"> <img src="images/add.gif"/>添加 </a> <a href="javascript:void(0)"  onclick="delMore()"><img src="images/del.gif"/>删除</a> </div>
 </div>
 
 <form action="AdminServlet.do"  name="form1">
 <input type="hidden" name="flag" value="manage">
<input type="hidden" id="p" name="pageIndex" value=1 />
 <table class="main_table" >
       <tr>
 				<th><input type="checkbox" id="ch_checkall" /></th>	<th>账号</th> 	<th>状态</th>	<th>备注</th>  <th>最后更新日期</th> 	<th>操作</th>
 		</tr>
	 <c:forEach var="admin" items="${list }">
		<tr>
			<td><input type="checkbox" name="ck_id" value="${admin.id }"></td>
			<td>${admin.adminName }</td>
			<td>
				<c:choose>
					<c:when test="${admin.state==2}">已锁定</c:when>
					<c:when test="${admin.state==1}"></c:when>	
				</c:choose>
			</td>
			<td title="${admin.note }">
					
					<c:choose>
					<c:when test="${admin.note.length()>5 }">${admin.note.substring(0,4) }...</c:when>
					<c:when test="${admin.note.length()<=5 }">${admin.note }</c:when>	
				</c:choose>
			</td>
			<td>${admin.editDate }</td>
			<td>
				<c:if test="${admin.state=='2'}">
					<a href="AdminServlet.do?flag=lockoff&pageIndex=${page.pageIndex }&id=${admin.id }">解除锁定</a> |
				</c:if>
				<c:if test="${admin.state=='1'}">
					<a href="AdminServlet.do?flag=lockon&pageIndex=${page.pageIndex }&id=${admin.id }">锁定</a> |  
					<a href="AdminServlet.do?flag=select&id=${admin.id }">修改</a> | 
				</c:if>
		 		
			    <a href="AdminServlet.do?flag=del&id=${admin.id }&pageIndex=${page.pageIndex }">删除</a> 
			</td>
		</tr>
	</c:forEach>
 	
</table>
</form>

<div class="div_page" >
	  <div class="div_page_left">    共${page.rowCount }条数据，当前第${page.pageIndex }页，共${page.pageCount }页</div>		
	  <div class="div_page_right" > 	 
	<c:choose>
		<c:when test="${page.hasBefore }">
			<button onclick="ZhuanDao(1)">首页</button>
			<button onclick="ZhuanDao(${page.pageIndex-1})">上一页</button>
		</c:when>
		<c:otherwise>
			首页&nbsp;&nbsp;
			上一页&nbsp;&nbsp;
		</c:otherwise>
	</c:choose>

<c:choose>
	<c:when test="${page.hasNext }">
		<button onclick="ZhuanDao(${page.pageIndex+1})">下一页</button>
		<button onclick="ZhuanDao(${page.pageCount})">尾页</button>
	</c:when>
	<c:otherwise>
		下一页&nbsp;&nbsp;
		尾页&nbsp;&nbsp;
	</c:otherwise>
</c:choose>
<button onclick="return ZhuanDao( $('#pageIndex').val())"   > 转到</button> 第 <input id="pageIndex" size="2"> 页

	   </div>
		
</div>

  </body>
</html>