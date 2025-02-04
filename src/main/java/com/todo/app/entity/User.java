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
    public String loginName;

    @Column(length = 32)
    public String password;

    @Column(name = "first_name")
    public String firstName;


    @Id
    @Column(name = "id", length = 32)
    public String id;

    public User() {
    }

    public User(String id, String loginName, String password) {
        this.loginName = loginName;
        this.password = password;
        this.id = id;
    }

}
