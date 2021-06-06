package com.example.demo.domain;

import java.util.Date;

import lombok.Builder;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class User {
	private String id;
	private String name;
	private int age;
	private Date create_date;


	@Builder
	public User(String id, String name, int age, Date creDate) {
		this.id = id;
		this.name = name;
		this.age = age;
		this.create_date = creDate;
	}
}
