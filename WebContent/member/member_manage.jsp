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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.0.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/My97DatePicker/WdatePicker.js"></script>
<script>
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
	$("#find").click(function(){
		document.form1.submit();
	});
});
function ZhuanDao(val){
	reg = /^[0-9]+$/
		if(val>${page.pageCount }||val<1){
			alert("意外的页数！");
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
				url:"MemberServlet.do",
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
<title>Insert title here</title>
</head>
<body>
<div class ="div_title">
<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>会员列表</span></div>
<div class="div_titleoper">
	<input type="checkbox" id="top_ch_checkall"/> 全选 <a href="goods/goods_add.jsp"> <img src="images/add.gif"/>添加 </a> <a href="javascript:void(0)"  onclick="delMore()"><img src="images/del.gif"/>删除</a> </div>
 </div>

 <form action="MemberServlet.do"  name="form1">
  <div style="padding:5px 25px;margin:5px;background-color:#d3eaef">
 
会员账号:<input type="text" class="txtbox" id="findMemberNo" name="findMemberNo" value="${param.findMemberNo }"/> 
注册日期从: <input type="text"
				name="beginDate" onclick="WdatePicker()" value="${param.beginDate}" />
			到: <input type="text" name="endDate" onclick="WdatePicker()"
				value="${param.endDate}" />
<button id="find">查询</button>
 </div>
 <input type="hidden" id="flag" name="flag" value="manage">
<input type="hidden" id="p" name="pageIndex" value=1 />
 <table class="main_table" >
       <tr>
 				<th><input type="checkbox" id="ch_checkall" /></th>	<th>账号</th> 	<th>姓名</th>	<th>电话</th>  <th>邮箱</th> <th>注册日期</th> <th>会员等级</th>	<th>操作</th>
 		</tr>
	 <c:forEach var="member" items="${list }">
		<tr>
			<td><input type="checkbox" name="ck_id" value="${member.id }"></td>
			<td>${member.memberNo }</td>
			<td>${member.memberName }</td>
			<td>${member.phone }</td>
			<td>${member.email }</td>
			<td>${member.registerDate }</td>
			<td>${member.memberLevel }</td>
			<td>
				
				<a href="MemberServlet.do?flag=select&id=${member.id }">查看</a> |  
			    <a href="MemberServlet.do?flag=del&id=${member.id }&pageIndex=${page.pageIndex }" onclick="return confirm('确定要删除吗')">删除</a> 
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