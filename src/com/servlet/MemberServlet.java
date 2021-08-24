package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.MemberInfo;
import com.beans.PageInfo;
import com.dao.MemberDao;
import com.utils.PageUtil;
import com.utils.Utils;


@WebServlet("/MemberServlet.do")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opt = request.getParameter("flag");
		if("manage".equals(opt)) {
			manage(request, response);
		}
		else if("del".equals(opt)) {
			meberDel(request, response);
		}
		else if("delMore".equals(opt)) {
			meberDelMore(request, response);
		}
		else if("select".equals(opt)) {
			meberSelect(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	private void meberSelect(HttpServletRequest request, HttpServletResponse response) throws NumberFormatException, ServletException, IOException {
		MemberDao memberdao=new MemberDao();
		int id = Integer.valueOf(request.getParameter("id"));
		MemberInfo member = memberdao.getMemberById(id);
		request.setAttribute("member", member);
		request.getRequestDispatcher("/member/member_show.jsp").forward(request, response);
		
		
	}

	private void meberDelMore(HttpServletRequest request, HttpServletResponse response) throws IOException {
		MemberDao memberdao=new MemberDao();
		String[] ids = request.getParameterValues("ids");
		for(String id:ids) {
			int mid = Integer.valueOf(id);
			memberdao.memberDel(mid);
		}
		response.getWriter().print("É¾³ý³É¹¦");
	}

	private void meberDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDao memberdao=new MemberDao();
		int id = Integer.valueOf(request.getParameter("id"));
		int result = memberdao.memberDel(id);
		if(result == 1) {
			request.setAttribute("msg", "É¾³ý³É¹¦");
			
		}
		else {
			request.setAttribute("msg", "É¾³ýÊ§°Ü");
		}
		manage(request, response);
	}

	private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		MemberDao memberdao=new MemberDao();
		String findMemberNo = request.getParameter("findMemberNo");
		String startTimeStr = request.getParameter("startTime");
		String endTimeStr = request.getParameter("endTime");
		String startTime = null;
		String endTime = null;
		if(!Utils.StrIsNullOrEmpty(startTimeStr)) {
			startTime = startTimeStr.split("\\.")[0];
			
		}
		if(!Utils.StrIsNullOrEmpty(endTimeStr)) {
			endTime= endTimeStr.split("\\.")[0];
		}
		int pageSize = 5;
		int rowCount = memberdao.getAllMemberCount(findMemberNo, startTime, endTime);
		int pageIndex = 1;
		String indexStr = request.getParameter("pageIndex");
		
		if(indexStr != null) {
			pageIndex = Integer.valueOf(indexStr);
		}
		PageInfo page = PageUtil.getPageInfo(pageSize, rowCount, pageIndex);
	
		List<MemberInfo> list = memberdao.getAllMember(findMemberNo,startTime,endTime,page);

		request.setAttribute("list", list);
		request.setAttribute("page", page);
		request.getRequestDispatcher("/member/member_manage.jsp").forward(request, response);
		
	}
}
