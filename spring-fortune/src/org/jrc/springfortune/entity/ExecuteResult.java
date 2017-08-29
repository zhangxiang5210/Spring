package org.jrc.springfortune.entity;

public class ExecuteResult {
	
	private boolean success; //是否成功
	
	private String msg; //返回信息
	
	private String value;//返回值

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	

}
