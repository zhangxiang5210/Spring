package org.jrc.springfortune.service.impl;


import org.jrc.springfortune.entity.SysRoleAction;
import org.jrc.springfortune.mapper.SysRoleActionMapper;
import org.jrc.springfortune.service.ISysRoleActionService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="sysRoleActionService")
public class SysRoleActionServiceImpl extends BaseServiceImpl<SysRoleAction,SysRoleActionMapper> implements ISysRoleActionService,InitializingBean {

	@Autowired
	private SysRoleActionMapper sysRoleActionMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(sysRoleActionMapper);
	}

}
