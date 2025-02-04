package com.todo.app.service;

import com.todo.app.entity.CommandBarMenuButton;
import com.todo.app.repository.CommandBarMenuButtonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommandBarMenuButtonServiceImpl implements CommandBarMenuButtonService {

    @Autowired
    private CommandBarMenuButtonRepository menuButtonRepository;

    @Override
    public List<CommandBarMenuButton> getAllCommandBarMenuButtons() {
        return menuButtonRepository.findAll();
    }

    @Override
    public List<CommandBarMenuButton> getAllTOCButtons() {
        return menuButtonRepository.findAll();
    }

    @Override
    public Page<CommandBarMenuButton> getAllCommandBarMenuButtonsPage(int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        return menuButtonRepository.findAll(pageable);
    }

}
