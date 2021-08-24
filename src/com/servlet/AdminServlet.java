package com.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.AdminInfo;
import com.beans.PageInfo;
import com.beans.RoleInfo;
import com.dao.AdminDao;
import com.utils.PageUtil;


@WebServlet("/AdminServlet.do")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		String flag = request.getParameter("flag");
		if("add".equals(flag)) {
			addadmin(request, response);
		}
		else if("ajax".equals(flag)) {
			selectbyname(request,response);
		}
		else if("manage".equals(flag)) {
			manage(request,response);
		}
		else if("lockon".equals(flag)) {
			lockon(request,response);
		}
		else if("del".equals(flag)) {
			deladmin(request,response);
		}
		else if("lockoff".equals(flag)) {
			lockoff(request,response);
		}
		else if("select".equals(flag)) {
			selectbyid(request,response);
		}
		else if("res".equals(flag)) {
			AdminRes(request,response);
		}
		else if("delMore".equals(flag)) {
			AdminDelMore(request,response);
		}
		else if("logOut".equals(flag)) {
			logOut(request,response);
		}
		if("date".equals(flag)) {
			date(request,response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	private void date(HttpServletRequest request, HttpServletResponse response) throws IOException {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd EEEE HH:mm:ss");//设置日期格式
		String date=df.format(new Date());// new Date()为获取当前系统时间
		response.getWriter().print(date);
	}
	protected void addadmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		AdminDao _adminDao=new AdminDao();
		//得到管理员相关的信息(按理说要有一个服务端验证,验证用户账号不能重复)
				String adminName=request.getParameter("adminName");
				String password=request.getParameter("password");
				String note=request.getParameter("note");
			    
				AdminInfo admin=new AdminInfo();
				admin.setAdminName(adminName);
				admin.setPassword(password);
				admin.setNote(note);
				admin.setState("1");  //用户默认的状态是可用
			//admin.setEditDate(editDate);  由于最后更新日期在数据库中是时间戳,所以不用传值
			//admin.setRoleId(0);  //默认情况下没有角色
				
				int result=_adminDao.addAdmin(admin);
				if(result==1) {
					request.setAttribute("msg", "用户添加成功");
					request.getRequestDispatcher("/admin/admin_add.jsp").forward(request, response);
				}else {
					request.setAttribute("msg", "用户添加失败");
					request.getRequestDispatcher("/admin/admin_add.jsp").forward(request, response);
				}
	}
	private void selectbyname(HttpServletRequest request, HttpServletResponse response) throws IOException {
		AdminDao admindao=new AdminDao();
		String adminName = request.getParameter("adminName");
		AdminInfo admin = admindao.getAdminByName(adminName);
		if(admin!=null) {
			response.getWriter().print("用户名已存在！");
		}
		else {
			String regex="^\\w{4,15}$"; 
			if(adminName.matches(regex)) {
				response.getWriter().print("√");
			}
			else {
				response.getWriter().print("用户名格式非法！");
			}
		}
	}
	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDao admindao=new AdminDao();
		int pageSize = 5;
		int rowCount = admindao.getAdminCount();
		int pageIndex = 1;
		String indexStr = request.getParameter("pageIndex");
		if(indexStr != null) {
			pageIndex = Integer.valueOf(indexStr);
		}
		PageInfo page = PageUtil.getPageInfo(pageSize, rowCount, pageIndex);
		List<AdminInfo> list = admindao.getAdminInfos(page);
		
		request.setAttribute("list", list);
		request.setAttribute("page", page);
		request.getRequestDispatcher("/admin/admin_manage.jsp").forward(request, response);
	}
	private void lockon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDao admindao=new AdminDao();
		int id = Integer.valueOf(request.getParameter("id"));
		AdminInfo now_admin = (AdminInfo)request.getSession().getAttribute("session_admin");
		if(id==now_admin.getId()) {
			request.setAttribute("msg", "不能锁定当前登录的用户");
			manage(request,response);
		}
		else {
			admindao.adminResState("2", id);
			manage(request,response);
		}	
	}
	private void lockoff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDao admindao=new AdminDao();
		int id = Integer.valueOf(request.getParameter("id"));
		admindao.adminResState("1", id);
		manage(request,response);
	}
	private void deladmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDao admindao=new AdminDao();
		int id = Integer.valueOf(request.getParameter("id"));
		AdminInfo now_admin = (AdminInfo)request.getSession().getAttribute("session_admin");
		if(id==now_admin.getId()) {
			request.setAttribute("msg", "不能删除当前登录的用户");
			manage(request,response);
		}
		else {
			admindao.adminResState("0", id);
			manage(request,response);
		}
	}
	private void selectbyid(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		AdminDao admindao=new AdminDao();
		int id = Integer.valueOf(request.getParameter("id"));
		AdminInfo admin = admindao.getAdminById(id);
		AdminInfo now_admin = (AdminInfo)request.getSession().getAttribute("session_admin");
		
		if(admin.getId()==now_admin.getId()) {
			System.out.println(now_admin);
			request.setAttribute("msg", "不能修改当前登录的用户");
			manage(request,response);
		}
		else {
			List<RoleInfo> roles = admindao.getAllRoleInfo();
			request.setAttribute("admin", admin);
			request.setAttribute("roles", roles);
			request.getRequestDispatcher("/admin/admin_res.jsp").forward(request, response);
		
		}
	}
	private void AdminRes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDao admindao=new AdminDao();
		int id = Integer.valueOf(request.getParameter("id"));
		String adminName = request.getParameter("adminName");
		String password = request.getParameter("password");
		String note = request.getParameter("note");
		int roleId = Integer.valueOf(request.getParameter("roleId"));
		System.out.println(roleId);
		AdminInfo admin = new AdminInfo();
		admin.setId(id);
		admin.setAdminName(adminName);
		admin.setPassword(password);
		admin.setNote(note);
		admin.setRoleId(roleId);
		int result = admindao.adminRes(admin);
		request.setAttribute("admin", admin);
		List<RoleInfo> roles = admindao.getAllRoleInfo();
		request.setAttribute("roles", roles);
		if(result == 1) {
			request.setAttribute("msg", "修改成功");
			request.getRequestDispatcher("/admin/admin_res.jsp").forward(request, response);
		}
		else {
			request.setAttribute("msg", "修改失败");
			request.getRequestDispatcher("/admin/admin_res.jsp").forward(request, response);
		}		
	}
	private void logOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().invalidate();
		response.sendRedirect("login.jsp");
	}

	private void AdminDelMore(HttpServletRequest request, HttpServletResponse response) throws IOException {
		AdminDao admindao=new AdminDao();
		String[] ids = request.getParameterValues("ids");
		for(String id:ids) {
			int aid = Integer.valueOf(id);
			admindao.adminResState("0", aid);
		}
		response.getWriter().print("删除成功");
		
	}
}
