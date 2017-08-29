package org.jrc.springfortune.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;
import org.jrc.common.utils.JSONUtil;
import org.jrc.common.utils.Utils;
import org.jrc.springfortune.constants.SpringFortuneConstans;
import org.jrc.springfortune.entity.ExecuteResult;
import org.jrc.springfortune.entity.Location;
import org.jrc.springfortune.service.ILocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TableController extends BaseController
{
	
	@Autowired
	private ILocationService locationService;
	
	@RequestMapping("user/add_table.htm")
	public String addTable(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		return "system/table/add_table";
	}
	
	/**
	 * 添加桌位
	 * @param request
	 * @param response
	 * @param model
	 * @throws IOException
	 */
	@RequestMapping("user/add_table_submit.htm")
	public String addTableSubmit(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		Map<String, Object> param = new HashMap<String, Object>();
		String locationNumber = getParameter(request, "locationNumber");
		String memo = getParameter(request, "memo");
		String action = getParameter(request, "action");
		if("do".equals(action))
		{
			Location location = new Location();
			location.setLocationNumber(locationNumber);
			location.setMemo(memo);
			
			try {
				locationService.insert(location);
			} catch (Exception e) {
				log.info("增加桌位异常",e);
				result.setSuccess(false);
				result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
			}
			String json = JSONUtil.bean2json(result);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(json);
			return null;
		}
		param.clear();
		param.put("locationNumber", locationNumber);
		List<Location> list = locationService.list(param);
		if(list.size()>0)
		{
			result.setSuccess(false);
			result.setMsg("您已经添加过该桌位编号，请不要重复添加！");
		}
		String json = JSONUtil.bean2json(result);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(json);
		return null;
	}
	
	@RequestMapping("user/table_list.htm")
	public String tableList(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		return "system/table/table_list";
	}
	
	@RequestMapping("user/table_list_hander.htm")
	public void tableListHander(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		// 设置分页基本信息
		PageProperty pp = new PageProperty();
		
		int draw =Utils.parseInt(getParameter(request, "draw"), 0);
		int start = Utils.parseInt(getParameter(request, "start"), 0);
		int length = Utils.parseInt(getParameter(request, "length"), 10);
		
		//设置当前页码
		int pageSize = length;
		pp.setNpagesize(pageSize);
		int currentPage = start/pageSize + 1;
		pp.setNpage(currentPage);
		
		
		
		PageList<Map<String, Object>> tableList = locationService.getTableList(pp);
		
		Map<String, Object> dataMap = new HashMap<String,Object>();
		dataMap.put("data", tableList.getRecords());
		dataMap.put("draw", draw);
		dataMap.put("recordsTotal", tableList.getTotalRecords());
		dataMap.put("recordsFiltered", tableList.getTotalRecords());
		
		String json = JSONUtil.map2json(dataMap);
		response.getWriter().write(json);
	}
	
	
	@RequestMapping("user/del_table.htm")
	public void delTable(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String idArray = getParameter(request, "idArray");
		
		try {
			locationService.delTable(idArray);
			result.setMsg("删除成功");
		} catch (Exception e) {
			log.info("删除桌位异常",e);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
			result.setSuccess(false);
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	
	@RequestMapping("user/get_table_list.htm")
	public void getTableList(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("noUse", "noUse");
		List<Location> tablelList = locationService.list(param);
		
		String json = JSONUtil.list2json(tablelList);
		response.getWriter().write(json);
	}
	
	@RequestMapping("user/edit_table_status.htm")
	public void edtiTableStatus(HttpServletRequest request,HttpServletResponse response) throws IOException 
	{
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String idArray = getParameter(request, "idArray");
		int status = Utils.parseInt(getParameter(request, "status"), 1);
		
		try {
			locationService.updateStatus(idArray, status);
			result.setMsg("操作成功");
		} catch (Exception e) {
			log.info("修改状态异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	
	
}
