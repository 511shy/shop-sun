package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.OrderInfo;
import com.beans.PageInfo;
import com.dao.OrderDao;
import com.utils.PageUtil;
import com.utils.Utils;


@WebServlet("/OrderServlet.do")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public OrderServlet() {
        super();
 
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opt = request.getParameter("flag");
		if("manage".equals(opt)) {
			manage(request, response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		OrderDao orderdao=new OrderDao();
		String findOrderNo = request.getParameter("findOrderNo");
		String startTimeStr = request.getParameter("startTime");
		String endTimeStr = request.getParameter("endTime");
		String findOrderStateStr = request.getParameter("findOrderState");
		String startTime = null;
		String endTime = null;
		int findOrderState = 0;
		if(!Utils.StrIsNullOrEmpty(startTimeStr)) {
			startTime = startTimeStr.split("\\.")[0];
			
		}
		if(!Utils.StrIsNullOrEmpty(endTimeStr)) {
			endTime= endTimeStr.split("\\.")[0];
		}
		if(!Utils.StrIsNullOrEmpty(findOrderStateStr)) {
			findOrderState = Integer.valueOf(findOrderStateStr);
		}
		int pageSize = 5;
		int rowCount = orderdao.getAllOrderCount(findOrderNo, startTime, endTime, findOrderState);
		int pageIndex = 1;
		String indexStr = request.getParameter("pageIndex");
		
		if(indexStr != null) {
			pageIndex = Integer.valueOf(indexStr);
		}
		PageInfo page = PageUtil.getPageInfo(pageSize, rowCount, pageIndex);
	
		List<OrderInfo> list = orderdao.getAllOrder(findOrderNo,startTime,endTime, findOrderState, page);

		request.setAttribute("list", list);
		for(OrderInfo l:list) {
			System.out.println(l);
		}
		request.setAttribute("page", page);
		request.getRequestDispatcher("/order/order_manage.jsp").forward(request, response);
		
	}

}
