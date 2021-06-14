package com.example.demo.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.domain.Search;
import com.example.demo.domain.User;
import com.example.demo.mapper.UserMapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class UserService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private UserMapper usermapper;
	
	public PageInfo<User> getAllUser (int pageNo, int pageSize, Search search) {
		List<User> users = usermapper.findAll();
		logger.info("[getAllUser] users is {}", users.toString());
		
		PageInfo<User> pageInfo = new PageInfo<>(users, 10);
		
		return pageInfo;
	}
	
	public User getUserById(String id) {
		logger.info("[getUserById] id is {}", id);
		User user = usermapper.findById(id);
		logger.info("[getUserById] info is {}", user.toString());
		return user; 
	}
	
	public void saveUser(User user) {
		logger.info("[saveUser] user is {}", user.toString());
		usermapper.save(user);
	}
	
	public void deleteById(String id) {
		logger.info("[deleteById] id is {}", id);
		usermapper.deleteById(id);
	}
}
