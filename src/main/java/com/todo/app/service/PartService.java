package com.todo.app.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.todo.app.entity.Part;

public interface PartService {

	// Add part
	public void addPart(Part part);

	// Delete part
	public void deletePartById(Long id);

	// Update part by id
	public void updatePartById(Long id, Part part);

	// Get all parts
	public List<Part> getAllParts();

	// Delete part by id
	public void deletePart(Long partId);

	// Get part by page
	Page<Part> getAllPartsPage(int pageNo, int pageSize);

}
