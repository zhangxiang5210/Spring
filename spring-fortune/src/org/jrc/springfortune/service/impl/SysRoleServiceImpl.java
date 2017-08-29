package org.jrc.springfortune.service.impl;


import org.jrc.springfortune.entity.SysRole;
import org.jrc.springfortune.mapper.SysRoleMapper;
import org.jrc.springfortune.service.ISysRoleService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="sysRoleService")
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole,SysRoleMapper> implements ISysRoleService,InitializingBean {

	@Autowired
	private SysRoleMapper sysRoleMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(sysRoleMapper);
	}

}
