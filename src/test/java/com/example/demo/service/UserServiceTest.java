package com.example.demo.service;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.example.demo.DemoApplication;
import com.example.demo.domain.Search;
import com.example.demo.domain.User;
import com.github.pagehelper.Page;

import lombok.extern.slf4j.Slf4j;

@ExtendWith(SpringExtension.class) //Junit4의 Runwith과 같은 기능을 하는 Junit5 어노테이션 
@SpringBootTest(classes = DemoApplication.class) // Junit5 기준 Application Context사용할 때 사용
@TestMethodOrder(MethodOrderer.OrderAnnotation.class) // Order를 붙일 때 사용
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)	// 진짜 데이터베이스 테스트
@Slf4j
public class UserServiceTest {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private UserService userService;
	
	@Test
	public void findAllPagingTest() {
		Search search = new Search();
		search.setKeyword("id");
		search.setContent("aaaa");
		
		Page<User> users = userService.getAllUserPaging(1, 2, search);
		
		users.forEach(x->logger.info(x.toString()));
		
	}
	
	
}
