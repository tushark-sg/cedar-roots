package com.todo.app.service;

import com.todo.app.entity.CommandBarMenuButton;
import org.springframework.data.domain.Page;

import java.util.List;

public interface CommandBarMenuButtonService {


    List<CommandBarMenuButton> getAllCommandBarMenuButtons();

    List<CommandBarMenuButton> getAllTOCButtons();

    Page<CommandBarMenuButton> getAllCommandBarMenuButtonsPage(int pageNo, int pageSize);

}
