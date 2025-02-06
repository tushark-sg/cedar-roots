package com.todo.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.todo.app.entity.Part;

public interface PartRepository extends JpaRepository<Part, Long> {

}
