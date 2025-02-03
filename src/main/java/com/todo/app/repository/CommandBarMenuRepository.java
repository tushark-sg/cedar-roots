package com.todo.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.todo.app.entity.CommandBarMenu;

public interface CommandBarMenuRepository extends JpaRepository<CommandBarMenu, String> {

}
