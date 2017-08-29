package org.jrc.springfortune.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;
import org.jrc.common.utils.Arith;
import org.jrc.common.utils.DatetimeUtil;
import org.jrc.common.utils.JSONUtil;
import org.jrc.common.utils.Utils;
import org.jrc.springfortune.constants.SpringFortuneConstans;
import org.jrc.springfortune.entity.Bill;
import org.jrc.springfortune.entity.ExecuteResult;
import org.jrc.springfortune.entity.Location;
import org.jrc.springfortune.entity.MenuFood;
import org.jrc.springfortune.entity.MenuType;
import org.jrc.springfortune.entity.OrderFoods;
import org.jrc.springfortune.entity.ReservationInfo;
import org.jrc.springfortune.entity.TakeOutInfo;
import org.jrc.springfortune.service.IBillService;
import org.jrc.springfortune.service.ILocationService;
import org.jrc.springfortune.service.IMenuFoodService;
import org.jrc.springfortune.service.IMenuTypeService;
import org.jrc.springfortune.service.IOrderFoodsService;
import org.jrc.springfortune.service.IReservationInfoService;
import org.jrc.springfortune.service.ITakeOutInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BillController extends BaseController
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
	private IReservationInfoService reservationInfoService;
	@Autowired
	private ITakeOutInfoService takeOutInfoService;
	@Autowired
	private IOrderFoodsService orderFoodsService;
	
	
	
	@RequestMapping("/user/add_bill.htm")
	public String addBill(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		List<MenuType> menuTypes = menuTypeService.list(param);
		model.put("menuTypes", menuTypes);
		return "system/bill/add_bill";
	}
	
	/**
	 * 获取菜单信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/user/get_menu_food.htm")
	public void getMenuFood(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		
		String id = getParameter(request, "id");
		param.put("id", id);
		MenuFood food = menuFoodService.get(param);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("food", food);
		
		String json = JSONUtil.map2json(dataMap);
		response.getWriter().write(json);
	}
	
	/**
	 * 预约订单
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/user/order_bill_info.htm")
	public String orderBillInfo(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		String action = getParameter(request, "action");
		if("do".equals(action))
		{
			ExecuteResult result = new ExecuteResult();
			result.setSuccess(true);
			
			String idArray = getParameter(request, "idArray");
			String numArray = getParameter(request, "numArray");
			String name = getParameter(request, "name");
			String phone = getParameter(request, "phone");
			String startDate = getParameter(request, "startDate");
			String endDate = getParameter(request, "endDate");
			String memo = getParameter(request, "memo");
			
			String tableId = getParameter(request, "tableNum");
			String peopleNum = getParameter(request, "peopleNum");
			
			int idLength = idArray.split(",").length;
			int numLength = numArray.split(",").length;
			if(idLength != numLength)
			{
				result.setSuccess(false);
				result.setMsg("数据异常");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return null;
			}
			
			ReservationInfo reservationInfo = new ReservationInfo();
			reservationInfo.setName(name);
			reservationInfo.setPhone(phone);
			if(!"".equals(startDate))
			{
				reservationInfo.setOrderTimeStart(DatetimeUtil.convertStringToDate(startDate, "yyyy-MM-dd HH:mm:ss"));
			}
			if(!"".equals(endDate))
			{
				reservationInfo.setOrderTimeEnd(DatetimeUtil.convertStringToDate(endDate,"yyyy-MM-dd HH:mm:ss"));
			}
			reservationInfo.setCreateTime(new Date());
			reservationInfo.setMemo(memo);
			
			String loginName = getSessionUsername(request);
			try {
				int num = billService.addOrderBill(reservationInfo, idArray, numArray,loginName,tableId,peopleNum);
				if(num == 0){
					result.setMsg("预约成功");
				}else{
					result.setMsg("有"+num+"样菜预约失败，请在账单管理中核对！");
				}
			} catch (Exception e) {
				log.info("预约异常",e);
				result.setSuccess(false);
				result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
			}
			
			
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return null;
		}
		return "system/bill/order_bill_info";
	}
	
	/**
	 * 店内订单
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/user/add_shop_bill.htm")
	public void addShopBill(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String tableId = getParameter(request, "tableNumber");
		String peopleNum = getParameter(request, "peopleNum");
		String ids = getParameter(request, "ids");
		String nums = getParameter(request, "nums");
		String memo = getParameter(request, "memo");
		
		String loginName = getSessionUsername(request);
		
		if("".equals(ids))
		{
			result.setSuccess(false);
			result.setMsg("请选择菜单");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		int idLength = ids.split(",").length;
		int numLength = nums.split(",").length;
		if(idLength != numLength)
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return ;
		}
		
		
		try {
			int num = billService.addShopBill(ids, nums, tableId, peopleNum, loginName,memo);
			if(num == 0){
				result.setMsg("下单成功");
			}else{
				result.setMsg("有"+num+"样菜下单失败，请在账单管理中核对！");
			}
		} catch (Exception e) {
			log.info("下单异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		
		
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	/**
	 * 外卖订单 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/user/take_away_bill.htm")
	public String takeAwayBill(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		String action = getParameter(request, "action");
		if("do".equals(action))
		{
			ExecuteResult result = new ExecuteResult();
			result.setSuccess(true);
			
			String idArray = getParameter(request, "idArray");
			String numArray = getParameter(request, "numArray");
			
			String name = getParameter(request, "name");
			String phone = getParameter(request, "phone");
			String address = getParameter(request, "address");
			String memo = getParameter(request, "memo");
			String peopleNum = getParameter(request, "peopleNum");
			
			
			String loginName = getSessionUsername(request);
			
			if("".equals(idArray))
			{
				result.setSuccess(false);
				result.setMsg("请选择菜单");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return null;
			}
			
			int idLength = idArray.split(",").length;
			int numLength = numArray.split(",").length;
			if(idLength != numLength)
			{
				result.setSuccess(false);
				result.setMsg("数据异常");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return null;
			}
			
			TakeOutInfo takeOutInfo = new TakeOutInfo();
			takeOutInfo.setName(name);
			takeOutInfo.setPnhone(phone);
			takeOutInfo.setAddress(address);
			takeOutInfo.setMemo(memo);
			takeOutInfo.setCreateTime(new Date());
			
			try {
				int num = billService.addTakeAwayBill(takeOutInfo, idArray, numArray, loginName,peopleNum);
				if(num == 0){
					result.setMsg("下单成功");
				}else{
					result.setMsg("有"+num+"样菜下单失败，请在账单管理中核对！");
				}
			} catch (Exception e) {
				log.info("外卖订单异常",e);
				result.setSuccess(false);
				result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
			}
			
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return null;
		}
		return "system/bill/take_away_bill";
	}
	
	@RequestMapping("/user/bill_list.htm")
	public String billList(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		return "system/bill/bill_list";
	}
	
	@RequestMapping("/user/bill_list_hander.htm")
	public void billListHander(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
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
		String receiveType = getParameter(request, "receiveType");
		String type = getParameter(request, "type");
		String keyWord = getParameter(request, "keyWord");
		if(!"".equals(status))
		{
			pp.putParamMap("status", status);
			param.put("status", status);
		}
		if(!"".equals(receiveType))
		{
			pp.putParamMap("receiveType", receiveType);
			param.put("receiveType", receiveType);
		}
		if(!"".equals(type))
		{
			pp.putParamMap("type", type);
			param.put("type", type);
		}
		if(!"".equals(keyWord))
		{
			pp.putParamMap("keyWord", keyWord);
			param.put("keyWord", keyWord);
		}
		
		int time = Utils.parseInt(getParameter(request, "time"), 0);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(time == 31)
		{//当月
			Calendar c1 = Calendar.getInstance();
			c1.set(Calendar.DATE, 1);	
			pp.putParamMap("startDate", c1.getTime());
			param.put("startDate", c1.getTime());
			
			Calendar c2 = Calendar.getInstance();
			c2.set(Calendar.DATE, c2.getActualMaximum(Calendar.DAY_OF_MONTH));//最后一天
			pp.putParamMap("endDate", c1.getTime());
			param.put("endDate", c1.getTime());
		}else if(time == 366){
			//当年
			Calendar c1 = Calendar.getInstance();
			c1.set(Calendar.MONTH, 0);//1月
			c1.set(Calendar.DATE, 1);//1号
			pp.putParamMap("startDate", sdf.format(c1.getTime()));
			param.put("startDate", c1.getTime());
			
			
			Calendar c2 = Calendar.getInstance();
			c2.set(Calendar.MONTH, 11);//1月
			c2.set(Calendar.DAY_OF_MONTH, c2.getActualMaximum(Calendar.DAY_OF_MONTH));//最后1天
			pp.putParamMap("endDate", sdf.format(c2.getTime()));
			param.put("endDate", sdf.format(c2.getTime()));
			
		}else if(time != 0){
			Calendar c1 = Calendar.getInstance();
			c1.add(Calendar.DATE, 1);
			pp.putParamMap("endDate", sdf.format(c1.getTime()));
			param.put("endDate", sdf.format(c1.getTime()));
			
			c1.add(Calendar.DATE, -time);
			pp.putParamMap("startDate", sdf.format(c1.getTime()));
			param.put("startDate",  sdf.format(c1.getTime()));
		}
		
		PageList<Bill> bill = billService.getPageList(pp);
		List<Bill> billList = billService.list(param);
				
		
		
		Map<String, Object> dataMap = new HashMap<String,Object>();
		dataMap.put("data", bill.getRecords());
		dataMap.put("draw", draw);
		dataMap.put("recordsTotal", bill.getTotalRecords());
		dataMap.put("recordsFiltered", bill.getTotalRecords());
		
		
		
		double arTotalMoney = 0;
		double payTotalMoney = 0;
		int payNum = 0;
		for (int i = 0; i < billList.size(); i++) 
		{
			Bill bill2 = billList.get(i);
			
			arTotalMoney = Arith.add(arTotalMoney, bill2.getArMoney());
			if(bill2.getStatus() == 2)
			{
				payNum ++;
				payTotalMoney = Arith.add(payTotalMoney, bill2.getArMoney());
			}
		}
		
		dataMap.put("arTotalMoney", arTotalMoney);
		dataMap.put("arNum", bill.getTotalRecords()-payNum);
		dataMap.put("payTotalMoney", payTotalMoney);
		dataMap.put("payNum", payNum);
		
		
		String json = JSONUtil.map2json(dataMap);
		response.getWriter().write(json);
	}
	
	/**
	 * 账单详情
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/user/bill_detail.htm")
	public String billDetail(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		
		String billId = getParameter(request, "id");
		param.clear();
		param.put("id", billId);
		Bill bill = billService.get(param);
		model.put("bill", bill);
		if(bill.getType() == 2)
		{//预约
			param.clear();
			param.put("billId", bill.getId());
			ReservationInfo reservationInfo = reservationInfoService.list(param).get(0);
			model.put("reservationInfo", reservationInfo);
		}
		if(bill.getType() == 3)
		{//外卖
			param.clear();
			param.put("billId", bill.getId());
			TakeOutInfo takeOutInfo = takeOutInfoService.list(param).get(0);
			model.put("takeOutInfo", takeOutInfo);
		}
		
		//订单
		param.clear();
		param.put("billId", bill.getId());
		List<OrderFoods> foods = orderFoodsService.list(param);
		model.put("foods", foods);
		
		return "system/bill/bill_detail";
	}
	
	
	/**
	 * 分享
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/user/share_data.htm")
	public void shareData(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		String billId = getParameter(request, "id");
		
		param.clear();
		param.put("id", billId);
		
		Bill bill = billService.get(param);
		String info = "";
		if(bill.getType() == 1)
		{
			if(bill.getLocationNumber() == null)
			{
				info = "店内用餐  位置编号：暂不清楚，请询问前台";
			}else{
				info = "店内用餐  位置编号："+bill.getLocationNumber();
			}
		}
		if(bill.getType() == 2)
		{
			info = "预约";
		}
		if(bill.getType() == 3)
		{
			param.clear();
			param.put("billId", bill.getId());
			TakeOutInfo takeOutInfo = takeOutInfoService.list(param).get(0);
			info = "外卖  姓名："+takeOutInfo.getName()+"  电话："+takeOutInfo.getPnhone()+"  地址："+takeOutInfo.getAddress();
		}
		
		dataMap.put("info", info);
		String memo = "";
		if(bill.getMemo() != null)
		{
			memo = bill.getMemo();
		}
		dataMap.put("memo", memo);
		
		//菜单
		param.clear();
		param.put("billId", bill.getId());
		List<OrderFoods> foods = orderFoodsService.list(param);
		dataMap.put("foods", foods);
		
		
		
		String json = JSONUtil.map2json(dataMap);
		response.getWriter().write(json);
	}
	
	/**
	 * 账单编辑
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/user/bill_edit.htm")
	public String billEdit(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		
		String billId = getParameter(request, "id");
		param.clear();
		param.put("id", billId);
		Bill bill = billService.get(param);
		model.put("bill", bill);
		
		if(bill.getStatus() == 9)
		{//已删除的要拦截
			
			//TODO
			return null;
		}
		
		String action = getParameter(request, "action");
		if("do".equals(action))
		{
			
		}
		
		//订单
		param.clear();
		param.put("billId", bill.getId());
		List<OrderFoods> foods = orderFoodsService.list(param);
		model.put("foods", foods);
		
		return "system/bill/bill_edit";
	}
	
	/**
	 * 修改订单状态
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/user/edit_order_food_status.htm")
	public void editOrderFoodStatus(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String idArray = getParameter(request, "idArray");
		int status = Utils.parseInt(getParameter(request, "status"), 0);
		String billId = getParameter(request, "billId");
		
		if("".equals(idArray))
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		if(status != 4 && status != 9)
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		if("".equals(billId))
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		
		
		
		String loginName = getSessionUsername(request);
		String id [] = idArray.split(",");
		List<OrderFoods> editFoodsStatus = new ArrayList<OrderFoods>();
		for (int i = 0; i < id.length; i++) 
		{
			param.clear();
			param.put("id", id[i]);
			param.put("billId", billId);
			OrderFoods orderFoods = orderFoodsService.get(param);
			if(orderFoods.getStatus() == status)
			{
				result.setSuccess(false);
				result.setMsg("请不要勾选已操作过的数据");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return;
			}
			if(status == 4 && orderFoods.getStatus() == 9)
			{
				result.setSuccess(false);
				result.setMsg("已删除的订单不能再更改");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return;
			}
			
			if(status == 9 && orderFoods.getPayStatus() == 2)
			{
				result.setSuccess(false);
				result.setMsg("已支付过的订单不可以再删除");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return;
			}
			
			orderFoods.setStatus(status);
			if(status == 4)
			{
				orderFoods.setOperationPerson(orderFoods.getOperationPerson()+","+loginName);
			}
			if(status == 9)
			{
				orderFoods.setDelPerson(loginName);
			}
			editFoodsStatus.add(orderFoods);
		}
		
		try {
			billService.editOrderFoodStatus(editFoodsStatus, status);
			result.setMsg("操作成功");
		} catch (Exception e) {
			log.info("修改订单异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	/**
	 * 以斤计价修改量
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/user/edit_order_food_amount.htm")
	public void editOrderFoodAmount(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String id = getParameter(request, "id");
		double amount = Utils.parseDouble(getParameter(request, "amount"), 0);
		String billId = getParameter(request, "billId");
		
		param.clear();
		param.put("id", id);
		param.put("billId", billId);
		OrderFoods orderFoods = orderFoodsService.get(param);
		if(orderFoods.getUnit() == 3)
		{
			if(orderFoods.getPayStatus() == 2)
			{
				result.setSuccess(false);
				result.setMsg("已支付过的菜单，不允许再修改");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return;
			}
			orderFoods.setNum(amount);
		}else{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		try {
			billService.editOrderFoodAmount(orderFoods);
			result.setMsg("操作成功");
		} catch (Exception e) {
			log.info("修改订单量异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	/**
	 * 账单编辑，新增订单   ajax提交
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/user/add_new_bill.htm")
	public void addNewBill(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String ids = getParameter(request, "ids");
		String nums = getParameter(request, "nums");
		long billId = Utils.parseLong(getParameter(request, "billId"), 0);
		
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
		if(billId == 0)
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
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
		
		param.clear();
		param.put("id", billId);
		Bill bill = billService.get(param);
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
		}
		
		
		String loginName = getSessionUsername(request);
		
		try {
			billService.addNewBill(idArray, numArray, bill, loginName);
			result.setMsg("操作成功");
		} catch (Exception e) {
			log.info("账单编辑，新增订单异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	/**
	 * 账单编辑，新增订单   ajaxForm提交
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/user/add_new_form_bill.htm")
	public void addNewFormBill(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		
		String ids = getParameter(request, "ids");
		String nums = getParameter(request, "nums");
		long billId = Utils.parseLong(getParameter(request, "billId"), 0);
		String tableId = getParameter(request, "tableNumber");
		int type = Utils.parseInt(getParameter(request, "type"), 0);
		int peopleNum = Utils.parseInt(getParameter(request, "peopleNum"), 0);
		String billMemo = getParameter(request, "billMemo");
		
		String idArray [] = ids.split(",");
		String numArray [] = nums.split(",");
		
		param.clear();
		param.put("id", billId);
		Bill bill = billService.get(param);
		if(bill == null)
		{
			result.setSuccess(false);
			result.setMsg("账单不存在");
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
		
		
		if(!"".equals(tableId))
		{
			param.clear();
			param.put("id", tableId);
			Location location = locationService.get(param);
			if(location != null)
			{
				bill.setLocationNumber(location.getLocationNumber());
			}
		}
		if(type != 0)
		{
			bill.setType(type);
		}
		if(peopleNum != 0)
		{
			bill.setUserNum(peopleNum);
		}
		bill.setBillMemo(billMemo);
		
		String loginName = getSessionUsername(request);
		try {
			billService.addNewFormBill(ids, nums, loginName, bill);
			result.setMsg("操作成功");
		} catch (Exception e) {
			log.info("账单编辑，新增订单异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	/***
	 * 获取账单
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/user/get_bill.htm")
	public void getBill(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		String billId = getParameter(request, "id");
		param.clear();
		param.put("id", billId);
		Bill bill = billService.get(param);
		
		//获取菜单总数（避免收款时有新的菜单加入）
		param.clear();
		param.put("billId", bill.getId());
		int menuCount = orderFoodsService.getCount(param);
		
		bill.setMenuCount(menuCount);
		
		dataMap.put("bill", bill);
		
		
		
		String json = JSONUtil.map2json(dataMap);
		response.getWriter().write(json);
	}
	
	/**
	 * 账单收款
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("user/receive_bill.htm")
	public void receiveBill(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String billId = getParameter(request, "id");
		double payMoney = Utils.parseDouble(getParameter(request, "payMoney"), 0);
		int receiveType = Utils.parseInt(getParameter(request, "receiveType"), 0);
		String billMemo = getParameter(request, "billMemo");
		int menuCount = Utils.parseInt(getParameter(request, "menuCount"), 0);
		
		String loginName = getSessionUsername(request);
		
		param.clear();
		param.put("id", billId);
		Bill bill = billService.get(param);
		
		//是否已付
		if(bill.getStatus() == 2)
		{
			result.setSuccess(false);
			result.setMsg("已收款，请不要重复提交");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		//是否已删除
		if(bill.getStatus() == 9)
		{
			result.setSuccess(false);
			result.setMsg("已删除，不能再次收款");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		
		//提交前是否有新的订单
		param.clear();
		param.put("billId", bill.getId());
		int count = orderFoodsService.getCount(param);
		if(count>menuCount)
		{
			result.setSuccess(false);
			result.setMsg("有新的订单加入，请刷新后再提交");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		
		
		
		double totalPayMoney = Arith.add(bill.getPayMoney(), payMoney);
		
		//状态1：未付 2：已付 9：删除
		bill.setStatus(2);
		bill.setReceiveTime(new Date());
		bill.setReceiveLonginName(loginName);
		bill.setPayMoney(totalPayMoney);
		bill.setReceiveType(receiveType);
		bill.setReceiveWay(1);
		bill.setBillMemo(billMemo);
		
		try {
//			billService.update(bill);
			billService.updateBill(bill);
			result.setMsg("收款成功");
		} catch (Exception e) {
			log.info("账单收款异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
		
	}
	
	/**
	 * 删除账单
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("user/del_bill.htm")
	public void delBill(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String billId = getParameter(request, "id");
//		String loginName = getSessionUsername(request);
		
		param.clear();
		param.put("id", billId);
		Bill bill = billService.get(param);
		
		if(bill.getStatus() == 2)
		{
			result.setSuccess(false);
			result.setMsg("已收款，不能再删除");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		bill.setStatus(9);
		
		try {
//			billService.update(bill);
			billService.updateBill(bill);
			result.setMsg("删除成功");
		} catch (Exception e) {
			log.info("删除账单异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	/**
	 * 订单分享
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/bill_order_food_share.htm")
	public String billOrderFoodShare(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		
		String billId = getParameter(request, "id");
		param.clear();
		param.put("id", billId);
		Bill bill = billService.get(param);
		model.put("bill", bill);
		if(bill.getType() == 2)
		{//预约
			param.clear();
			param.put("billId", bill.getId());
			ReservationInfo reservationInfo = reservationInfoService.list(param).get(0);
			model.put("reservationInfo", reservationInfo);
		}
		if(bill.getType() == 3)
		{//外卖
			param.clear();
			param.put("billId", bill.getId());
			TakeOutInfo takeOutInfo = takeOutInfoService.list(param).get(0);
			model.put("takeOutInfo", takeOutInfo);
		}
		
		//订单
		param.clear();
		param.put("billId", bill.getId());
		List<OrderFoods> foods = orderFoodsService.list(param);
		model.put("foods", foods);
		
		
		return "system/bill/bill_order_food_share";
	}
	
	/**
	 * 预约
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/user/reservation_list.htm")
	public String reservationList(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		
		return "system/bill/reservation_list";
	}
	
	
	@RequestMapping("/user/reservation_list_handler.htm")
	public void reservationListhandler(HttpServletRequest request,HttpServletResponse response) throws IOException
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
		
		
		
		
		pp.putParamMap("noDel", "noDel");
		
		PageList<ReservationInfo> reservationInfoList = reservationInfoService.getPageList(pp);
		
		
		Map<String, Object> dataMap = new HashMap<String,Object>();
		dataMap.put("data", reservationInfoList.getRecords());
		dataMap.put("draw", draw);
		dataMap.put("recordsTotal", reservationInfoList.getTotalRecords());
		dataMap.put("recordsFiltered", reservationInfoList.getTotalRecords());
		
		String json = JSONUtil.map2json(dataMap);
		response.getWriter().write(json);
	}
	
	/**
	 * 删除预约
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/user/del_reservation.htm")
	public void delReservation(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String ids = getParameter(request, "ids");
		if("".equals(ids))
		{
			result.setSuccess(false);
			result.setMsg("数据异常");
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return;
		}
		
		try {
			int num = billService.delReservation(ids);
			if(num == 0)
			{
				result.setMsg("删除成功");
			}
			if(num == 1)
			{
				result.setSuccess(false);
				result.setMsg("有已支付的记录,不可删除");
			}
		} catch (Exception e) {
			log.info("删除预约异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
				
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	

}
