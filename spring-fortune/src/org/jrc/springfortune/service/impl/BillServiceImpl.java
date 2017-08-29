package org.jrc.springfortune.service.impl;




import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jrc.common.utils.Arith;
import org.jrc.common.utils.Utils;
import org.jrc.springfortune.entity.Bill;
import org.jrc.springfortune.entity.Location;
import org.jrc.springfortune.entity.MenuFood;
import org.jrc.springfortune.entity.OrderFoods;
import org.jrc.springfortune.entity.ReservationInfo;
import org.jrc.springfortune.entity.TakeOutInfo;
import org.jrc.springfortune.mapper.BillMapper;
import org.jrc.springfortune.mapper.LocationMapper;
import org.jrc.springfortune.mapper.MenuFoodMapper;
import org.jrc.springfortune.mapper.OrderFoodsMapper;
import org.jrc.springfortune.mapper.ReservationInfoMapper;
import org.jrc.springfortune.mapper.TakeOutInfoMapper;
import org.jrc.springfortune.service.IBillService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Description:实现类
 * @author danty.Lee
 * @version 1.0
 * @created 
 */
@Service(value="billService")
public class BillServiceImpl extends BaseServiceImpl<Bill,BillMapper> implements IBillService,InitializingBean {

	@Autowired
	private BillMapper billMapper;
	@Autowired
	private MenuFoodMapper foodMapper;
	@Autowired
	private LocationMapper locationMapper;
	@Autowired
	private OrderFoodsMapper orderFoodsMapper;
	@Autowired
	private ReservationInfoMapper reservationInfoMapper;
	@Autowired
	private TakeOutInfoMapper takeOutInfoMapper;
	
	
	public void afterPropertiesSet() throws Exception {
		this.setBaseMapper(billMapper);
	}

	@Transactional
	public int addOrderBill(ReservationInfo reservationInfo, String idArray,String numArray,String loginName,String tableId,String peopleNum) 
	{
		int backNum = 0;
		Map<String, Object> param = new HashMap<String, Object>();
		if(!"".equals(idArray))
		{//有菜单
			String id[] = idArray.split(",");
			String num[] = numArray.split(",");
			double totalPrice = 0;
			List<OrderFoods> orderFoods = new ArrayList<OrderFoods>();
			for (int i = 0; i < id.length; i++) 
			{
				param.clear();
				param.put("id", id[i]);
				MenuFood food = foodMapper.get(param);
				//正常情况不应该为NULL，为NULL暂时不做处理(页面改数据，删除数据)
				if(food != null)
				{
					double price = Arith.mul(food.getPrice(), num[i]);
					totalPrice = Arith.add(totalPrice, price);
					//订单信息
					OrderFoods order = new OrderFoods();
					order.setTypeName(food.getMenuTypeName());
					order.setName(food.getName());
					order.setNameNumber(food.getNameNumber());
					order.setNum(Utils.parseDouble(num[i], 0));
					order.setPrice(food.getPrice());
					//1：待处理 2:处理中：3：做好  4：已上 9：取消
					order.setStatus(1);
					order.setCreator(loginName);
					order.setCreateTime(new Date());
					order.setMenuId(food.getId());
					orderFoods.add(order);
				}else{
					backNum++;
				}
				
			}
			//处理账单
			Bill bill = new Bill();
			if(!"".equals(tableId))
			{
				param.clear();
				param.put("id", tableId);
				Location table = locationMapper.get(param);
				if(table != null)
				{
					bill.setLocationNumber(table.getLocationNumber());
					//更改位置状态1:可用 2：用餐中 3：预定
					table.setStatus(3);
					locationMapper.update(table);
				}
			}
			String billNumber = getSerialNumber();
			bill.setBillNumber(billNumber);
			//1：未付 2：已付 9：删除
			bill.setStatus(1);
			bill.setCreateTime(new Date());
			bill.setArMoney(totalPrice);
			bill.setCreator(loginName);
			//1:店内用餐 2：预约 3：外卖
			bill.setType(2);
			bill.setUserNum(Utils.parseInt(peopleNum, 0));
			bill.setMemo(reservationInfo.getMemo());
			billMapper.insert(bill);
			
			
			//处理订单
			for (OrderFoods order : orderFoods)
			{
				order.setBillId(bill.getId());
				orderFoodsMapper.insert(order);
			}
			
			//处理预约信息
			reservationInfo.setBillId(bill.getId());
			reservationInfoMapper.insert(reservationInfo);
		}else{//没有菜单
			reservationInfoMapper.insert(reservationInfo);
		}
		return backNum;
		
	}

	@Transactional
	public int addShopBill(String ids, String nums, String tableId,String peopleNum, String loginName,String memo)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		
		int backNum = 0;
		
		String id[] = ids.split(",");
		String num[] = nums.split(",");
		
		double totalPrice = 0;
		List<OrderFoods> orderFoods = new ArrayList<OrderFoods>();
		for (int i = 0; i < id.length; i++) 
		{
			param.clear();
			param.put("id", id[i]);
			MenuFood food = foodMapper.get(param);
			//正常情况不应该为NULL，为NULL暂时不做处理(页面改数据，删除数据)
			if(food != null)
			{
				double price = Arith.mul(food.getPrice(), num[i]);
				totalPrice = Arith.add(totalPrice, price);
				//订单信息
				OrderFoods order = new OrderFoods();
				order.setTypeName(food.getMenuTypeName());
				order.setName(food.getName());
				order.setNameNumber(food.getNameNumber());
				order.setNum(Utils.parseDouble(num[i], 0));
				order.setPrice(food.getPrice());
				//1：待处理 2:处理中：3：做好  4：已上 9：取消
				order.setStatus(1);
				order.setCreator(loginName);
				order.setCreateTime(new Date());
				order.setMenuId(food.getId());
				orderFoods.add(order);
			}else{
				backNum++;
			}
		}
		
		
		//处理账单
		Bill bill = new Bill();
		if(!"".equals(tableId))
		{
			param.clear();
			param.put("id", tableId);
			Location table = locationMapper.get(param);
			if(table != null)
			{
				bill.setLocationNumber(table.getLocationNumber());
				//更改位置状态1:可用 2：用餐中 3：预定
				table.setStatus(2);
				locationMapper.update(table);
			}
		}
		String billNumber = getSerialNumber();
		bill.setBillNumber(billNumber);
		//1：未付 2：已付 9：删除
		bill.setStatus(1);
		bill.setCreateTime(new Date());
		bill.setArMoney(totalPrice);
		bill.setCreator(loginName);
		//1:店内用餐 2：预约 3：外卖
		bill.setType(1);
		bill.setUserNum(Utils.parseInt(peopleNum, 0));
		bill.setMemo(memo);
		billMapper.insert(bill);
		
		
		//处理订单
		for (OrderFoods order : orderFoods)
		{
			order.setBillId(bill.getId());
			orderFoodsMapper.insert(order);
		}
		
		return backNum;
	}

	@Transactional
	public int addTakeAwayBill(TakeOutInfo takeOutInfo, String idArray,String numArray, String loginName,String peopleNum)
	{
		int backNum = 0;
		Map<String, Object> param = new HashMap<String, Object>();
		
		
		String id[] = idArray.split(",");
		String num[] = numArray.split(",");
		double totalPrice = 0;
		List<OrderFoods> orderFoods = new ArrayList<OrderFoods>();
		for (int i = 0; i < id.length; i++) 
		{
			param.clear();
			param.put("id", id[i]);
			MenuFood food = foodMapper.get(param);
			//正常情况不应该为NULL，为NULL暂时不做处理(页面改数据，删除数据)
			if(food != null)
			{
				double price = Arith.mul(food.getPrice(), num[i]);
				totalPrice = Arith.add(totalPrice, price);
				//订单信息
				OrderFoods order = new OrderFoods();
				order.setTypeName(food.getMenuTypeName());
				order.setName(food.getName());
				order.setNameNumber(food.getNameNumber());
				order.setNum(Utils.parseDouble(num[i], 0));
				order.setPrice(food.getPrice());
				//1：待处理 2:处理中：3：做好  4：已上 9：取消
				order.setStatus(1);
				order.setCreator(loginName);
				order.setCreateTime(new Date());
				order.setMenuId(food.getId());
				orderFoods.add(order);
			}else{
				backNum++;
			}
		}
		//处理账单
		Bill bill = new Bill();
		String billNumber = getSerialNumber();
		bill.setBillNumber(billNumber);
		//1：未付 2：已付 9：删除
		bill.setStatus(1);
		bill.setCreateTime(new Date());
		bill.setArMoney(totalPrice);
		bill.setCreator(loginName);
		//1:店内用餐 2：预约 3：外卖
		bill.setType(3);
		bill.setUserNum(Utils.parseInt(peopleNum, 0));
		bill.setMemo(takeOutInfo.getMemo());
		billMapper.insert(bill);
		
		
		//处理订单
		for (OrderFoods order : orderFoods)
		{
			order.setBillId(bill.getId());
			orderFoodsMapper.insert(order);
		}
		
		//外卖信息
		takeOutInfo.setBillId(bill.getId());
		takeOutInfoMapper.insert(takeOutInfo);
		
		return backNum;
	}

	@Transactional
	public void editOrderFoodStatus(List<OrderFoods> editFoodsStatus,int status)
	{
		for (OrderFoods orderFoods : editFoodsStatus) 
		{
			orderFoodsMapper.update(orderFoods);
		}
		//删除后重新计算价格
		if(status == 9)
		{
			setBillMoney(editFoodsStatus.get(0).getBillId());
		}
		
	}
	
	
	@Transactional
	public void editOrderFoodAmount(OrderFoods orderFoods) 
	{
		
		orderFoodsMapper.update(orderFoods);
		setBillMoney(orderFoods.getBillId());
	}
	
	
	
	@Transactional
	public void addNewBill(String[] id, String[] num, Bill bill,String loginName)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		for (int i = 0; i < id.length; i++) 
		{
			param.clear();
			param.put("id", id[i]);
			MenuFood food = foodMapper.get(param);
			if(food != null)
			{
				//订单信息
				OrderFoods order = new OrderFoods();
				order.setTypeName(food.getMenuTypeName());
				order.setName(food.getName());
				order.setNameNumber(food.getNameNumber());
				order.setNum(Utils.parseDouble(num[i], 0));
				order.setPrice(food.getPrice());
				//1：待处理 2:处理中：3：做好  4：已上 9：取消
				order.setStatus(1);
				order.setCreator(loginName);
				order.setCreateTime(new Date());
				order.setMenuId(food.getId());
				order.setBillId(bill.getId());
				order.setUnit(food.getUnit());
				orderFoodsMapper.insert(order);
			}
		}
		
		//有新的订单，要更改账单支付状态    1：未付 2：已付 9：删除
		bill.setStatus(1); 
		billMapper.update(bill);
		setBillMoney(bill.getId());
		
	}
	
	
	@Transactional
	public void addNewFormBill(String ids, String nums, String loginName,Bill bill) 
	{
		Map<String, Object> param = new HashMap<String, Object>();
		if(!"".equals(ids))
		{
			String id [] = ids.split(",");
			String num [] = nums.split(",");
			for (int i = 0; i < id.length; i++) 
			{
				param.clear();
				param.put("id", id[i]);
				MenuFood food = foodMapper.get(param);
				if(food != null)
				{
					//订单信息
					OrderFoods order = new OrderFoods();
					order.setTypeName(food.getMenuTypeName());
					order.setName(food.getName());
					order.setNameNumber(food.getNameNumber());
					order.setNum(Utils.parseDouble(num[i], 0));
					order.setPrice(food.getPrice());
					//1：待处理 2:处理中：3：做好  4：已上 9：取消
					order.setStatus(1);
					order.setCreator(loginName);
					order.setCreateTime(new Date());
					order.setMenuId(food.getId());
					order.setBillId(bill.getId());
					order.setUnit(food.getUnit());
					orderFoodsMapper.insert(order);
				}
			}
			//有新的订单，要更改账单支付状态    1：未付 2：已付 9：删除
			bill.setStatus(1);
		}
		
		billMapper.update(bill);
		setBillMoney(bill.getId());
		
	}
	
	
	
	@Transactional
	public void updateBill(Bill bill) 
	{
		Map<String, Object> param = new HashMap<String, Object>();
		
		billMapper.update(bill);
		
		if(bill.getStatus() ==  2)
		{//账单收款  更改订单支付状态
			param.clear();
			param.put("billId", bill.getId());
			List<OrderFoods> orderFoods = orderFoodsMapper.list(param);
			for (OrderFoods food : orderFoods) 
			{
				//支付状态1:未付 2：已付
				food.setPayStatus(2);
				orderFoodsMapper.update(food);
			}
		}
		
		//删除的是预约的订单
		if(bill.getStatus() ==  9 && bill.getType() == 2)
		{
			param.clear();
			param.put("billId", bill.getId());
			ReservationInfo reservationInfo = reservationInfoMapper.list(param).get(0);
			reservationInfo.setStatus(9);
			reservationInfoMapper.update(reservationInfo);
		}
		
		if(bill.getLocationNumber() != null )
		{
			if(!"".equals(bill.getLocationNumber()))
			{
				param.clear();
				param.put("locationNum", bill.getLocationNumber());
				Location location = locationMapper.list(param).get(0);
				location.setStatus(1);
				location.setBillId(null);
				locationMapper.update(location);
			}
		}
	}
	
	
	
	
	
	@Transactional
	public Bill addPhoneBill(String ids, String nums, String tableId,String peopleNum, String loginName, String memo) {
		Map<String, Object> param = new HashMap<String, Object>();
		
		int backNum = 0;
		
		String id[] = ids.split(",");
		String num[] = nums.split(",");
		
		double totalPrice = 0;
		List<OrderFoods> orderFoods = new ArrayList<OrderFoods>();
		for (int i = 0; i < id.length; i++) 
		{
			param.clear();
			param.put("id", id[i]);
			MenuFood food = foodMapper.get(param);
			//正常情况不应该为NULL，为NULL暂时不做处理(页面改数据，删除数据)
			if(food != null)
			{
				double price = Arith.mul(food.getPrice(), num[i]);
				totalPrice = Arith.add(totalPrice, price);
				//订单信息
				OrderFoods order = new OrderFoods();
				order.setTypeName(food.getMenuTypeName());
				order.setName(food.getName());
				order.setNameNumber(food.getNameNumber());
				order.setNum(Utils.parseDouble(num[i], 0));
				order.setPrice(food.getPrice());
				//1：待处理 2:处理中：3：做好  4：已上 9：取消
				order.setStatus(1);
				order.setCreator(loginName);
				order.setCreateTime(new Date());
				order.setMenuId(food.getId());
				orderFoods.add(order);
			}else{
				backNum++;
				System.out.println("有"+backNum+"个菜单没有找到");
			}
		}
		
		
		//处理账单
		Bill bill = new Bill();
		if(!"".equals(tableId))
		{
			param.clear();
			param.put("id", tableId);
			Location table = locationMapper.get(param);
			if(table != null)
			{
				bill.setLocationNumber(table.getLocationNumber());
				//更改位置状态1:可用 2：用餐中 3：预定
				table.setStatus(2);
				locationMapper.update(table);
			}
		}
		String billNumber = getSerialNumber();
		bill.setBillNumber(billNumber);
		//1：未付 2：已付 9：删除
		bill.setStatus(1);
		bill.setCreateTime(new Date());
		bill.setArMoney(totalPrice);
		bill.setCreator(loginName);
		//1:店内用餐 2：预约 3：外卖
		bill.setType(1);
		bill.setUserNum(Utils.parseInt(peopleNum, 0));
		bill.setMemo(memo);
		billMapper.insert(bill);
		
		
		//处理订单
		for (OrderFoods order : orderFoods)
		{
			order.setBillId(bill.getId());
			orderFoodsMapper.insert(order);
		}
		
		return bill;
	}
	
	
	
	
	public void setBillMoney(long billId) 
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.clear();
		param.put("billId", billId);
		param.put("noDel", "noDel");
		List<OrderFoods> orderFoods = orderFoodsMapper.list(param);
		double totalPrice = 0;
		for (OrderFoods food : orderFoods) 
		{
			double price = Arith.mul(food.getPrice(), food.getNum());
			totalPrice = Arith.add(totalPrice, price);
		}
		
		
		//修改订单金额
		param.clear();
		param.put("id", billId);
		Bill bill = billMapper.get(param);
		bill.setArMoney(totalPrice);
		billMapper.update(bill);
		
	}

	@Transactional
	public int delReservation(String ids)
	{
		//0 ：正常  1：有已支付的记录
		int num = 0;
		Map<String, Object> param = new HashMap<String, Object>();
		
		String id [] = ids.split(",");
		for (int i = 0; i < id.length; i++) 
		{
			param.clear();
			param.put("id", id[i]);
			ReservationInfo reservationInfo = reservationInfoMapper.get(param);
			reservationInfo.setStatus(9);
			
			if(reservationInfo.getBillId() != null)
			{
				//有支付记录的不可以删除
				param.clear();
				param.put("billId", reservationInfo.getBillId());
				List<OrderFoods> foods = orderFoodsMapper.list(param);
				for (OrderFoods orderFoods : foods) 
				{
					if(orderFoods.getPayStatus() == 2)
					{
						num = 1;
						return num;
					}
				}
				
				param.clear();
				param.put("id", reservationInfo.getBillId());
				Bill bill = billMapper.get(param);
				bill.setStatus(9);
				billMapper.update(bill);
			} 
			
			
			
			
			reservationInfoMapper.update(reservationInfo);
		}
		
		
		
		return num;
	}

	

	
	

	


	

}
