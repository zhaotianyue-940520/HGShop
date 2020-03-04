package com.zhaotianyue.hgshop.service;

import java.util.List;

import com.github.pagehelper.PageInfo;
import com.zhaotianyue.hgshop.pojo.Brand;
import com.zhaotianyue.hgshop.pojo.Category;

public interface GoodsService {
	
	int addBrand(Brand brand);
	int updateBrand(Brand brand);
	int deleteBrand(Integer id);
	PageInfo<Brand> listBrand (String firstChar,int pageNum);
	
	int addCategory(Category category);
	int updateCategory(Category category);
	int deleteCategory(Integer id);
	PageInfo<Category> listCategory(String firstChar,int pageNum);
	List<Category> treeCategory();
}
