package org.jrc.springfortune.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.jrc.springfortune.entity.OrderFoods;
import org.jrc.springfortune.service.IMenuFoodService;
import org.jrc.springfortune.service.IOrderFoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class KitchenController extends BaseController
{
	@Autowired
	private IOrderFoodsService orderFoodsService;
	
	
	
	@RequestMapping("/user/get_order_info_simple.htm")
	public String getOrderInfoSimple(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		
		return "system/kitchen/order_list";
	}
	
	
	@RequestMapping("/user/get_order_info_simple_handler.htm")
	public void getOrderInfoSimpleHandler(HttpServletRequest request,HttpServletResponse response) throws IOException
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
		
		
		String status = getParameter(request, "status");
		if(!"".equals(status))
		{
			pp.putParamMap("status", status);
		}
		
		//只能查看当天的记录
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		pp.putParamMap("startDate", sdf.format(new Date()));
		
		
		PageList<Map<String, Object>> order = orderFoodsService.getSimpleInfoPage(pp);
		
		
		Map<String, Object> dataMap = new HashMap<String,Object>();
		dataMap.put("data", order.getRecords());
		dataMap.put("draw", draw);
		dataMap.put("recordsTotal", order.getTotalRecords());
		dataMap.put("recordsFiltered", order.getTotalRecords());
		
		String json = JSONUtil.map2json(dataMap);
		response.getWriter().write(json);
	}
	
	/**
	 *  批量修改订单状态
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("user/kitchen_edit_order_food_status.htm")
	public void kitchenEditOrderFoodStatus(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String menuId = getParameter(request, "menuId");
		int status = Utils.parseInt(getParameter(request, "status"), 0);
		
		if("".equals(menuId))
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		param.clear();
//		param.put("startDate", sdf.format(new Date()));
		param.put("noDel", "noDel");
		param.put("menuId", menuId);
		List<OrderFoods> orderFoods = orderFoodsService.list(param);
		if(orderFoods.size()<1)
		{
			result.setSuccess(false);
			result.setMsg("未找到操作对象");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		String loginName = getSessionUsername(request);
		
		for (OrderFoods order : orderFoods) 
		{//9已过滤掉
			if(order.getStatus() >= status)
			{
				result.setSuccess(false);
				result.setMsg("违规操作");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return;
			}else{
				order.setStatus(status);
				order.setOperationPerson(order.getOperationPerson()+","+loginName);
			}
		}
		
		
		try {
			orderFoodsService.updateFoodStatus(orderFoods);
			result.setMsg("操作成功");
		} catch (Exception e) {
			log.info("批量修改订单状态异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
				
		
		
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
}
