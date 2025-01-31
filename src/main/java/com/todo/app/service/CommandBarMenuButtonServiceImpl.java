package com.todo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.todo.app.entity.CommandBarMenuButton;
import com.todo.app.repository.CommandBarMenuButtonRepository;

@Service
public class CommandBarMenuButtonServiceImpl implements CommandBarMenuButtonService {

	@Autowired
	private CommandBarMenuButtonRepository menuButtonRepository;

	@Override
	public void addCommandBarMenuButton(CommandBarMenuButton menu_button) {
		menuButtonRepository.save(menu_button);
	}

	@Override
	public void deleteCommandBarMenuButtonById(String id) {
		menuButtonRepository.deleteById(id);
	}

	@Override
	public void updateCommandBarMenuButtonById(String id, CommandBarMenuButton menu_button) {
		menuButtonRepository.save(menu_button);
	}

	@Override
	public List<CommandBarMenuButton> getAllCommandBarMenuButtons() {
		return menuButtonRepository.findAll();
	}

	@Override
	public void deleteCommandBarMenuButton(String menu_button_id) {
		menuButtonRepository.deleteById(menu_button_id);
	}

	@Override
	public Page<CommandBarMenuButton> getAllCommandBarMenuButtonsPage(int pageNo, int pageSize) {
		Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
		return menuButtonRepository.findAll(pageable);
	}

}
