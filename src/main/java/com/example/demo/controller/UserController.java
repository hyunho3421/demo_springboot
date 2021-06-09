package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.domain.Search;
import com.example.demo.domain.User;
import com.example.demo.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/find/all")
	public String findAllUser(Model model) {
		
		List<User> users = userService.getAllUser();
		
		users.forEach(x -> {
			logger.info("user is {}", x.toString());
		});
		
		model.addAttribute("users", users);
		
		return "user_list";
	}
	
	@PostMapping("/ajax/find/all")
	public ResponseEntity<Map<String, Object>> findAllUser_ajax(Search search) {
		ResponseEntity<Map<String, Object>> entity;
		
		List<User> users = userService.getAllUser();
		
		users.forEach(x -> {
			logger.info("user is {}", x.toString());
		});
		
		Map<String, Object> map = new HashMap<>();
		map.put("users", users);
		entity = new ResponseEntity<>(map, HttpStatus.OK);
		
		return entity;
	}
	
	@GetMapping("/find/id/{id}")
	public String findById(@PathVariable String id, Model model) {
		logger.info("[findById] id is {}", id);
		
		User user = userService.getUserById(id);
		
		model.addAttribute("user", user);
		
		return "user";
	}
	
	@PostMapping("/save")
	public ResponseEntity<Map<String, Object>> save(@RequestBody User user) {
		logger.info("[save] user is {}", user.toString());
		ResponseEntity<Map<String, Object>> entity;
		
		userService.saveUser(user);
		
		entity = new ResponseEntity<>(HttpStatus.OK);
		
		return entity;
	}
	
	@PostMapping("/ajax/save")
	public ResponseEntity<Map<String, Object>> save_ajax(@RequestBody User user) {
		logger.info("[save_ajax] user is {}", user.toString());
		ResponseEntity<Map<String, Object>> entity;
		
		userService.saveUser(user);
		
		entity = new ResponseEntity<>(HttpStatus.OK);
		
		return entity;
	}
	
	
	@PostMapping("/delete")
	public String deleteUser(String id, Model model) {
		logger.info("[deleteUser] id is {}", id);
		
		userService.deleteById(id);
		
		return "redirect:/user/find/all";
	}
	
}
