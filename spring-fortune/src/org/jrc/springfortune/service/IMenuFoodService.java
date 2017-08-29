package org.jrc.springfortune.service;

import java.util.List;
import java.util.Map;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;
import org.jrc.springfortune.entity.Annex;
import org.jrc.springfortune.entity.MenuFood;



/**
 * @Description: 逻辑层接口
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
public interface IMenuFoodService extends IBaseService<MenuFood> {

	PageList<Map<String, Object>> getMenuFoodList(PageProperty pp);
	
	public void delMenuFood(String ids);
	
	PageList<Map<String, Object>> getPhoneMenuFoodList(PageProperty pp);
	
	public void addMenuFood(MenuFood food,List<Annex> fileAnnexList);
	
	public void updateMenuFood(MenuFood food,List<Annex> fileAnnexList);
}