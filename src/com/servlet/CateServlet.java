package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.CateInfo;
import com.dao.CateDao;

import net.sf.json.JSONArray;


@WebServlet("/CateServlet.do")
public class CateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opt = request.getParameter("flag");
		if("bigAdd".equals(opt)) {
			cateBigAdd(request, response);
		}
		else if("cnki".equals(opt)) {
			selectByName(request,response);
		}
		else if("smallAdd".equals(opt)) {
			cateSmallAdd(request,response);
		}
		else if("manage".equals(opt)) {
			manage(request,response);
		}
		else if("select".equals(opt)) {
			selectById(request,response);
		}
		else if("del".equals(opt)) {
			delById(request,response);
		}
		else if("res".equals(opt)) {
			res(request,response);
		}
		else if("selectSmallCate".equals(opt)) {
			selectSmallCate(request,response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	private void selectSmallCate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		CateDao catedao= new CateDao();
		int pid = Integer.valueOf(request.getParameter("pid"));
		List<CateInfo> list = catedao.getCateInfoByParentID(pid);
		
		JSONArray json = JSONArray.fromObject(list);
		response.getWriter().print(json);
	}
	private void res(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CateDao catedao= new CateDao();
		int id = Integer.valueOf(request.getParameter("id"));
		String cateName = request.getParameter("cateName");
		String des = request.getParameter("des");
		String strParentId =  request.getParameter("parentId");
		int parentId = 0;
		if(strParentId!=null) {
			parentId = Integer.valueOf(strParentId);
		}
		CateInfo cate = new CateInfo();
		cate.setCateName(cateName);
		cate.setDes(des);
		cate.setParentId(parentId);
		cate.setId(id);
		int result = catedao.cateRes(cate);
		request.setAttribute("cate", cate);
		if(cate.getParentId()==0) {
			request.setAttribute("level", "一级商品");
		}
		else {
			List<CateInfo> list = catedao.getCateInfoByParentID(0);
			request.setAttribute("list", list);
			request.setAttribute("level", "二级商品");
		}

		if(result == 1) {
			request.setAttribute("msg", "修改成功");
			request.getRequestDispatcher("/goods/cate_res.jsp").forward(request, response);
		}
		else {
			request.setAttribute("msg", "修改失败");
			request.getRequestDispatcher("/goods/cate_res.jsp").forward(request, response);
		}
	}


	private void delById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CateDao catedao= new CateDao();
		int id = Integer.valueOf(request.getParameter("id"));
		List<CateInfo> list = catedao.getCateInfoByParentID(id);
		for(CateInfo cate:list) {
			catedao.cateDel(cate.getId());
		}
		catedao.cateDel(id);
		manage(request,response);
		
	}


	private void selectById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CateDao catedao= new CateDao();
		int id = Integer.valueOf(request.getParameter("id"));
		CateInfo cate = catedao.getAdminById(id);
		if(cate.getParentId()==0) {
			request.setAttribute("level", "一级商品");
		}
		else {
			List<CateInfo> list = catedao.getCateInfoByParentID(0);
			request.setAttribute("list", list);
			request.setAttribute("level", "二级商品");
		}
		request.setAttribute("cate", cate);
		request.getRequestDispatcher("/goods/cate_res.jsp").forward(request, response);
	}


	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CateDao catedao= new CateDao();
		List<CateInfo> list = catedao.getCateInfoByParentID(0);
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("/goods/cate_manage.jsp").forward(request, response);
		
	}


	private void cateSmallAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CateDao catedao= new CateDao();
		String cateName = request.getParameter("cateName");
		String des = request.getParameter("des");
		int pid = Integer.valueOf(request.getParameter("pid"));
		CateInfo cate = new CateInfo();
		cate.setCateName(cateName);
		cate.setDes(des);
		cate.setParentId(pid);
		int result = catedao.cateAdd(cate);
		request.setAttribute("cate", cate);
		if(result == 1) {
			request.setAttribute("msg", "添加成功");
			request.getRequestDispatcher("/goods/smallcate_add.jsp").forward(request, response);
		}
		else {
			request.setAttribute("msg", "添加失败");
			request.getRequestDispatcher("/goods/smallcate_add.jsp").forward(request, response);
		}

		
	}


	private void selectByName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		CateDao catedao= new CateDao();
		String cateName = request.getParameter("cateName");
		String startName = request.getParameter("startName");
		CateInfo cates = catedao.getAdminByName(cateName);
		if(cates!=null&&!startName.equals(cateName)) {
			response.getWriter().print("分类名已存在！");
		}
		else {
			String regex="\\S{2,20}"; 
			if(cateName.matches(regex)) {
				response.getWriter().print("√");
				}
			else {
				response.getWriter().print("分类名格式非法！");
			}
		}
	}
	
	private void cateBigAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CateDao catedao= new CateDao();
		String cateName = request.getParameter("cateName");
		String des = request.getParameter("des");
		CateInfo cate = new CateInfo();
		cate.setCateName(cateName);
		cate.setDes(des);
		cate.setParentId(0);
		int result = catedao.cateAdd(cate);
		if(result == 1) {
			request.setAttribute("msg", "添加成功");
			request.getRequestDispatcher("/goods/bigcate_add.jsp").forward(request, response);
		}
		else {
			request.setAttribute("msg", "添加失败");
			request.getRequestDispatcher("/goods/bigcate_add.jsp").forward(request, response);
		}

		
	}

}
