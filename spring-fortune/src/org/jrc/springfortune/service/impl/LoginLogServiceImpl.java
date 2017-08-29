package org.jrc.springfortune.service.impl;


import org.jrc.springfortune.entity.LoginLog;
import org.jrc.springfortune.mapper.LoginLogMapper;
import org.jrc.springfortune.service.ILoginLogService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="loginLogService")
public class LoginLogServiceImpl extends BaseServiceImpl<LoginLog,LoginLogMapper> implements ILoginLogService,InitializingBean {

	@Autowired
	private LoginLogMapper loginLogMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(loginLogMapper);
	}

}
