package com.todo.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
public class TableController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/displayTable")
    public String displayTable(@RequestParam("tableName") String tableName, Model model) {
        // Sanitize input to prevent SQL Injection
        if (!isValidTableName(tableName)) {
            model.addAttribute("error", "Invalid table name!");
            return "error";
        }

        // Query to fetch data dynamically from the given table
        String query = "SELECT * FROM innovator." + tableName;

        List<Map<String, Object>> tableData = jdbcTemplate.queryForList(query);

        // Send data to JSP
        model.addAttribute("tableData", tableData);
        model.addAttribute("tableName", tableName);

        return "tableDisplay"; // JSP page name
    }
    
    @GetMapping("/getTableNameByItemtypeId")
    public ResponseEntity<String> getTableNameByItemtypeId(@RequestParam("itemtypeId") String itemtypeId) {
        
        String query = "SELECT name FROM innovator.ITEMTYPE WHERE id = ?";

        try {
            // Fetch table name from the database
            String tableName = jdbcTemplate.queryForObject(query, new Object[]{itemtypeId}, String.class);

            if (tableName == null || tableName.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No table found for the given itemtypeId!");
            }

            return ResponseEntity.ok(tableName); // Return the table name as a response

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error fetching table name: " + e.getMessage());
        }
    }
    
    
    

    // Validate table name to prevent SQL injection
    private boolean isValidTableName(String tableName) {
        return tableName.matches("[a-zA-Z0-9_]+"); // Allow only alphanumeric + underscore
    }
}
