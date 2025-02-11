package com.todo.app.service;

import com.todo.app.entity.User;
import com.todo.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<User> getMyUser(String loginName) {
        User user = new User();
        user.setLoginName(loginName);
        return userRepository.findAll(Example.of(user), Sort.unsorted());
    }

}