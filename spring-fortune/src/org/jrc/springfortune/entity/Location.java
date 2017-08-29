package org.jrc.springfortune.entity;


/**
 * 
 * @author johnny.Lu
 * @version 1.0
 * @date Jun 18, 2007
 */
public class Location {

	private Long id;
	
	private String locationNumber;
	
	private Integer status;
	
	private Long billId;
	
	private String memo;
	
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
	
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Long getBillId() {
		return this.billId;
	}

	public void setBillId(Long billId) {
		this.billId = billId;
	}
	
	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}
