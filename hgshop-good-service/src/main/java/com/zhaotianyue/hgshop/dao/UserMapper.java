package com.zhaotianyue.hgshop.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface UserMapper {
	@Select("select COUNT(*) from hg_user where username=#{userName} and password=#{passWord} ")
	int login(@Param("userName")String userName, @Param("passWord")String passWord);

}
