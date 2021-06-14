package com.example.demo.controller;


import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.domain.User;
import com.example.demo.service.UserService;

@Controller
@RequestMapping("/")
public class TestController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private DataSource dataSource;
	
	@GetMapping("/test")
	public String test() throws SQLException {
		
		logger.info("/test");
		logger.info("[test] DataSource is {}", dataSource.getClass());
		logger.info("[test] DataSource url is {}", dataSource.getConnection().getMetaData().getURL());
		logger.info("[test] DataSource username is {}", dataSource.getConnection().getMetaData().getUserName());
		
		return "test";
	}

}
