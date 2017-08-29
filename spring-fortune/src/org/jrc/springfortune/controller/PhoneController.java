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
import org.jrc.springfortune.entity.Bill;
import org.jrc.springfortune.entity.ExecuteResult;
import org.jrc.springfortune.entity.Location;
import org.jrc.springfortune.entity.MenuFood;
import org.jrc.springfortune.entity.MenuType;
import org.jrc.springfortune.entity.OrderFoods;
import org.jrc.springfortune.service.IBillService;
import org.jrc.springfortune.service.ILocationService;
import org.jrc.springfortune.service.IMenuFoodService;
import org.jrc.springfortune.service.IMenuTypeService;
import org.jrc.springfortune.service.IOrderFoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PhoneController extends BaseController
{

	@Autowired
	private IMenuFoodService menuFoodService;
	@Autowired
	private IMenuTypeService menuTypeService;
	@Autowired
	private ILocationService locationService;
	@Autowired
	private IBillService billService;
	@Autowired
	private IOrderFoodsService orderFoodsService;
	
	
	@RequestMapping("/phone/phone_order_bill.htm")
	public String phoneOrderBill(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.clear();
		List<MenuType> menuTypes = menuTypeService.list(param);
		model.put("menuTypes", menuTypes);
		
		String tableId = getParameter(request, "id");
		String billId = getParameter(request, "billId");
		model.put("tableId", tableId);
		model.put("billId", billId);
		return "phone/phone_order_bill";
	}
	
	
	@RequestMapping("/phone/menu_list_hander")
	public void menuListHandler(HttpServletRequest request,HttpServletResponse response) throws IOException
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
		
		String menuType = getParameter(request, "menuType");
		if(!"".equals(menuType))
		{
			pp.putParamMap("menuTypeId", menuType);
		}
		String keyWord = getParameter(request, "keyWord");
		if(!"".equals(keyWord))
		{
			pp.putParamMap("keyWord", keyWord);
		}
		
		PageList<Map<String, Object>> menuFoodList = menuFoodService.getPhoneMenuFoodList(pp);
		
		Map<String, Object> dataMap = new HashMap<String,Object>();
		dataMap.put("data", menuFoodList.getRecords());
		dataMap.put("draw", draw);
		dataMap.put("recordsTotal", menuFoodList.getTotalRecords());
		dataMap.put("recordsFiltered", menuFoodList.getTotalRecords());
		
		String json = JSONUtil.map2json(dataMap);
		response.getWriter().write(json);
	}
	
	/**
	 * 用户下单
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/phone/add_bill.htm")
	public void addBill(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String ids = getParameter(request, "id");
		String nums = getParameter(request, "num");
		String tableId = getParameter(request, "tableId");
		
		if("".equals(ids) || "".equals(nums) || "".equals(tableId))
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		if(ids.split(",").length != nums.split(",").length)
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		
		param.clear();
		param.put("id", tableId);
		//状态1:可用 2：用餐中 3：预定
		Location table = locationService.get(param);
		if(table == null)
		{
			result.setSuccess(false);
			result.setMsg("您的位置未查询到，请联系服务人员");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		if(table.getStatus() == 2)
		{
			result.setSuccess(false);
			result.setMsg("桌位已被占用，请联系服务人员");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		String peopleNum = getParameter(request, "peopleNum");
		String memo = getParameter(request, "memo");
		String loginName = "客户";
		
		try {
			Bill bill = billService.addPhoneBill(ids, nums, tableId, peopleNum, loginName, memo);
			result.setMsg("下单成功，我们以最快的速度为您服务，请您耐心等待。");
			result.setValue(bill.getId()+","+bill.getBillNumber());
		} catch (Exception e) {
			log.info("用户下单异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
		
	}
	
	@RequestMapping("/phone/bill_detail.htm")
	public String billDeatil(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Map<String, Object> param = new HashMap<>();
		
		String billInfo = getParameter(request, "billInfo");
		
		param.clear();
		param.put("id", billInfo.split(",")[0]);
		param.put("billNumber", billInfo.split(",")[1]);
		
		Bill bill = billService.list(param).get(0);
		model.put("bill", bill);
		
		//订单
		
		param.clear();
		param.put("billId", bill.getId());
		List<OrderFoods> foods = orderFoodsService.list(param);
		model.put("foods", foods);
		
		
		return "phone/bill_detail";
	}
	
	
	/**
	 * 账单编辑，新增订单
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/phone/add_new_bill.htm")
	public void addNewBill(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String billInfo = getParameter(request, "billInfo");
		
		
		param.clear();
		param.put("id", billInfo.split(",")[0]);
		param.put("billNumber", billInfo.split(",")[1]);
		
		Bill bill = billService.list(param).get(0);
		
		if(bill == null)
		{
			result.setSuccess(false);
			result.setMsg("账单不存在");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}else{
			if(bill.getStatus() == 9)
			{
				result.setSuccess(false);
				result.setMsg("账单不存在");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return;
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String date = sdf.format(new Date());
			String createDate = sdf.format(bill.getCreateTime());
			if(!date.equals(createDate))
			{
				result.setSuccess(false);
				result.setMsg("您的订单已过时，请重新扫码进入，点击删除按钮");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return;
			}
		}
		
		
		String ids = getParameter(request, "id");
		String nums = getParameter(request, "num");
		
		String idArray [] = ids.split(",");
		String numArray [] = nums.split(",");
		if("".equals(ids) || "".equals(nums))
		{
			result.setSuccess(false);
			result.setMsg("请选择菜单");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		if(idArray.length != numArray.length)
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		String loginName = "客户";
		
		try {
			//订单信息已保存在客户端，
			billService.addNewBill(idArray, numArray, bill, loginName);
			result.setMsg("再次成功下单，我们以最快的速度为您服务，请您耐心等待。");
		} catch (Exception e) {
			log.info("账单编辑，新增订单异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	/***
	 * 有图模式
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/phone/phone_order_bill_pic.htm")
	public String phoneOrderBillPic(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		setBaseInfo(model);
		
		Map<String, Object> param = new HashMap<String, Object>();
		List<MenuType> types = menuTypeService.list(param);
		model.put("types", types);
		String tableId = getParameter(request, "tableId");
		model.put("tableId", tableId);
		
		return "phone/phone_order_bill_pic";
	}
	
	/**
	 * 有图模式--列表
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("phone/menu_food_list.htm")
	public void phoneMenFoodList(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		String menuTypeId = getParameter(request, "menuTypeId");
		param.put("menuTypeId", menuTypeId);
		
		List<MenuFood> menuFoods = menuFoodService.list(param);
		
		String json = JSONUtil.list2json(menuFoods);
		response.getWriter().write(json);
		
	}
	
	
}
