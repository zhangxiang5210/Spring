package org.jrc.springfortune.service;



import java.util.List;

import org.jrc.springfortune.entity.Bill;
import org.jrc.springfortune.entity.OrderFoods;
import org.jrc.springfortune.entity.ReservationInfo;
import org.jrc.springfortune.entity.TakeOutInfo;

/**
 * @Description: 逻辑层接口
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
public interface IBillService extends IBaseService<Bill> {

	/**
	 * 预约
	 * @param reservationInfo
	 * @param idArray
	 * @param numArray
	 */
	public int addOrderBill(ReservationInfo reservationInfo,String idArray,String numArray,String loginName,String tableId,String peopleNum);
	
	/**
	 * 店内订单
	 * @param ids
	 * @param nums
	 * @param tableId
	 * @param peopleNum
	 * @param loginName
	 * @return
	 */
	public int addShopBill(String ids,String nums,String tableId,String peopleNum,String loginName,String memo);
	
	/**
	 * 外卖订单
	 * @param takeOutInfo
	 * @param idArray
	 * @param numArray
	 * @param loginName
	 * @return
	 */
	public int addTakeAwayBill(TakeOutInfo takeOutInfo,String idArray,String numArray,String loginName,String peopleNum);
	
	
	/**
	 * 修改订单状态
	 * @param idArray
	 * @param status
	 */
	public void editOrderFoodStatus(List<OrderFoods> editFoodsStatus,int status);
	
	/**
	 * 以斤计算修改量
	 */
	public void editOrderFoodAmount(OrderFoods orderFoods);
	
	/**
	 * 账单编辑，新增订单
	 */
	public void addNewBill(String[] id, String[] num,Bill bill,String loginName);
	
	/**
	 * 账单编辑，新增订单
	 */
	public void addNewFormBill(String ids, String nums,String loginName,Bill bill);
	
	
	/**
	 * 账单收款、账单删除
	 * @param bill
	 */
	public void updateBill(Bill bill);
	
	public int delReservation(String ids);
	
	/**
	 * @param ids
	 * @param nums
	 * @param tableId
	 * @param peopleNum
	 * @param loginName
	 * @param memo
	 * @return
	 */
	public Bill addPhoneBill(String ids,String nums,String tableId,String peopleNum,String loginName,String memo);
	
	
}