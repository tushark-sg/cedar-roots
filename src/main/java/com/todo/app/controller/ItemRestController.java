package com.todo.app.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.todo.app.entity.CommandBarMenu;
import com.todo.app.service.CommandBarMenuButtonService;
import com.todo.app.service.CommandBarMenuService;
import com.todo.app.service.PermissionService;

@RestController
public class ItemRestController {

	@Autowired
	CommandBarMenuButtonService menuButtonService;
	@Autowired
	CommandBarMenuService menuService;
	
	 @Autowired
	    private PermissionService permissionService;

	/*
	 * @description Need to add more mappings for each itemtype, ignores item_id for now
	 */
	
	@GetMapping("/api/{item_type_name}/{item_id}")
	public List getItemForItemType(@PathVariable String item_type_name, @PathVariable String item_id) {
		if (item_type_name.toLowerCase().equals("commandbarmenubutton")) {
			return menuButtonService.getDistinctCommandBarMenuButtonsByLabel();
		}
		
		else if (item_type_name.toLowerCase().equals("commandbarmenu")) {
			return menuService.getAllCommandBarMenu();
		}
		
		List<String> res = new ArrayList<>();
		res.add("Error");
		return res;
	}
	
	  @GetMapping("/api/permissions/check")
	    public ResponseEntity<Boolean> hasPermission(@RequestParam String userId, @RequestParam String permissionId) {
	        try {
	        	System.out.println("userID" + userId);
	        	System.out.println(permissionId);
	            boolean result = permissionService.hasPermission(userId, permissionId);
	            System.out.println("result" + result);
	            return ResponseEntity.ok(result);
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(false);
	        }
	    }
	
	
	// @GetMapping("/books")
	// public String test_mapping() {
	// return "books";
	// }
	//

	// @PostMapping("/part")
	// @ResponseBody
	// public ResponseEntity<List<Part>> createPart(@RequestBody Part part) {
	// partService.addPart(part);
	// List<Part> parts = partService.getAllParts();
	// return ResponseEntity.ok(parts);
	// }
	//
	// //part//part/ Delete part using AJAX request
	// @DeleteMapping("/part/home/part/{partId}")
	// public ResponseEntity<Void> deletePart(@PathVariable Long partId) {
	// partService.deletePart(partId);
	// return ResponseEntity.ok().build();
	// }

}
