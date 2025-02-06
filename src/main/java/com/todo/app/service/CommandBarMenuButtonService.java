package com.todo.app.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.todo.app.entity.CommandBarMenuButton;

public interface CommandBarMenuButtonService {

	public void addCommandBarMenuButton(CommandBarMenuButton menu_button);

	public void deleteCommandBarMenuButtonById(String id);

	public void updateCommandBarMenuButtonById(String id, CommandBarMenuButton menu_button);

	public List<CommandBarMenuButton> getAllCommandBarMenuButtons();

	public void deleteCommandBarMenuButton(String menu_button_id);

	Page<CommandBarMenuButton> getAllCommandBarMenuButtonsPage(int pageNo, int pageSize);

}
