package org.jrc.springfortune.mapper;

import java.util.List;
import java.util.Map;

import org.jrc.springfortune.entity.Location;



/**
 * @Description: 接口
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
public interface LocationMapper extends BaseMapper<Location>{

	public  int getTableListCount(Map<String,Object> param);
	
	List<Map<String, Object>> getTableList(Map<String, Object> pp);

}
