package com.todo.app.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.todo.app.entity.CommandBarMenu;

public interface CommandBarMenuService{

	public void addCommandBarMenu(CommandBarMenu menu_button);

	public void deleteCommandBarMenuById(String id);

	public void updateCommandBarMenuById(String id, CommandBarMenu menu_button);

	public List<CommandBarMenu> getAllCommandBarMenu();

	public void deleteCommandBarMenu(String menu_button_id);

	Page<CommandBarMenu> getAllCommandBarMenuPage(int pageNo, int pageSize);

}
