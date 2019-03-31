package com.jxufe.service.impl;

import java.util.List;

import com.jxufe.entity.User;
import com.jxufe.entity.UserExample;
import com.jxufe.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jxufe.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public User findUserByName(String username) {
		// TODO Auto-generated method stub
		UserExample example = new UserExample();
		example.createCriteria().andUserNameEqualTo(username);
		List<User> selectByExample = userMapper.selectByExample(example);
		
		if(selectByExample.size() != 0){
			return selectByExample.get(0);
		}else{
			return null;
		}
		
	}
	
	@Override
	public User findUserByEmail(String email) {
		// TODO Auto-generated method stub
		UserExample example = new UserExample();
		example.createCriteria().andUserEmailEqualTo(email);
		List<User> selectByExample = userMapper.selectByExample(example);
		
		if(selectByExample.size() != 0){
			return selectByExample.get(0);
		}else{
			return null;
		}
		
	}

	@Override
	public String emailValidate(String email) {
		// TODO Auto-generated method stub
		UserExample example = new UserExample();
		example.createCriteria().andUserEmailEqualTo(email);
		List<User> selectByExample = userMapper.selectByExample(example);
		
		if(selectByExample.size() != 0){
			return "exist";
		}else{
			return "notExist";
		}
	}

	@Override
	public String register(User user) {
		// TODO Auto-generated method stub
		//，mybatis官方的讨论列表，这句很关键：“If the BATCH executor is in use, the update counts are being lost. ”  
		//会导致返回为-2147482646，而不是正确就返回条数，失败就返回0
		//一般我们都会开启batch的批量操作，所以建议不要通过影响条数进行结果判断。
		int insert = userMapper.insertSelective(user);
		System.out.println(insert);
		if(insert != 0){
			return "ok";
		}
		return null;
	}

	@Override
	public void updateUser(String username, String data) {
		// TODO Auto-generated method stub
		User user = new User();
		user.setUserPic(data);
		UserExample example = new UserExample();
		example.createCriteria().andUserNameEqualTo(username);
		userMapper.updateByExampleSelective(user, example);
		
	}

	

}
