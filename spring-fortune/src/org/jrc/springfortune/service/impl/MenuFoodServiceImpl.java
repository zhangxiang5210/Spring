package org.jrc.springfortune.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;
import org.jrc.common.utils.PageUtil;
import org.jrc.common.utils.Utils;
import org.jrc.springfortune.constants.SpringFortuneConstans;
import org.jrc.springfortune.entity.Annex;
import org.jrc.springfortune.entity.MenuFood;
import org.jrc.springfortune.mapper.AnnexMapper;
import org.jrc.springfortune.mapper.MenuFoodMapper;
import org.jrc.springfortune.service.IMenuFoodService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="menuFoodService")
public class MenuFoodServiceImpl extends BaseServiceImpl<MenuFood,MenuFoodMapper> implements IMenuFoodService,InitializingBean {

	@Autowired
	private MenuFoodMapper menuFoodMapper;
	@Autowired
	private AnnexMapper annexMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(menuFoodMapper);
	}

	@Override
	public PageList<Map<String, Object>> getMenuFoodList(PageProperty pp) {
		int count = menuFoodMapper.getMenuFoodListCount(pp.getParamMap());
		int start = PageUtil.getStart(pp.getNpage(), count, pp.getNpagesize());
		int end = PageUtil.getEnd(pp.getNpage(), count, pp.getNpagesize());
		pp.putParamMap("startrow", start);
		pp.putParamMap("endrow", end);
		pp.putParamMap("pagesize", pp.getNpagesize());//mysql用到的参数
		PageList<Map<String, Object>>	pageList = new PageList<Map<String, Object>>(pp, count, menuFoodMapper.getMenuFoodList(pp.getParamMap()));
		return pageList;
	}

	@Transactional
	public void delMenuFood(String ids) {
		// TODO Auto-generated method stub
		Map<String, Object> param = new HashMap<String, Object>();
		String idArray [] = ids.split(",");
		for (int i = 0; i < idArray.length; i++) 
		{
			param.clear();
			param.put("id", Utils.parseLong(idArray[i], 0));
			menuFoodMapper.delete(param);
		}
	}

	@Override
	public PageList<Map<String, Object>> getPhoneMenuFoodList(PageProperty pp) {
		int count = menuFoodMapper.getPhoneMenuFoodListCount(pp.getParamMap());
		int start = PageUtil.getStart(pp.getNpage(), count, pp.getNpagesize());
		int end = PageUtil.getEnd(pp.getNpage(), count, pp.getNpagesize());
		pp.putParamMap("startrow", start);
		pp.putParamMap("endrow", end);
		pp.putParamMap("pagesize", pp.getNpagesize());//mysql用到的参数
		PageList<Map<String, Object>>	pageList = new PageList<Map<String, Object>>(pp, count, menuFoodMapper.getPhoneMenuFoodList(pp.getParamMap()));
		return pageList;
	}

	@Transactional
	public void addMenuFood(MenuFood food, List<Annex> fileAnnexList) {
		menuFoodMapper.insert(food);
		
		for (Annex annex : fileAnnexList)
		{
			annex.setObjId(food.getId());
			annex.setAnnexCategorycode(SpringFortuneConstans.CONST_ANNEX_FOOD_PIC);
			annexMapper.insert(annex);
		}
	}

	@Transactional
	public void updateMenuFood(MenuFood food, List<Annex> fileAnnexList)
	{
		menuFoodMapper.update(food);
		for (Annex annex : fileAnnexList)
		{
			annex.setObjId(food.getId());
			annex.setAnnexCategorycode(SpringFortuneConstans.CONST_ANNEX_FOOD_PIC);
			annexMapper.insert(annex);
		}
		
	}

}
