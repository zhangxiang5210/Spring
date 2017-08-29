package org.jrc.springfortune.service.impl;


import org.jrc.springfortune.entity.LoginUser;
import org.jrc.springfortune.mapper.LoginUserMapper;
import org.jrc.springfortune.service.ILoginUserService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="loginUserService")
public class LoginUserServiceImpl extends BaseServiceImpl<LoginUser,LoginUserMapper> implements ILoginUserService,InitializingBean {

	@Autowired
	private LoginUserMapper loginUserMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(loginUserMapper);
	}

}
