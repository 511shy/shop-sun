<%@ page language="java" import="java.util.*,com.beans.*,com.dao.*"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
	<title>导航</title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<link rel="stylesheet" type="text/css" href="css/menu.css"></link>
	<script type="text/javascript" src="js/jquery-1.8.0.js"></script>
	<script type="text/javascript" src="js/jquery.easing.js"></script>
	<script type="text/javascript" src="js/jquery.accordion.js"></script>
		<script type="text/javascript">
			$(function(){
				$('#navigation').accordion(
				{
					active:3,   /* 第二个被激活 */
					header: '.head',
					/*navigation1: false,  */
					event: 'click',
					fillSpace: true,
					animated: 'bounceslide'   /*slide,bounceslide ,bounceslide,easeslide'*/
				}
				
				);
			});
		</script>	
	</head>
	<body>
		<%
	       //从session中得到当前用户的角色信息
	        AdminInfo admin=(AdminInfo)session.getAttribute("session_admin");
	   	 	int roleId=admin.getRoleId();
			MenuDao dao=new MenuDao();
			List<MenuInfo> menuList=dao.getMenuList(0,roleId);  //查询的时候,要把当前用户的角色传过去
			pageContext.setAttribute("menuList", menuList);
		 %>
	
		<ul id="navigation">
			<c:forEach var="m" items="${menuList }">
				<li><a class="head">${m.menuName }</a>
					<ul>
						<li><c:forEach var="m_sub" items="${m.subMenuList }">
								<a target="${m_sub.target }" href="${m_sub.url }"> 
									<img src="images/${m_sub.icon }" /><label> ${m_sub.menuName}</label></a>
							</c:forEach></li>
					</ul>
			   </li>
			</c:forEach>
	
			<li><a class="head">网站前台</a>
				<ul>
					<li><a href="http://localhost:8080/shop-web" target="_blank"><img
							src="images/main_50.gif" /><label>网站前台</label></a></li>
				</ul>
			</li>
		</ul>
	</body>
</html>
