package com.zhaotianyue.hgshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
@Controller
@RequestMapping("brand")
public class BrandCtroller {
	@RequestMapping("list")
	public String list(@RequestParam(defaultValue="1") int page) {
		return "brand/list";
	}
}
