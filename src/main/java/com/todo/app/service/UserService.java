package com.todo.app.service;

import com.todo.app.entity.User;

import java.util.List;


public interface UserService {

    List<User> getMyUser(String loginName);
}