<%@ page language="java" import="com.beans.CateInfo,com.dao.CateDao,java.util.List" contentType="text/html; charset=UTF-8"
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
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.8.0.js"></script> 
<script>
$(function(){
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
	if($("#bigId").val()!=-1){
		var pid=$("#bigId").val();
		$("#smallId").empty();
		 $.ajax({
				url:"CateServlet.do",
				type:"post",
				dataType:'json',
				data:{pid:pid,flag:"selectSmallCate"},
				success:function(data){
					$.each(data,function(index,obj){
						var str = null;
						var id = obj.id;
						var cateName = obj.cateName;
						if(id == "${param.smallId}"){
							str="<option value="+id+" selected>"+cateName+"</option>"
						}
						else{
							str="<option value="+id+">"+cateName+"</option>"
						}
						$("#smallId").append(str);
					});
				 },
			});
	}
	$("#bigId").change(function(){
		 $("#smallId").empty();
		 var pid=this.value;
		 if(pid==-1){
			$("#smallId").append("<option value='-1'>请选择</option>");
		 }
		 else{
			 $.ajax({
					url:"CateServlet.do",
					type:"post",
					dataType:'json',
					data:{pid:pid,flag:"selectSmallCate"},
					success:function(data){
						$.each(data,function(index,obj){
							var id = obj.id;
							var cateName = obj.cateName;
							var str="<option value="+id+">"+cateName+"</option>"
							$("#smallId").append(str);
						});
					 },
				});
			 
		 }
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
				url:"GoodsServlet.do",
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
<%
	CateDao catedao = new CateDao();
	List<CateInfo> clist = catedao.getCateInfoByParentID(0);
	
	request.setAttribute("clist", clist);
%>
<div class ="div_title">
<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>商品列表</span></div>
<div class="div_titleoper">
	<input type="checkbox" id="top_ch_checkall"/> 全选 <a href="goods/goods_add.jsp"> <img src="images/add.gif"/>添加 </a> <a href="javascript:void(0)"  onclick="delMore()"><img src="images/del.gif"/>删除</a> </div>
 </div>

 <form action="GoodsServlet.do"  name="form1">
  <div style="padding:5px 25px;margin:5px;background-color:#d3eaef">
 <select name="bigId" id="bigId">
	<option value="-1">请选择</option>
	<c:forEach var="l" items="${clist }">
		<c:choose>
		<c:when test="${l.id==param.bigId }">
		<option value="${l.id }" selected>${l.cateName }</option>
	</c:when>
	<c:otherwise>
		<option value="${l.id }">${l.cateName }</option>
	</c:otherwise>
	</c:choose>
	</c:forEach>
</select>
<select name="smallId" id="smallId">
		<option value="-1">请选择</option>
</select>
商品名称:<input type="text" class="txtbox" id="findGoodName" name="findGoodName" value="${param.findGoodName }"/> 
<button id="find">查询</button>
 </div>
 <input type="hidden" id="flag" name="flag" value="manage">
<input type="hidden" id="p" name="pageIndex" value=1 />
 <table class="main_table" >
       <tr>
 				<th><input type="checkbox" id="ch_checkall" /></th>	<th>名称</th> 	<th>单位</th>	<th>单价</th>  <th>大分类</th> <th>小分类</th> 	<th>操作</th>
 		</tr>
	 <c:forEach var="goods" items="${list }">
		<tr>
			<td><input type="checkbox" name="ck_id" value="${goods.id }"></td>
			<td>${goods.goodsName }</td>
			<td>${goods.unit }</td>
			<td>${goods.price }</td>
			<td>${goods.bigCateName }</td>
			<td>${goods.smallCateName }</td>
			<td>
				
				<a href="#">查看</a> |  
				<a href="GoodsServlet.do?flag=select&id=${goods.id }">修改</a> | 
				
			    <a href="GoodsServlet.do?flag=del&id=${goods.id }&pageIndex=${page.pageIndex }" onclick="return confirm('确定要删除吗')">删除</a> 
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