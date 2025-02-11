package com.todo.app.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
// import javax.persistence.GeneratedValue;
// import javax.persistence.GenerationType;

@Entity
@Table(name = "[user]", schema = "innovator")
public class User {

    @Column(name = "login_name")
    private String loginName;

    @Column(length = 32)
    private String password;

    @Column(name = "first_name")
    private String firstName;


    @Id
    @Column(name = "id", length = 32)
    private String id;

    public User() {
    }

    public User(String id, String loginName, String password) {
        this.loginName = loginName;
        this.password = password;
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }
}