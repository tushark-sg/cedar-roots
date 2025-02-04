package com.todo.app.entity;

import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Column;
import javax.persistence.Entity;

@Entity
@Table(name = "commandbarmenubutton", schema = "innovator")
public class CommandBarMenuButton {

    @Id
    @Column(name = "id", length = 32, nullable = false)
    private String id;

    @Column(name = "label")
    private String label;

    @Column(name = "parent_menu")
    @JsonProperty("parent_menu")
    private String parent_menu;

    @Column(name = "additional_data")
    private String additionalData;

    @Column(name = "image")
    private String image;

    public CommandBarMenuButton() {}

    public CommandBarMenuButton(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getParentMenu() {
        return parent_menu;
    }

    public void setParentMenu(String parentMenu) {
        this.parent_menu = parentMenu;
    }

    public String getAdditionalData() {
        return additionalData;
    }

    public void setAdditionalData(String additionalData) {
        this.additionalData = additionalData;
    }
}
