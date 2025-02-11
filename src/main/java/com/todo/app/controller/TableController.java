package com.todo.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.todo.app.service.PermissionService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

@Controller
public class TableController {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private PermissionService permissionService;

    @GetMapping("/displayTable")
    public String displayTable(@RequestParam("tableName") String tableName, Model model, HttpSession session) {
        // Sanitize input to prevent SQL Injection
        if (!isValidTableName(tableName)) {
            model.addAttribute("error", "Invalid table name!");
            return "error";
        }

        // Fetch username from session
        String loginName = (String) session.getAttribute("username");
        if (loginName == null) {
            model.addAttribute("error", "User not logged in!");
            return "error";
        }

        // Step 1: Fetch userId using login-name
        String userIdQuery = "SELECT ID FROM [Aras31].[innovator].[USER] WHERE LOGIN_NAME = ?";
        List<Map<String, Object>> userResult = jdbcTemplate.queryForList(userIdQuery, loginName);

        if (userResult.isEmpty()) {
            model.addAttribute("error", "User not found!");
            return "error";
        }
        String userId = (String) userResult.get(0).get("ID");

        // Step 1.a: Fetch aliasIdentityId using userId
        String aliasQuery = "SELECT RELATED_ID FROM [Aras31].[innovator].[ALIAS] WHERE SOURCE_ID = ?";
        List<Map<String, Object>> aliasResult = jdbcTemplate.queryForList(aliasQuery, userId);

        if (aliasResult.isEmpty()) {
            model.addAttribute("error", "User identity not found!");
            return "error";
        }
        String aliasIdentityId = (String) aliasResult.get(0).get("RELATED_ID");

        // Step 2.a: Fetch itemtypeId using tableName (i.e., itemtype name)
        String itemtypeQuery = "SELECT ID FROM [Aras31].[innovator].[ITEMTYPE] WHERE NAME = ?";
        List<Map<String, Object>> itemtypeResult = jdbcTemplate.queryForList(itemtypeQuery, tableName);

        if (itemtypeResult.isEmpty()) {
            model.addAttribute("error", "Item type not found!");
            return "error";
        }
        String itemtypeId = (String) itemtypeResult.get(0).get("ID");

        // Step 2: Fetch permissionId using itemtypeId
        String permissionQuery = "SELECT RELATED_ID FROM [Aras31].[innovator].[ALLOWED_PERMISSION] WHERE SOURCE_ID = ?";
        List<Map<String, Object>> permissionResult = jdbcTemplate.queryForList(permissionQuery, itemtypeId);

        if (permissionResult.isEmpty()) {
            model.addAttribute("error", "Permission not found for this item type!");
            return "error";
        }
        String permissionId = (String) permissionResult.get(0).get("RELATED_ID");

        // Step 3: Call checkPermission API
        boolean hasPermission = permissionService.hasPermission(aliasIdentityId, permissionId);

        if (!hasPermission) {
            model.addAttribute("error", "You do not have permission to view this data!");
            return "tableDisplay";  // Stay on the same page
        }
        
        System.out.println("----- PERMISSION GRANTED --------");
        // If user has permission, fetch table data
        String query = "SELECT * FROM innovator." + tableName;
        List<Map<String, Object>> tableData = jdbcTemplate.queryForList(query);

        model.addAttribute("tableData", tableData);
        model.addAttribute("tableName", tableName);

        return "tableDisplay"; // Return JSP page for display
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
