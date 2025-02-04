package com.todo.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Controller
public class LoginController {

    private static final String EXPECTED_PASSWORD_HASH = "202cb962ac59075b964b07152d234b70"; // MD5 hash for "password"

    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; 
    }

    @PostMapping("/login")
    public String handleLogin(
            @RequestParam String username,
            @RequestParam String password,
            Model model) {

        System.out.println("Username: " + username + ", Password: " + password);

        String hashedPassword = generateMD5(password);

        System.out.println("MD5 Hash of entered password: " + hashedPassword);

        if ("admin".equals(username) && EXPECTED_PASSWORD_HASH.equals(hashedPassword)) {
            return "redirect:/home";
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "login"; 
        }
    }

    // Utility method to generate MD5 hash from a string
    private String generateMD5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());

            // Convert the byte array to a hexadecimal format
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                String hex = Integer.toHexString(0xFF & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
