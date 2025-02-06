package com.todo.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping({"/", "/home"})
    public String index_page() {
        return "home";
    }
    @GetMapping("/master")
    public String master_page() {
        return "master";
    }
}
