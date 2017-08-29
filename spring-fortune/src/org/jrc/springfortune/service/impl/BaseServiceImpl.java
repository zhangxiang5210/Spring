package org.jrc.springfortune.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;
import org.jrc.common.utils.PageUtil;
import org.jrc.springfortune.mapper.BaseMapper;
import org.jrc.springfortune.service.IBaseService;


public class BaseServiceImpl<T,I extends BaseMapper<T>> implements IBaseService<T>{
	
	private I baseMapper;

	public I getBaseMapper() {
		return baseMapper;
	}

	public void setBaseMapper(I baseMapper) {
		this.baseMapper = baseMapper;
	}

	public Object insert(T po) {
		return baseMapper.insert(po);
	}

	public int delete(Map<String, Object> param) {
		return baseMapper.delete(param);
	}

	public int update(T po) {
		return baseMapper.update(po);
	}

	public T get(Map<String, Object> param) {
		return baseMapper.get(param);
	}

	public List<T> list(Map<String, Object> param) {
		return baseMapper.list(param);
	}

	public int getCount(Map<String,Object> param) {
		return baseMapper.getCount(param);
	}
	
	public PageList<T> getPageList(PageProperty pp) {
		int count = baseMapper.getCount(pp.getParamMap());
		int start = PageUtil.getStart(pp.getNpage(), count, pp.getNpagesize());
		int end = PageUtil.getEnd(pp.getNpage(), count, pp.getNpagesize());
		pp.putParamMap("startrow", start);
		pp.putParamMap("endrow", end);
		pp.putParamMap("pagesize", pp.getNpagesize());//mysql用到的参数
		PageList<T>	pageList = new PageList<T>(pp, count, baseMapper.getSplitList(pp.getParamMap()));
		return pageList;
	}

	/**
     * 生成账单编号
     * @return
     */
	public String getSerialNumber() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new Date());
		Random random = new Random();
		StringBuffer sb = new StringBuffer();  
		sb.append(date);
		for (int i = 0; i < 6; i++) 
		{
			sb.append(random.nextInt(10));
		}
		return sb+"";
	}

}
