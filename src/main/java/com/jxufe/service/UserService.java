package com.jxufe.service;

import com.jxufe.entity.User;

public interface UserService {
	
	public User findUserByName(String username);
	
	public User findUserByEmail(String email);
	
	public String emailValidate(String email);
	
	public String register(User user);
	
	public void updateUser(String username, String data);


}
