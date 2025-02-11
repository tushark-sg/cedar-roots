package com.todo.app.controller;

import com.todo.app.entity.User;
import com.todo.app.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;
import java.security.MessageDigest;
import java.util.List;
import java.util.Map;

@Controller  // Changed from @RestController to @Controller
public class LoginController {
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    UserService userService;

    @PostMapping(
            path = "/auth/login",
            consumes = {MediaType.APPLICATION_FORM_URLENCODED_VALUE}
    )
    public RedirectView loginUser(@RequestParam Map<String, String> params, HttpSession session) {
        String loginName = params.get("login_name");
        String password = params.get("password");

        if (loginName == null || loginName.isEmpty() || password == null || password.isEmpty()) {
            logger.warn("Login name or password is empty");
            return new RedirectView("login", false);
        }

        List<User> users = userService.getMyUser(loginName);
        if (users.isEmpty()) {
            logger.warn("No user with given login_name found");
            return new RedirectView("login", false);
        }

        User user = users.get(0);
        byte[] bytePassword = password.getBytes();
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            String hashedPassword = DatatypeConverter.printHexBinary(md.digest(bytePassword)).toUpperCase();

            if (hashedPassword.equals(user.getPassword().toUpperCase())) {
                logger.info("User found, redirecting to home");

                // Store username in session (correct approach)
                session.setAttribute("username", loginName);

                return new RedirectView("/home", false);
            }

        } catch (java.security.NoSuchAlgorithmException e) {
            logger.error("MD5 algorithm not found", e);
        }

        logger.warn("Login failed, redirecting back to login page");
        return new RedirectView("login", false);
    }

    @GetMapping("/login")
    public ModelAndView loginPage(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("login");
        modelAndView.addObject("username", session.getAttribute("username")); // Pass username if exists
        return modelAndView;
    }

    @GetMapping("/logout")
    public RedirectView logout(HttpSession session) {
        session.invalidate(); // Clear session on logout
        return new RedirectView("login", false);
    }
}
