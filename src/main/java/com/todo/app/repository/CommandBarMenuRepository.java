package com.todo.app.repository;

import com.todo.app.entity.CommandBarMenu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommandBarMenuRepository extends JpaRepository<CommandBarMenu, String> {
    
    List<CommandBarMenu> findByKeyedName(); // Named Query will be called automatically
}
