package org.jrc.springfortune.mapper;

import java.util.List;
import java.util.Map;

import org.jrc.springfortune.entity.MenuFood;


/**
 * @Description: 接口
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
public interface MenuFoodMapper extends BaseMapper<MenuFood>{

	public int getMenuFoodListCount(Map<String,Object> param);
	
	List<Map<String, Object>> getMenuFoodList(Map<String, Object> param);
	
	
	/**
	 * 手机端
	 * @param param
	 * @return
	 */
	public int getPhoneMenuFoodListCount(Map<String,Object> param);
	
	List<Map<String, Object>> getPhoneMenuFoodList(Map<String, Object> param);

}
