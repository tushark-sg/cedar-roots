package com.todo.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.todo.app.entity.CommandBarMenuButton;

public interface CommandBarMenuButtonRepository extends JpaRepository<CommandBarMenuButton, String> {

}
