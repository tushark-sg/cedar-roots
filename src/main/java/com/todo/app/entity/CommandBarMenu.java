package com.todo.app.entity;

import javax.persistence.*;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "commandbarmenu", schema = "innovator")
@NamedQuery(
    name = "CommandBarMenu.findByKeyedName",
    query = "SELECT c FROM CommandBarMenu c WHERE c.keyedName LIKE 'com.aras.innovator.cui_default.toc%'"
)
public class CommandBarMenu {

    @Id
    @Column(name = "id", length = 32, nullable = false)
    private String id;

    private String label;

    @JsonIgnore  // This will prevent 'keyedName' from being included in the JSON response
    @Column(name = "keyed_name")  // Assuming the column exists in the database
    private String keyedName;

    private String parent_menu;

    private String additional_data;

    private String image;

    // Constructors
    public CommandBarMenu() {}

    public CommandBarMenu(String id) {
        this.id = id;
    }

    // Getters and Setters
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

    public String getAdditional_data() {
        return additional_data;
    }

    public void setAdditional_data(String additional_data) {
        this.additional_data = additional_data;
    }

    public String getParent_menu() {
        return parent_menu;
    }

    public void setParent_menu(String parent_menu) {
        this.parent_menu = parent_menu;
    }

    @JsonIgnore  // Ensure 'keyedName' is ignored in JSON responses
    public String getKeyedName() {
        return keyedName;
    }

    public void setKeyedName(String keyedName) {
        this.keyedName = keyedName;
    }
}
