package com.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.beans.AdminInfo;

/**
 * Servlet Filter implementation class TextFilter
 */
@WebFilter("/TextFilter")
public class TextFilter implements Filter{
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest)req;	
		HttpSession session =request.getSession();
		String uri=request.getRequestURI();
		String contextPath=request.getContextPath();

		if(uri.contains("login.html") || uri.equals(contextPath+"/") ) {
			chain.doFilter(req,resp);
		}
		else {
			AdminInfo admin=(AdminInfo)session.getAttribute("session_admin");	
			//用户没有登录
			if(admin==null) {
				resp.getWriter().print("<script>window.top.location.href='login.html'</script>");
			}
			else {
				chain.doFilter(req,resp);
			}
		}
		
	}
}