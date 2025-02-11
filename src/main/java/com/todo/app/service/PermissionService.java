package com.todo.app.service;

import com.todo.app.repository.PermissionRepository;
import org.springframework.stereotype.Service;

@Service
public class PermissionService {

    private final PermissionRepository permissionRepository;

    public PermissionService(PermissionRepository permissionRepository) {
        this.permissionRepository = permissionRepository;
    }

    public boolean hasPermission(String userId, String permissionId) {
        return permissionRepository.hasPermission(userId, permissionId);
    }
}
