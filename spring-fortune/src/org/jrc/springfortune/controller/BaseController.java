package org.jrc.springfortune.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jrc.common.page.PageProperty;
import org.jrc.common.utils.Utils;
import org.jrc.springfortune.constants.SpringFortuneConstans;
import org.jrc.springfortune.entity.Annex;
import org.jrc.springfortune.entity.SessionUser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public abstract class BaseController extends MultiActionController {

	@Value(value="#{propertiesReader['annex_basepath_server']}")
	private String annexBasepath;
	
	
	protected final Log log = LogFactory.getLog(BaseController.class);
	
	protected String getParameter(HttpServletRequest request,String param){
		String value = Utils.trim(request.getParameter(param));
		return value;
	}
	
	protected String[] getParameters(HttpServletRequest request,String param){
		String[] values = request.getParameterValues(param);
		return values;
	}
	
	protected void setSessionObject(HttpServletRequest request,String key,Object obj){
		request.getSession().setAttribute(key, obj);
	}
	
	protected Object getSessionObject(HttpServletRequest request,String key){
		return request.getSession().getAttribute(key);
	}
	
	protected SessionUser getSessionUser(HttpServletRequest request)
	{
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(SpringFortuneConstans.SESSION_USER_KEY);
		if(sessionUser!=null)
		{
			return sessionUser;
		}else{
			return null;
		}
	}
	
	protected String getSessionUsername(HttpServletRequest request)
	{
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(SpringFortuneConstans.SESSION_USER_KEY);
		if(sessionUser!=null)
		{
			return sessionUser.getUser().getLoginName();
		}else{
			return null;
		}
	}


	
	
	protected void setBaseInfo(ModelMap model){
		model.put("annexBasepath", annexBasepath);
	}
	
	/**
	 * 设置分页对象基本信息
	 * @param req
	 * @param pp
	 */
	protected void setPageInfo(HttpServletRequest req,PageProperty pp){
		String pageNo = getParameter(req, "page");
		int pageNum = 1;
		int pageSizeNum = SpringFortuneConstans.PAGE_SIZE_DEFAULT; // 获取每页数据条数
		Cookie[] cooks=req.getCookies();
		if(cooks!=null&&cooks.length!=0){
			for(int i=0;i<cooks.length;i++){
				if(cooks[i].getName().equalsIgnoreCase("pageSize")){
					 pageSizeNum=Utils.parseInt(cooks[i].getValue().toString(), 20);
				}
			}
		}
		if (!"".equals(pageNo)) {
			pageNum = Utils.parseInt(pageNo, 1); // 将字符串数字转化为int型数字,把pageNo传进去，转换为整型，默认为1
		}
		if (pp.getNpagesize()==0) {
			pp.setNpagesize(pageSizeNum); // 更新页面查询数量值
		}

		pp.setNpage(pageNum); // 更新页码值
		
	}
	

	
	
	/**
     * 生成账单编号
     * @return
     */
	public String getSerialNumber() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new Date());
		Random random = new Random();
		StringBuffer sb = new StringBuffer();  
		sb.append(date);
		for (int i = 0; i < 6; i++) 
		{
			sb.append(random.nextInt(10));
		}
		return sb.toString();
	}
	
	/**
	 * 根据页面传入时间账单编号
	 */
	public String getSerialNumber2(String dateString){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Date dateS = null;
		try {
			
			if("".equals(dateString))
			{
				dateS = new Date();
			}else{
				dateS = sdf.parse(dateString);
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String date = sdf.format(dateS);
		
		Random random = new Random();
		StringBuffer sb = new StringBuffer();  
		sb.append(date);
		for (int i = 0; i < 6; i++) 
		{
			sb.append(random.nextInt(10));
		}
		return sb.toString();
	}
		
	

	
	/**
	 * 判断当前登录用户是否有权限
	 * 
	 * @param request
	 * @param rightsCode
	 * @return
	 */
	protected boolean hasStaffRights(HttpServletRequest request, String rightsCode)
	{
		return false;
		
	}
	
	
	protected List<Annex> getAnnexList(String[] imgPathArr, HttpServletRequest request) 
	{
		List<Annex> annexList = new ArrayList<Annex>();
		for (int i = 0; i < imgPathArr.length; i++) 
		{
			String arr[] = imgPathArr[i].split("/");
			String fileName = arr[arr.length-1];
			Annex annex = new Annex();
			annex.setCreateTime(new Date());
			annex.setCreator(getSessionUsername(request));
			annex.setFileName(fileName);
			annex.setFilePath(imgPathArr[i]);
			annexList.add(annex);
		}
		return annexList;
	}
	
	
	
	
	
	
		
}
