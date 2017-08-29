package org.jrc.springfortune.service;

import java.util.List;
import java.util.Map;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;
import org.jrc.springfortune.entity.OrderFoods;

/**
 * @Description: 逻辑层接口
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
public interface IOrderFoodsService extends IBaseService<OrderFoods> {

	PageList<Map<String, Object>> getSimpleInfoPage(PageProperty pp);
	
	public void updateFoodStatus(List<OrderFoods> orderFoods);
}