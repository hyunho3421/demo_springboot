package com.example.demo;

import java.util.HashSet;

import org.junit.jupiter.api.Test;

public class test {

	@Test
	public void test() {
		HashSet<String> set = new HashSet<>();
		String a = "1";
		String b = "1";
		
		set.add(a);
		set.add(b);
		
		System.out.println(set.toString());
		
	}
}
