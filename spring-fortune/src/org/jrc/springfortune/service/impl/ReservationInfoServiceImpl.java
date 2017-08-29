package org.jrc.springfortune.service.impl;


import org.jrc.springfortune.entity.ReservationInfo;
import org.jrc.springfortune.mapper.ReservationInfoMapper;
import org.jrc.springfortune.service.IReservationInfoService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="reservationInfoService")
public class ReservationInfoServiceImpl extends BaseServiceImpl<ReservationInfo,ReservationInfoMapper> implements IReservationInfoService,InitializingBean {

	@Autowired
	private ReservationInfoMapper reservationInfoMapper;
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(reservationInfoMapper);
	}

}
