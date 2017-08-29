package org.jrc.springfortune.entity;



import java.util.Date;


/**
 * 
 * @author danty.Lee
 * @version 1.0
 * @date Jun 18, 2007
 */
public class MenuFood {

	
	private Long id;
	
	private String name;
	
	private String nameNumber;
	
	private String memo;
	
	private Double price;
	
	private String creator;
	
	private String modifer;
	
	private Date createTime;
	
	private Date editTime;
	
	private Long menuTypeId;
	
	private Integer status;
	
	private String menuTypeName;
	
	private Integer unit;
	
	private Integer minLimitUnit;
	
	private String filePath;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNameNumber() {
		return nameNumber;
	}

	public void setNameNumber(String nameNumber) {
		this.nameNumber = nameNumber;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getModifer() {
		return modifer;
	}

	public void setModifer(String modifer) {
		this.modifer = modifer;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getEditTime() {
		return editTime;
	}

	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}

	public Long getMenuTypeId() {
		return menuTypeId;
	}

	public void setMenuTypeId(Long menuTypeId) {
		this.menuTypeId = menuTypeId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getMenuTypeName() {
		return menuTypeName;
	}

	public void setMenuTypeName(String menuTypeName) {
		this.menuTypeName = menuTypeName;
	}

	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}

	public Integer getMinLimitUnit() {
		return minLimitUnit;
	}

	public void setMinLimitUnit(Integer minLimitUnit) {
		this.minLimitUnit = minLimitUnit;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
}
