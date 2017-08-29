package org.jrc.springfortune.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import org.jrc.springfortune.entity.Annex;
import org.jrc.springfortune.entity.ExecuteResult;
import org.jrc.springfortune.entity.MenuFood;
import org.jrc.springfortune.entity.MenuType;
import org.jrc.springfortune.service.IAnnexService;
import org.jrc.springfortune.service.IMenuFoodService;
import org.jrc.springfortune.service.IMenuTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MenuController extends BaseController
{
	@Autowired
	private IMenuFoodService menuFoodService;
	@Autowired
	private IMenuTypeService menuTypeService;
	@Autowired
	private IAnnexService annexService;
	
	
	
	
	/**
	 * 增加菜单类型
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("user/add_menu_type.htm")
	public String addMenuType(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		String action = getParameter(request, "action");
		if("do".equals(action))
		{
			Map<String, Object> param = new HashMap<String, Object>();
			ExecuteResult result = new ExecuteResult();
			result.setSuccess(true);
			
			String type = getParameter(request, "type");
			String memo = getParameter(request, "memo");
			
			param.put("typeName", type);
			List<MenuType> menuTypes = menuTypeService.list(param);
			if(menuTypes.size()>0)
			{
				result.setSuccess(false);
				result.setMsg("该类型已存在");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return null;
			}
			
			MenuType menuType = new MenuType();
			menuType.setTypeName(type);
			menuType.setMemo(memo);
			menuType.setCreator(getSessionUsername(request));
			
			try {
				menuTypeService.insert(menuType);
			} catch (Exception e) {
				log.info("增加菜单类型异常",e);
				result.setSuccess(false);
				result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
			}
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return null;
			
		}
		
		
		return "system/menu/add_menu_type";
	}
	
	/**
	 * 是否存在菜单类型
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("user/is_exist_menu_type.htm")
	public void isExistMenuType(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(false);
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		String type = getParameter(request, "type");
		param.put("typeName", type);
		List<MenuType> menuTypes = menuTypeService.list(param);
		if(menuTypes.size()>0)
		{
			result.setSuccess(true);
			result.setMsg("该类型已存在");
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
	/**
	 * 增加菜单
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("user/add_menu_food.htm")
	public String addMenuFood(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		setBaseInfo(model);
		Map<String, Object> param = new HashMap<String, Object>();
		
		
		String action = getParameter(request, "action");
		String iframeOpen = getParameter(request, "iframeOpen");
		model.put("iframeOpen", iframeOpen);
		if("do".equals(action))
		{
			ExecuteResult result = new ExecuteResult();
			result.setSuccess(true);
			long menuTypeId = Utils.parseLong(getParameter(request, "menuType"), 0);
			String foodName = getParameter(request, "foodName");
			double price = Utils.parseDouble(getParameter(request, "price"), 0);
			String number = getParameter(request, "number");
			String memo = getParameter(request, "memo");
			int unit = Utils.parseInt(getParameter(request, "unit"), 1);
			
			
			MenuFood food = new MenuFood();
			food.setName(foodName);
			food.setNameNumber(number);
			food.setMemo(memo);
			food.setPrice(price);
			food.setCreator(getSessionUsername(request));
			food.setMenuTypeId(menuTypeId);
			food.setCreateTime(new Date());
			food.setEditTime(new Date());
			food.setUnit(unit);
			
			param.clear();
			param.put("name", foodName);
			List<MenuFood> menuFoods = menuFoodService.list(param);
			if(menuFoods.size()>0)
			{
				result.setSuccess(false);
				result.setMsg("您已经增加过该菜品");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return null;
			}
			
			
			param.clear();
			param.put("nameNumber", number);
			menuFoods = menuFoodService.list(param);
			if(menuFoods.size()>0)
			{
				result.setSuccess(false);
				result.setMsg("该编号已存在");
				String json = JSONUtil.bean2json(result);
				response.getWriter().write(json);
				return null;
			}
			
			
			//附件相关
			List<Annex> fileAnnexList = new ArrayList<Annex>();
			String[] imgPath = getParameters(request, "imgPath");
			//将路径转化成EkhAnnex对象
			if (imgPath != null)
			{
				fileAnnexList = getAnnexList(imgPath, request);
			}
			
			
			try {
//				menuFoodService.insert(food);
				menuFoodService.addMenuFood(food, fileAnnexList);
			} catch (Exception e) {
				log.info("增加菜单异常",e);
				result.setSuccess(false);
				result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
			}
			
			
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return null;
		}
		
		param.clear();
		List<MenuType> menuTypes = menuTypeService.list(param);
		model.put("menuTypes", menuTypes);
		
		return "system/menu/add_menu_food";
	}
	
	/**
	 * 菜单名称是否存在
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("user/is_exist_menu_food.htm")
	public void isExistMenuFood(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(false);
		
		String foodName = getParameter(request, "foodName");
		param.put("name", foodName);
		List<MenuFood> menuFoods = menuFoodService.list(param);
		if(menuFoods.size()>0)
		{
			result.setSuccess(true);
			result.setMsg("您已经增加过该菜品");
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
		
	}
	
	/**
	 * 菜单编号是否存在
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("user/is_exist_menu_food_number.htm")
	public void isExistMenuFoodNumber(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String, Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(false);
		
		String number = getParameter(request, "number");
		param.put("nameNumber", number);
		int count = menuFoodService.getCount(param);
		if(count>0)
		{
			result.setSuccess(true);
			result.setMsg("该编号已存在");
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
		
	}
	
	@RequestMapping("user/menu_list.htm")
	public String menuList(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		List<MenuType> menuTypes = menuTypeService.list(param);
		model.put("menuTypes", menuTypes);
		return "system/menu/menu_list";
	}
	
	@RequestMapping("user/menu_list_hander.htm")
	public void menuListHander(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
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
		
		String startPrice = getParameter(request, "startPrice");
		if(!"".equals(startPrice))
		{
			pp.putParamMap("startPrice", startPrice);
		}
		String endPrice = getParameter(request, "endPrice");
		if(!"".equals(endPrice))
		{
			pp.putParamMap("endPrice", endPrice);
		}
		
		
		PageList<Map<String, Object>> menuFoodList = menuFoodService.getMenuFoodList(pp);
		
		Map<String, Object> dataMap = new HashMap<String,Object>();
		dataMap.put("data", menuFoodList.getRecords());
		dataMap.put("draw", draw);
		dataMap.put("recordsTotal", menuFoodList.getTotalRecords());
		dataMap.put("recordsFiltered", menuFoodList.getTotalRecords());
		
		String json = JSONUtil.map2json(dataMap);
		response.getWriter().write(json);
	}
	
	
	/**
	 * 删除菜单名称
	 * @param request
	 * @param response
	 * @param model
	 * @throws IOException
	 */
	@RequestMapping("user/del_menu_food.htm")
	public void delMenuFood(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String ids = getParameter(request, "idArray");
		try {
			menuFoodService.delMenuFood(ids);
			result.setMsg("删除成功");
		} catch (Exception e) {
			log.info("删除菜品异常",e);
			result.setSuccess(true);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
		
	}
	
	/**
	 * 菜单详情
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("user/menu_detail.htm")
	public String menuDetail(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		setBaseInfo(model);
		Map<String, Object> param = new HashMap<String,Object>();
		
		String id = getParameter(request, "id");
		
		param.put("id", id);
		
		MenuFood food = menuFoodService.get(param);
		model.put("food", food);
		
		param.clear();
		param.put("objId", food.getId());
		param.put("annexCategorycode", SpringFortuneConstans.CONST_ANNEX_FOOD_PIC);
		List<Annex> imgList = annexService.list(param);
		model.put("imgList", imgList);
		
		return "system/menu/menu_detail";
	}
	
	/**
	 * 菜单编辑
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("user/menu_edit.htm")
	public String menuEdit(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws IOException
	{
		setBaseInfo(model);
		Map<String, Object> param = new HashMap<String,Object>();
		
		String id = getParameter(request, "id");
		param.put("id", id);
		MenuFood food = menuFoodService.get(param);
		model.put("food", food);
		model.put("id", id);
		
		String action = getParameter(request, "action");
		if("do".equals(action))
		{
			ExecuteResult result = new ExecuteResult();
			result.setSuccess(true);
			long menuTypeId = Utils.parseLong(getParameter(request, "menuType"), 0);
			String foodName = getParameter(request, "foodName");
			double price = Utils.parseDouble(getParameter(request, "price"), 0);
			String nameNumber = getParameter(request, "nameNumber");
			String memo = getParameter(request, "memo");
			
			//判断是否更改名称，编号
			if(!foodName.equals(food.getName()))
			{
				param.clear();
				param.put("name", foodName);
				int count = menuFoodService.getCount(param);
				if(count>0)
				{
					result.setSuccess(false);
					result.setMsg("您已经增加过该菜品"); 
					String json = JSONUtil.bean2json(result);
					response.getWriter().write(json);
					return null;
				}else{
					food.setName(foodName);
				}
			}
			
			
			if(!nameNumber.equals(food.getNameNumber()))
			{
				param.clear();
				param.put("nameNumber", nameNumber);
				int count = menuFoodService.getCount(param);
				if(count>0)
				{
					result.setSuccess(false);
					result.setMsg("该编号已存在");
					String json = JSONUtil.bean2json(result);
					response.getWriter().write(json);
					return null;
				}else{
					food.setNameNumber(nameNumber);
				}
			}
			
			
			food.setMenuTypeId(menuTypeId);
			food.setPrice(price);
			food.setMemo(memo);
			food.setEditTime(new Date());
			food.setModifer(getSessionUsername(request));
			
			//附件相关
			List<Annex> fileAnnexList = new ArrayList<Annex>();
			String[] imgPath = getParameters(request, "imgPath");
			//将路径转化成EkhAnnex对象
			if (imgPath != null) 
			{
				fileAnnexList = getAnnexList(imgPath, request);
			}
			
			
			try {
//				menuFoodService.update(food);
				menuFoodService.updateMenuFood(food, fileAnnexList);
			} catch (Exception e) {
				log.info("修改菜单异常",e);
				result.setSuccess(false);
				result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
			}
			
			String json = JSONUtil.bean2json(result);
			response.getWriter().write(json);
			return null;
		}
		
		param.clear();
		List<MenuType> menuTypes = menuTypeService.list(param);
		model.put("menuTypes", menuTypes);
		
		param.clear();
		param.put("objId", food.getId());
		param.put("annexCategorycode", SpringFortuneConstans.CONST_ANNEX_FOOD_PIC);
		List<Annex> imgList = annexService.list(param);
		model.put("imgList", imgList);
		
		return "system/menu/menu_edit";
	}
	
	/**
	 * 修改菜品状态
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("user/update_menu_food_status.htm")
	public void updateMenuFoodStatus(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		Map<String, Object> param = new HashMap<String,Object>();
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String id = getParameter(request, "id");
		int status = Utils.parseInt(getParameter(request, "status"), 0);
		
		param.clear();
		param.put("id", id);
		MenuFood food = menuFoodService.get(param);
		food.setStatus(status);
		food.setEditTime(new Date());
		
		try {
			menuFoodService.update(food);
			result.setMsg("操作成功");
		} catch (Exception e) {
			log.info("修改菜品状态异常");
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		String json = JSONUtil.bean2json(result);
		response.getWriter().write(json);
	}
	
}
