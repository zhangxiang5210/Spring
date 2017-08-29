package org.jrc.springfortune.service.impl;


import org.jrc.springfortune.entity.SysRoleUser;
import org.jrc.springfortune.mapper.SysRoleUserMapper;
import org.jrc.springfortune.service.ISysRoleUserService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="sysRoleUserService")
public class SysRoleUserServiceImpl extends BaseServiceImpl<SysRoleUser,SysRoleUserMapper> implements ISysRoleUserService,InitializingBean {

	@Autowired
	private SysRoleUserMapper sysRoleUserMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(sysRoleUserMapper);
	}

}
