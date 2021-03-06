package com.zhaotianyue.hgshop.controller;

import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.zhaotianyue.hgshop.pojo.Spec;
import com.zhaotianyue.hgshop.service.SpecService;

@Controller
@RequestMapping("spec")
public class SpecController {
	@Reference
	SpecService specService;
	
	@RequestMapping("list")
	public String list(Model m,@RequestParam(defaultValue="1") int page,@RequestParam(defaultValue="") String name) {
		 PageInfo<Spec> pageInfo = specService.list(name, page);
		 m.addAttribute("pageInfo", pageInfo);
		return "spec/list";
	}
	
	@RequestMapping("add")
	@ResponseBody
	public boolean add(Spec spec) {
		spec.getOptions().removeIf(x->{return x.getOptionName()==null;});
		//调用服务
		int add = specService.add(spec);
		return add>0;
	}
	
	@RequestMapping("delSpecBatch")
	@ResponseBody
	public boolean delSpecBatch(@RequestParam(name="ids[]") int[] ids) {
		//调用服务
		int delNum = specService.deleteBatch(ids);
		return delNum>0;
	}
	
	@RequestMapping("delSpec")
	@ResponseBody
	public boolean delSpec(int id) {
		//调用服务
		int delNum = specService.delete(id);
		return delNum>0;
	}
	
	@RequestMapping("getSpec")
	@ResponseBody
	public Spec getSpec(int id){
		return specService.findById(id);
	}
	
	@RequestMapping("update")
	@ResponseBody
	public boolean update(Spec spec) {
		spec.getOptions().removeIf(x->{return x.getOptionName()==null;});
		//调用服务
		int result = specService.update(spec);  
		return result >0;
	}
}
