package org.jrc.springfortune.entity;


import java.util.Date;


/**
 * 
 * @author danty.Lee
 * @version 1.0
 * @date Jun 18, 2007
 */
public class LoginUser {

	private Long id;
	
	private String loginName;
	
	private String password;
	
	private String phone;
	
	private Integer userType;
	
	private Date lastLoginTime;
	
	private String lastLoginIp;
	
	private Integer status;
	
	private Date regsiterTime;
	
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public String getLoginName() {
		return this.loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public Integer getUserType() {
		return this.userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}
	
	public Date getLastLoginTime() {
		return this.lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	
	public String getLastLoginIp() {
		return this.lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Date getRegsiterTime() {
		return this.regsiterTime;
	}

	public void setRegsiterTime(Date regsiterTime) {
		this.regsiterTime = regsiterTime;
	}
	
}
