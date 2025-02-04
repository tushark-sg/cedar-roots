package com.todo.app.controller;

import com.todo.app.entity.User;
import com.todo.app.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class LoginController {
    Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    UserService userService;

    @PostMapping(path = "/auth/login", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Boolean login_user(@RequestBody User user) {
        assert user != null;
        assert !user.loginName.isEmpty();
        logger.info(user.loginName);
        List<User> users = userService.getMyUser(user.loginName);
        if (users.size() <= 0) {
            logger.warn("No user with given login_name found");
            return false;
        }
        return users.get(0).password.equals(user.password);
    }
}
