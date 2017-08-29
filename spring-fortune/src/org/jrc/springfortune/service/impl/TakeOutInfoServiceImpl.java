package org.jrc.springfortune.service.impl;


import org.jrc.springfortune.entity.TakeOutInfo;
import org.jrc.springfortune.mapper.TakeOutInfoMapper;
import org.jrc.springfortune.service.ITakeOutInfoService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="takeOutInfoService")
public class TakeOutInfoServiceImpl extends BaseServiceImpl<TakeOutInfo,TakeOutInfoMapper> implements ITakeOutInfoService,InitializingBean {

	@Autowired
	private TakeOutInfoMapper takeOutInfoMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(takeOutInfoMapper);
	}

}
