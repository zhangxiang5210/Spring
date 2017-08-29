package org.jrc.springfortune.entity;


import java.util.Date;


/**
 * 
 * @author danty.Lee
 * @version 1.0
 * @date Jun 18, 2007
 */
public class MenuType {

	private Long id;
	
	private String typeName;
	
	private String memo;
	
	private String creator;
	
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
	
	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	public String getCreator() {
		return this.creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	
}
