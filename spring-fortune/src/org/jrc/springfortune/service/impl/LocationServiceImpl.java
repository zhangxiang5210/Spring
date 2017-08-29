package org.jrc.springfortune.service.impl;


import java.util.HashMap;
import java.util.Map;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;
import org.jrc.common.utils.PageUtil;
import org.jrc.common.utils.Utils;
import org.jrc.springfortune.entity.Location;
import org.jrc.springfortune.mapper.LocationMapper;
import org.jrc.springfortune.service.ILocationService;
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
@Service(value="locationService")
public class LocationServiceImpl extends BaseServiceImpl<Location,LocationMapper> implements ILocationService,InitializingBean {

	@Autowired
	private LocationMapper locationMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(locationMapper);
	}

	@Override
	public PageList<Map<String, Object>> getTableList(PageProperty pp) {
		int count = locationMapper.getTableListCount(pp.getParamMap());
		int start = PageUtil.getStart(pp.getNpage(), count, pp.getNpagesize());
		int end = PageUtil.getEnd(pp.getNpage(), count, pp.getNpagesize());
		pp.putParamMap("startrow", start);
		pp.putParamMap("endrow", end);
		pp.putParamMap("pagesize", pp.getNpagesize());//mysql用到的参数
		PageList<Map<String, Object>>	pageList = new PageList<Map<String, Object>>(pp, count, locationMapper.getTableList(pp.getParamMap()));
		return pageList;
	}

	@Transactional
	public void delTable(String idArray)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(!"".equals(idArray))
		{
			String id []  = idArray.split(",");
			for (int i = 0; i < id.length; i++) 
			{
				param.clear();
				param.put("id", Utils.parseLong(id[i], 0));
				locationMapper.delete(param);
			}
		}
		
		
	}

	@Override
	public void updateStatus(String idArray, int status) {
		Map<String, Object> param = new HashMap<String, Object>();
		if(!"".equals(idArray))
		{
			String id [] = idArray.split(",");
			for (int i = 0; i < id.length; i++) 
			{
				param.clear();
				param.put("id", id[i]);
				Location location = locationMapper.get(param);
				location.setStatus(status);
				locationMapper.update(location);
			}
		}
		
	}

	

}
