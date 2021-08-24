package com.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.beans.GoodsInfo;
import com.beans.PageInfo;
import com.dao.GoodsDao;
import com.utils.PageUtil;
import com.utils.Utils;


@WebServlet("/GoodsServlet.do")
public class GoodsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public GoodsServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opt = request.getParameter("flag");
		if("cnki".equals(opt)) {
			selectByName(request,response);
		}
		else if("goodsAdd".equals(opt)) {
			goodsAdd(request,response);
		}
		else if("manage".equals(opt)) {
			manage(request,response);
		}
		else if("picture".equals(opt)) {
			int id=Integer.valueOf(request.getParameter("id"));
			picture(request,response,id);
		}
		else if("select".equals(opt)) {
			selectById(request,response);
		}
		else if("goodsRes".equals(opt)) {
			goodsRes(request,response);
		}
		else if("del".equals(opt)) {
			goodsDel(request,response);
		}
		else if("delMore".equals(opt)) {
			goodsDelMore(request,response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	private void goodsDelMore(HttpServletRequest request, HttpServletResponse response) throws IOException {
		GoodsDao goodsdao=new GoodsDao();
		String[] ids = request.getParameterValues("ids");
		for(String id:ids) {
			int gid = Integer.valueOf(id);
			goodsdao.goodsDel(gid);
		}
		response.getWriter().print("删除成功");
		
	}


	private void goodsDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GoodsDao goodsdao=new GoodsDao();
		int id = Integer.valueOf(request.getParameter("id"));
		int result = goodsdao.goodsDel(id);
		if(result == 1) {
			request.setAttribute("msg", "删除成功");
			
		}
		else {
			request.setAttribute("msg", "删除失败");
		}
		manage(request,response);
	}


	private void goodsRes(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		GoodsDao goodsdao=new GoodsDao();
		int id = Integer.valueOf(request.getParameter("id"));
		String goodName = request.getParameter("goodName");
		int bigId = Integer.valueOf(request.getParameter("bigId"));
		int smallId = Integer.valueOf(request.getParameter("smallId"));
		String unit = request.getParameter("unit");
		float price = Float.valueOf(request.getParameter("price"));
		String des = request.getParameter("des");
		String producter = request.getParameter("producter");
		Part picture = request.getPart("picture");
		InputStream in = picture.getInputStream();
		byte[] pictureData = new byte[in.available()];
		in.read(pictureData);
		GoodsInfo goods = new GoodsInfo(goodName, bigId, smallId, price, des, unit, producter, pictureData);
		goods.setId(id);
		int result = goodsdao.goodsRes(goods);
		request.setAttribute("goods", goods);
		if(result == 1) {
			request.setAttribute("msg", "修改成功");
			request.setAttribute("pdata", pictureData);
			request.getRequestDispatcher("/goods/goods_res.jsp").forward(request, response);
			
		}
	}


	private void selectById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GoodsDao goodsdao=new GoodsDao();
		int id = Integer.valueOf(request.getParameter("id"));
		GoodsInfo goods = goodsdao.getGoodsById(id);
		request.setAttribute("goods", goods);
		request.getRequestDispatcher("/goods/goods_res.jsp").forward(request, response);
	}


	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GoodsDao goodsdao=new GoodsDao();
		String findGoodName = request.getParameter("findGoodName");
		String bigIdStr = request.getParameter("bigId");
		String smallIdStr = request.getParameter("smallId");
		int bigId = -1;
		int smallId = -1;
		if(!Utils.StrIsNullOrEmpty(bigIdStr)) {
			bigId = Integer.valueOf(bigIdStr);
		}
		if(!Utils.StrIsNullOrEmpty(smallIdStr)) {
			smallId = Integer.valueOf(smallIdStr);
		}
		int pageSize = 5;
		int rowCount = goodsdao.getGoodsByConditionCount(findGoodName, bigId, smallId);
		int pageIndex = 1;
		
		String indexStr = request.getParameter("pageIndex");
		
		if(indexStr != null) {
			pageIndex = Integer.valueOf(indexStr);
		}
		PageInfo page = PageUtil.getPageInfo(pageSize, rowCount, pageIndex);
	
		List<GoodsInfo> list = goodsdao.getGoodsByCondition(findGoodName,bigId,smallId,page);
		
		request.setAttribute("list", list);
		request.setAttribute("page", page);
		
		request.getRequestDispatcher("/goods/goods_manage.jsp").forward(request, response);
	}


	private void goodsAdd(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		GoodsDao goodsdao=new GoodsDao();
		String goodName = request.getParameter("goodName");
		int bigId = Integer.valueOf(request.getParameter("bigId"));
		int smallId = Integer.valueOf(request.getParameter("smallId"));
		String unit = request.getParameter("unit");
		float price = Float.valueOf(request.getParameter("price"));
		String des = request.getParameter("des");
		String producter = request.getParameter("producter");
		Part picture = request.getPart("picture");
		InputStream in = picture.getInputStream();
		byte[] pictureData = new byte[in.available()];
		in.read(pictureData);
		GoodsInfo goods = new GoodsInfo(goodName, bigId, smallId, price, des, unit, producter, pictureData);
		int result = goodsdao.goodsAdd(goods);
		if(result == 1) {
			request.setAttribute("msg", "添加成功");
			request.setAttribute("pdata", pictureData);
			request.getRequestDispatcher("/goods/goods_add.jsp").forward(request, response);
			
		}
	}
	//测试
	private void picture(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
		GoodsDao goodsdao=new GoodsDao();
		GoodsInfo goods = goodsdao.getGoodsById(id);
		byte[] in = goods.getPictureData();
		OutputStream out=response.getOutputStream();
		out.write(in,0,in.length);
		out.flush();
		out.close();
	}

	private void selectByName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		GoodsDao goodsdao=new GoodsDao();
		String goodName = request.getParameter("goodName");
		String startName = request.getParameter("startName");
		GoodsInfo goods = goodsdao.getGoodsByName(goodName);
		if(goods!=null&&!goodName.equals(startName)) {
			response.getWriter().print("商品名已存在！");
		}
		else {
			String regex="\\S{2,20}"; 
			if(goodName.matches(regex)) {
				response.getWriter().print("√");
				}
			else {
				response.getWriter().print("商品名格式非法！");
			}
		}
	}

}

