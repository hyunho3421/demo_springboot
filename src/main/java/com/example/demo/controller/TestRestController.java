package com.example.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest")
public class TestRestController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String getTest() {
		logger.info("/rest/test");
		
		return "test";
	}
}
