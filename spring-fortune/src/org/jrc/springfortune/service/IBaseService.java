package org.jrc.springfortune.service;

import java.util.List;
import java.util.Map;

import org.jrc.common.page.PageList;
import org.jrc.common.page.PageProperty;

public interface IBaseService<T> {
	
	/**
     * @Description:创建数据对象
     * @param po 实体对象
     */
    public abstract  Object insert(T po);
    
    /**
     * @Description:删除数据对象
     * @param param map参数
     * @return 所影响的行数
     */
    public abstract int delete(Map<String,Object> param);
    
    /**
     * @Description:单条修改数据对象
     * @param po 实体对象
     * @return 所影响的行数
     */
    public abstract int update(T po);
	
	/**
     * @Description:得到数据对象
     * @param param map参数
     * @return 实体对象
     */
    public abstract T get(Map<String,Object> param);
    
    /**
     * @Description:得到数据对象列表
     * @param param map参数
     * @return 实体列表
     */
    public abstract List<T> list(Map<String,Object> param);
    
    /**
     * @Description:得到数据数量按分页条件
     * @param pp PageProperty对象
     * @return 数据条数
     */
    public abstract int getCount(Map<String,Object> param);
 
    /**
     * @Description:得到数据对象列表按分页条件 当pp.getNpageSize=0时返回所有
     * @param pp PageProperty对象
     * @return 实体列表
     */
    public abstract PageList<T> getPageList(PageProperty pp);
    
    /**
     * 生成账单编号
     * @return
     */
    public String  getSerialNumber();

}
