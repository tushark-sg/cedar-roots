package com.todo.app.controller;

import com.todo.app.service.CommandBarMenuButtonService;
import com.todo.app.service.PartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
public class ItemRestController {

    @Autowired
    CommandBarMenuButtonService menuButtonService;

    @Autowired
    PartService partService;

    /*
     * @description Need to add more mappings for each itemtype, ignores item_id for
     * now
     */
    @GetMapping("/api/{item_type_name}/{item_id}")
    public List getItemForItemType(@PathVariable String item_type_name, @PathVariable String item_id) {
        if (item_type_name.toLowerCase().equals("commandbarmenubutton")) {
            return menuButtonService.getAllCommandBarMenuButtons();
        }
        if (item_type_name.toLowerCase().equals("part")) {
            return partService.getMyParts("asdf");
        }
        List<String> res = new ArrayList<>();
        res.add("Error");
        return res;
    }

}
