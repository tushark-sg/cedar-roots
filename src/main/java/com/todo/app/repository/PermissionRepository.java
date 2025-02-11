package com.todo.app.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.stereotype.Repository;

import java.sql.CallableStatement;
import java.sql.Types;

@Repository
public class PermissionRepository {

    private final JdbcTemplate jdbcTemplate;

    public PermissionRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public boolean hasPermission(String userId, String permissionId) {
        String sql = "{call CheckUserPermission(?, ?, ?)}";

        return jdbcTemplate.execute(sql, (CallableStatementCallback<Boolean>) cs -> {
            cs.setString(1, userId);
            cs.setString(2, permissionId);
            cs.registerOutParameter(3, Types.BIT); // Output parameter

            cs.execute();
            return cs.getBoolean(3); // Retrieve the output value
        });
    }
}
