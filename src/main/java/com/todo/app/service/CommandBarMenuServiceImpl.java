package com.todo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.todo.app.entity.CommandBarMenu;
import com.todo.app.repository.CommandBarMenuRepository;

@Service
public class CommandBarMenuServiceImpl implements CommandBarMenuService {

	@Autowired
	private CommandBarMenuRepository menuButtonRepository;

	@Override
	public void addCommandBarMenu(CommandBarMenu menu_button) {
		menuButtonRepository.save(menu_button);
	}

	@Override
	public void deleteCommandBarMenuById(String id) {
		menuButtonRepository.deleteById(id);
	}

	@Override
	public void updateCommandBarMenuById(String id, CommandBarMenu menu_button) {
		menuButtonRepository.save(menu_button);
	}

	@Override
	public List<CommandBarMenu> getAllCommandBarMenu() {
		return menuButtonRepository.findAll();
	}

	@Override
	public void deleteCommandBarMenu(String menu_button_id) {
		menuButtonRepository.deleteById(menu_button_id);
	}

	@Override
	public Page<CommandBarMenu> getAllCommandBarMenuPage(int pageNo, int pageSize) {
		Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
		return menuButtonRepository.findAll(pageable);
	}

}
