package com.zhaotianyue.hgshop.service.impl;

import org.apache.dubbo.config.annotation.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.zhaotianyue.hgshop.config.AdminProperties;
import com.zhaotianyue.hgshop.dao.UserMapper;
import com.zhaotianyue.hgshop.service.UserService;



@Service(interfaceClass=UserService.class,version="1.0.0")
public class UserServiceImpl implements UserService{
	
	@Autowired
	AdminProperties adminProperties;
	@Autowired
	UserMapper UserMapper;
	@Override
	public boolean login(String userName, String passWord) {
		
		int login = UserMapper.login(userName,passWord);
		if(login>0) {
			return true;
		}else {
			return false;
		}
		
	}

}
