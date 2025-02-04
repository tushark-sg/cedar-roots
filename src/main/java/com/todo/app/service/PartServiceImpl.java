package com.todo.app.service;

import com.todo.app.entity.Part;
import com.todo.app.repository.PartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PartServiceImpl implements PartService {

    @Autowired
    private PartRepository partRepository;

    @Override
    public void addPart(Part part) {
        partRepository.save(part);
    }

    @Override
    public void deletePartById(Long id) {
        partRepository.deleteById(id);
    }

    @Override
    public void updatePartById(Long id, Part part) {
        partRepository.save(part);
    }

    @Override
    public List<Part> getAllParts() {
        return partRepository.findAll();
    }

    public List<Part> getMyParts(String userID) {
        Part part = new Part();
        part.setItemNumber("asdf");
        return partRepository.findAll(Example.of(part), Sort.unsorted());
    }

    @Override
    public void deletePart(Long partId) {
        partRepository.deleteById(partId);
    }

    @Override
    public Page<Part> getAllPartsPage(int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        return partRepository.findAll(pageable);
    }

}
