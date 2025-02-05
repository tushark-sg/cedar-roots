package com.todo.app.controller;

import java.security.*;
import com.todo.app.entity.User;
import com.todo.app.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.xml.bind.DatatypeConverter;
import java.util.List;
import java.util.Map;

@RestController
public class LoginController {
    Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    UserService userService;

    @PostMapping(
            path = "/auth/login",
            consumes = {MediaType.APPLICATION_FORM_URLENCODED_VALUE}
    )
    public RedirectView login_user(@RequestParam Map<String, String> params) {
        User user = new User();
        user.setLoginName( params.get("login_name"));
        user.setPassword(params.get("password"));
        assert user != null;
        assert !user.getLoginName().isEmpty();
        List<User> users = userService.getMyUser(user.getLoginName());
        if (users.size() <= 0) {
            logger.warn("No user with given login_name found");
            return new RedirectView("login", false);
        }

        byte[] byte_password = user.getPassword().getBytes();
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            if(DatatypeConverter.printHexBinary( md.digest(byte_password)).toUpperCase().equals(users.get(0).getPassword().toUpperCase())){
                logger.info("User found redirecting");
                return new RedirectView("/home",false);
            }
            
        } catch (java.security.NoSuchAlgorithmException e){
        }
        finally{
        }
        logger.warn("login failed back to login page");
        return new RedirectView("login", false);
    }
    @GetMapping(path = "/login")
    public ModelAndView loginPage() {
        return new ModelAndView("login");
    }
}
