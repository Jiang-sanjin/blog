package com.example.dao;

import com.example.po.User;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 用户数据库操作
 */
public interface UserRepository extends JpaRepository<User, Long> {

    User findByUsernameAndPassword(String username, String password);
}
