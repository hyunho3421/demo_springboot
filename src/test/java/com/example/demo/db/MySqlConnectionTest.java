package com.example.demo.db;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MySqlConnectionTest {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private static final String DRIVER = "com.mysql.cj.jdbc.Driver"; 
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/fitness"; 
	private static final String USER = "root"; 
	private static final String PW = "3421";
	
	@Test
	public void testConnection() throws Exception {
		Class.forName(DRIVER);
		
		try (Connection conn = DriverManager.getConnection(URL, USER, PW)) {
			
			logger.info("connection is {}", conn);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
