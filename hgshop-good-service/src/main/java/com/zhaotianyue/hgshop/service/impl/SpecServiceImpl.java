package com.zhaotianyue.hgshop.service.impl;

import java.util.List;

import org.apache.dubbo.config.annotation.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zhaotianyue.hgshop.dao.SpecDao;
import com.zhaotianyue.hgshop.pojo.Spec;
import com.zhaotianyue.hgshop.pojo.SpecOption;
import com.zhaotianyue.hgshop.service.SpecService;

@Service(interfaceClass=SpecService.class)
public class SpecServiceImpl implements SpecService{
	
	@Autowired
	SpecDao specDao;

	@Override
	public PageInfo<Spec> list(String name, int page) {
		// TODO Auto-generated method stub
		PageHelper.startPage(page, 3);
		return new PageInfo<Spec>(specDao.list(name));
		
	}

	@Override
	public int add(Spec spec) {
		// TODO Auto-generated method stub
		//添加主表
		specDao.addSpec(spec);
		// 这里才能获取到主键ID
		//添加子表
		List<SpecOption> options = spec.getOptions();
		//
		int n=1;
		for (SpecOption specOption : options) {
			// 设置主表的id
			specOption.setSpecId(spec.getId());
			specDao.addOption(specOption);
			n++;
		}
		
		// 返回的是影响数据的条数
		return n;
	}

	
	@Override
	public int update(Spec spec) {
		// TODO Auto-generated method stub
		return specDao.updateSpec(spec);
	}
	

	@Override
	public int delete(int id) {
		// TODO Auto-generated method stub
		//删除子表
		specDao.deleteSpecOtions(id);
		//删除主表
		specDao.deleteSpec(id);
		return 1;
	}

	@Override
	public Spec findById(int id) {
		// TODO Auto-generated method stub
		
		return specDao.get(id);
	}

	@Override
	public int deleteBatch(int[] ids) {
		// TODO Auto-generated method stub
		//删除子表
		specDao.deleteSpecOtionsBatch(ids);
		//删除主表
		specDao.deleteSpecBatch(ids);
		return 1;
	}
	
	

}
