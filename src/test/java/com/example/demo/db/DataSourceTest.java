package com.example.demo.db;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class DataSourceTest {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private DataSource dataSource;
	
	@Test
	private void testConnection() throws Exception {
		
        try(Connection conn = dataSource.getConnection()){
            logger.info("conn is {}", conn);
        }catch(Exception e){
            e.printStackTrace();
        }
	}
}
