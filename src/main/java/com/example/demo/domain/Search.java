package com.example.demo.domain;

import lombok.Data;

@Data
public class Search {
	private String keyword;
	private String content;
	
	private int page;
	private int perPageNum;
}
