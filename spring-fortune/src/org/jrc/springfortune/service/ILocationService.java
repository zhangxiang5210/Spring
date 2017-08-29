package org.jrc.springfortune.service;

import java.util.Map;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;
import org.jrc.springfortune.entity.Location;



/**
 * @Description: 逻辑层接口
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
public interface ILocationService extends IBaseService<Location> {

	PageList<Map<String, Object>> getTableList(PageProperty pp);
	
	public void delTable(String idArray);
	
	public void updateStatus(String idArray,int status);
}