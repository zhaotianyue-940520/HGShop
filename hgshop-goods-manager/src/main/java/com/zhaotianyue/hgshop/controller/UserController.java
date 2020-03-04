package com.zhaotianyue.hgshop.controller;

import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zhaotianyue.hgshop.service.UserService;


@Controller
public class UserController {
	
	
	@Reference(timeout=2000,version="1.0.0")
	UserService userService;
	
	
	@RequestMapping("tologin")
	public String toLogin() {
		return "login";
	}
	
	@RequestMapping("login")
	public String login(String name,String password ) {
		
		if(userService.login(name, password))
			return "redirect:/";
		else {
			return "tologin";
		}
	}

}
