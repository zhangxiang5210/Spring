package org.jrc.springfortune.mapper;

import java.util.List;
import java.util.Map;

import org.jrc.springfortune.entity.OrderFoods;

/**
 * @Description: 接口
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
public interface OrderFoodsMapper extends BaseMapper<OrderFoods>{

	public int getSimpleInfoPageCount(Map<String,Object> param);
	
	List<Map<String, Object>> getSimpleInfoPage(Map<String,Object> param);

}
