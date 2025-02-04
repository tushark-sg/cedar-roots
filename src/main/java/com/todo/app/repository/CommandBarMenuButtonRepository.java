package com.todo.app.repository;

import com.todo.app.entity.CommandBarMenuButton;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CommandBarMenuButtonRepository extends JpaRepository<CommandBarMenuButton, String> {

    // Fetch distinct records based on label
    @Query("SELECT c FROM CommandBarMenuButton c WHERE c.label IS NOT NULL GROUP BY c.label ORDER BY c.id ASC")
    List<CommandBarMenuButton> findDistinctByLabel();
}
