package com.todo.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

// import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
@EnableAutoConfiguration
@ComponentScan
//@SpringBootApplication
public class AppApplication {// extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(AppApplication.class, args);
    }

}
