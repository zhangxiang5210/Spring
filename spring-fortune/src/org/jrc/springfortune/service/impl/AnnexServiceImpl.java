package org.jrc.springfortune.service.impl;



import org.jrc.springfortune.entity.Annex;
import org.jrc.springfortune.mapper.AnnexMapper;
import org.jrc.springfortune.service.IAnnexService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:实现类
 * @author 
 * @version 1.0
 * @created 
 */
@Service(value="annexService")
public class AnnexServiceImpl extends BaseServiceImpl<Annex,AnnexMapper> implements IAnnexService,InitializingBean {

	@Autowired
	private AnnexMapper annexMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(annexMapper);
	}

}
