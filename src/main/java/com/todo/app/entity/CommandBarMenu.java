package com.todo.app.entity;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.Entity;
// import javax.persistence.GeneratedValue;
// import javax.persistence.GenerationType;


@Entity
@Table(name = "commandbarmenu", schema = "innovator")
public class CommandBarMenu {
	
	@Id
	@Column(name = "id", length = 32, nullable = false)
	private String id;

	private String label;

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	private String parent_menu ;

	private String additional_data;

	private String image;



	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public CommandBarMenu() {
	}

	public CommandBarMenu(String id){
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the additional_data
	 */
	public String getAdditional_data() {
		return additional_data;
	}

	/**
	 * @param additional_data the additional_data to set
	 */
	public void setAdditional_data(String additional_data) {
		this.additional_data = additional_data;
	}

	/**
	 * @return the parent_menu
	 */
	public String getParent_menu() {
		return parent_menu;
	}

	/**
	 * @param parent_menu the parent_menu to set
	 */
	public void setParent_menu(String parent_menu) {
		this.parent_menu = parent_menu;
	}

}
