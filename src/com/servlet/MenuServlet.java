package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.MenuInfo;
import com.dao.MenuDao;

import net.sf.json.JSONArray;


@WebServlet("/MenuServlet.do")
public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public MenuServlet() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		System.out.println(request.getSession().getAttribute("session_admin"));
		int parentId=Integer.parseInt(request.getParameter("parentId"));
		List<MenuInfo> menuList =new MenuDao().getMenuList(parentId);
		JSONArray jsonObj=JSONArray.fromObject(menuList);
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print(jsonObj);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
