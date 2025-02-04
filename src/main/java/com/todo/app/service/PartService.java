package com.todo.app.service;

import com.todo.app.entity.Part;
import org.springframework.data.domain.Page;

import java.util.List;

public interface PartService {

    // Add part
    public void addPart(Part part);

    // Delete part
    public void deletePartById(Long id);

    // Update part by id
    public void updatePartById(Long id, Part part);

    // Get all parts
    public List<Part> getAllParts();

    public List<Part> getMyParts(String itemNumber);

    // Delete part by id
    public void deletePart(Long partId);

    // Get part by page
    Page<Part> getAllPartsPage(int pageNo, int pageSize);

}
