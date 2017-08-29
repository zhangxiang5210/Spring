package org.jrc.springfortune.service.impl;


import org.jrc.springfortune.entity.MenuType;
import org.jrc.springfortune.mapper.MenuTypeMapper;
import org.jrc.springfortune.service.IMenuTypeService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="menuTypeService")
public class MenuTypeServiceImpl extends BaseServiceImpl<MenuType,MenuTypeMapper> implements IMenuTypeService,InitializingBean {

	@Autowired
	private MenuTypeMapper menuTypeMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(menuTypeMapper);
	}

}
