package com.example.demo.service;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.example.demo.DemoApplication;
import com.example.demo.domain.User;
import com.github.pagehelper.Page;

import lombok.extern.slf4j.Slf4j;

@ExtendWith(SpringExtension.class) //Junit4의 Runwith과 같은 기능을 하는 Junit5 어노테이션 
@SpringBootTest(classes = DemoApplication.class) // Junit5 기준 Application Context사용할 때 사용
@TestMethodOrder(MethodOrderer.OrderAnnotation.class) // Order를 붙일 때 사용
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)	// 진짜 데이터베이스 테스트
@Slf4j
public class UserServiceTest {
	
	@Autowired
	private UserService userService;
	
	@Test
	public void findAllPagingTest() {
		Page<User> users = userService.getAllUserPaging(1, 2);
		
		users.forEach(x->log.info(x.toString()));
	}
	
	
}
