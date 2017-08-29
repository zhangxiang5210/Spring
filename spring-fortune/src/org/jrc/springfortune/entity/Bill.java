package org.jrc.springfortune.entity;


import java.util.Date;


/**
 * 
 * @author danty.Lee
 * @version 1.0
 * @date Jun 18, 2007
 */
public class Bill {

	private Long id;
	
	private String locationNumber;
	
	private String billNumber;
	
	private Integer status;
	
	private Date createTime;
	
	private Date receiveTime;
	
	private String receiveLonginName;
	
	private Double arMoney;
	
	private Double payMoney;
	
	private String creator;
	
	private String receiveName;
	
	private String memo;
	
	private Integer type;
	
	private Integer receiveType;
	
	private Integer receiveWay;
	
	private Integer userNum;
	
	private String billMemo;
	
	private Integer menuCount;
	
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public String getLocationNumber() {
		return this.locationNumber;
	}

	public void setLocationNumber(String locationNumber) {
		this.locationNumber = locationNumber;
	}
	
	public String getBillNumber() {
		return this.billNumber;
	}

	public void setBillNumber(String billNumber) {
		this.billNumber = billNumber;
	}
	
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Date getReceiveTime() {
		return this.receiveTime;
	}

	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}
	
	public String getReceiveLonginName() {
		return this.receiveLonginName;
	}

	public void setReceiveLonginName(String receiveLonginName) {
		this.receiveLonginName = receiveLonginName;
	}
	
	public Double getArMoney() {
		return this.arMoney;
	}

	public void setArMoney(Double arMoney) {
		this.arMoney = arMoney;
	}
	
	public Double getPayMoney() {
		return this.payMoney;
	}

	public void setPayMoney(Double payMoney) {
		this.payMoney = payMoney;
	}
	
	public String getCreator() {
		return this.creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	
	public String getReceiveName() {
		return this.receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}
	
	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	public Integer getReceiveType() {
		return this.receiveType;
	}

	public void setReceiveType(Integer receiveType) {
		this.receiveType = receiveType;
	}
	
	public Integer getReceiveWay() {
		return this.receiveWay;
	}

	public void setReceiveWay(Integer receiveWay) {
		this.receiveWay = receiveWay;
	}

	public Integer getUserNum() {
		return userNum;
	}

	public void setUserNum(Integer userNum) {
		this.userNum = userNum;
	}

	public String getBillMemo() {
		return billMemo;
	}

	public void setBillMemo(String billMemo) {
		this.billMemo = billMemo;
	}

	public Integer getMenuCount() {
		return menuCount;
	}

	public void setMenuCount(Integer menuCount) {
		this.menuCount = menuCount;
	}

	
	
}
