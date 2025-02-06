package com.todo.app.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.todo.app.service.CommandBarMenuButtonService;

@RestController
public class ItemRestController {

	@Autowired
	CommandBarMenuButtonService menuButtonService;
	

	/*
	 * @description Need to add more mappings for each itemtype, ignores item_id for now
	 */
	@GetMapping("/api/{item_type_name}/{item_id}")
	public List getItemForItemType(@PathVariable String item_type_name, @PathVariable String item_id) {
		if (item_type_name.toLowerCase().equals("commandbarmenubutton")) {
			return menuButtonService.getAllCommandBarMenuButtons();
		}
		List<String> res = new ArrayList<>();
		res.add("Error");
		return res;
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
