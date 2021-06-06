package com.example.demo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.domain.User;
import com.github.pagehelper.Page;

@Repository
public interface UserRepository {
	List<User> findAll();
	User findById(String id);
	User save(User user);
}
