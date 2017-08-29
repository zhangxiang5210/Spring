package org.jrc.springfortune.entity;


import java.util.Date;


/**
 * 
 * @author danty.Lee
 * @version 1.0
 * @date Jun 18, 2007
 */
public class OrderFoods {

	private Long id;
	
	private String typeName;
	
	private String name;
	
	private String nameNumber;
	
	private Double num;
	
	private Double price;
	
	private Integer status;
	
	private String creator;
	
	private Date createTime;
	
	private String memo;
	
	private Long billId;
	
	private Long menuId;
	
	private Integer unit;
	
	private String operationPerson;
	
	private String delPerson;
	
	private Integer payStatus;
	
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getNameNumber() {
		return this.nameNumber;
	}

	public void setNameNumber(String nameNumber) {
		this.nameNumber = nameNumber;
	}
	
	
	
	public Double getNum() {
		return num;
	}

	public void setNum(Double num) {
		this.num = num;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public String getCreator() {
		return this.creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	
	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	public Long getBillId() {
		return this.billId;
	}

	public void setBillId(Long billId) {
		this.billId = billId;
	}
	
	public Long getMenuId() {
		return this.menuId;
	}

	public void setMenuId(Long menuId) {
		this.menuId = menuId;
	}

	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}

	public String getOperationPerson() {
		return operationPerson;
	}

	public void setOperationPerson(String operationPerson) {
		this.operationPerson = operationPerson;
	}

	public String getDelPerson() {
		return delPerson;
	}

	public void setDelPerson(String delPerson) {
		this.delPerson = delPerson;
	}

	public Integer getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(Integer payStatus) {
		this.payStatus = payStatus;
	}
	
}
