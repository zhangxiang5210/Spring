package org.jrc.springfortune.entity;


public class SessionUser
{
	//登录用户
	private LoginUser user;
	//未读消息数
	private int msgCount;

	public LoginUser getUser() {
		return user;
	}

	public void setUser(LoginUser user) {
		this.user = user;
	}

	public int getMsgCount() {
		return msgCount;
	}

	public void setMsgCount(int msgCount) {
		this.msgCount = msgCount;
	}
	
	
	
}