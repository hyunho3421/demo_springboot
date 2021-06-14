package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.domain.Search;
import com.example.demo.domain.User;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;

@Mapper
public interface UserMapper {
	List<User> findAll(Search search);
	User findById(String id);
	int save(User user);
	int deleteById(String id);
}
