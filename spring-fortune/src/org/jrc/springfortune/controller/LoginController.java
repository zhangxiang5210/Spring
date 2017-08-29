package org.jrc.springfortune.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jrc.springfortune.constants.SpringFortuneConstans;
import org.jrc.springfortune.entity.LoginUser;
import org.jrc.springfortune.entity.SessionUser;
import org.jrc.springfortune.service.ILoginUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController  extends BaseController
{
	@Autowired
	private ILoginUserService loginUserService;
	
	@RequestMapping("/login.htm")
	public String loginHandler(HttpServletRequest request, HttpServletResponse response, ModelMap model) 
	{
		String action = getParameter(request, "action");
		if("do".equals(action))
		{
			Map<String, Object> param = new HashMap<String, Object>();
			LoginUser user = new LoginUser();
			user.setLoginName("zhangxiang");
			
			String username = getParameter(request, "username");
			String password = getParameter(request, "password");
			
			param.put("loginName", username);
			param.put("password", password);
			
			user.setPhone(username);
			user.setPassword(password);
			
			try {
				loginUserService.insert(user);
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			//写入session
			SessionUser sessionUser = new SessionUser();
			sessionUser.setUser(user);
			setSessionObject(request, SpringFortuneConstans.SESSION_USER_KEY, sessionUser);
			return "redirect:main.htm";
		}
		
		
		
		return "user/login";
	}
	
	
	
	@RequestMapping("main.htm")
	public String main(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		
		return "main";
	}
}
