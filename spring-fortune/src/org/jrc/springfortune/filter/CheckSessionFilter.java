package org.jrc.springfortune.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jrc.common.utils.Utils;
import org.jrc.springfortune.constants.SpringFortuneConstans;
import org.jrc.springfortune.entity.SessionUser;



public class CheckSessionFilter implements Filter {
	
	protected FilterConfig filterConfig = null;


	/**
	 * Take this filter out of service.
	 */
	public void destroy() {
		this.filterConfig = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
		FilterChain chain) throws IOException, ServletException {
		HttpServletRequest hsrq = (HttpServletRequest) request;
		HttpServletResponse hsrp = (HttpServletResponse) response;
		String reqPage = Utils.trim(hsrq.getServletPath());
		String baseUrl = Utils.trim(hsrq.getContextPath());
		
		if (reqPage.startsWith("/user")) 
		{
			SessionUser sessionUser =  (SessionUser) hsrq.getSession().getAttribute(SpringFortuneConstans.SESSION_USER_KEY);
			String path = baseUrl + "/login.htm";
			if (sessionUser == null) 
			{
				hsrp.sendRedirect(path);
				return;
			}
		}
		
		
		chain.doFilter(request, response);
	}
	
	

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

}
