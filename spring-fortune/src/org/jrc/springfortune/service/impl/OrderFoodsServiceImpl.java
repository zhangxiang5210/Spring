package org.jrc.springfortune.service.impl;


import java.util.List;
import java.util.Map;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;
import org.jrc.common.utils.PageUtil;
import org.jrc.springfortune.entity.OrderFoods;
import org.jrc.springfortune.mapper.OrderFoodsMapper;
import org.jrc.springfortune.service.IOrderFoodsService;
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
@Service(value="orderFoodsService")
public class OrderFoodsServiceImpl extends BaseServiceImpl<OrderFoods,OrderFoodsMapper> implements IOrderFoodsService,InitializingBean {

	@Autowired
	private OrderFoodsMapper orderFoodsMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(orderFoodsMapper);
	}

	@Override
	public PageList<Map<String, Object>> getSimpleInfoPage(PageProperty pp) {
		int count = orderFoodsMapper.getSimpleInfoPageCount(pp.getParamMap());
		int start = PageUtil.getStart(pp.getNpage(), count, pp.getNpagesize());
		int end = PageUtil.getEnd(pp.getNpage(), count, pp.getNpagesize());
		pp.putParamMap("startrow", start);
		pp.putParamMap("endrow", end);
		pp.putParamMap("pagesize", pp.getNpagesize());//mysql用到的参数
		PageList<Map<String, Object>>	pageList = new PageList<Map<String, Object>>(pp, count, orderFoodsMapper.getSimpleInfoPage(pp.getParamMap()));
		return pageList;
	}

	@Transactional
	public void updateFoodStatus(List<OrderFoods> orderFoods)
	{
		for (OrderFoods order : orderFoods) 
		{
			orderFoodsMapper.update(order);
		}
		
	}

}
