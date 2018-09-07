package com.jxufe.utils;

public class User {
	
	String username;
	
	String password;
	

	public User(String name, String psw) {
		this.username = name;
		this.password = psw;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}
	
	

}
