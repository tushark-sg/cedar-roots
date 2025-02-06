package com.todo.app.entity;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "PART", schema = "innovator")
public class Part {

	@Id
	@Column(name = "id", length = 32, nullable = false)
	private String id;

	@Column(name = "item_number")
	private String itemNumber;

	@Column(name = "make_buy")
	private String makeBuy;

	@Column(name = "name")
	private String name;
	
	@Column(name = "keyed_name")
	private String keyedName;

	// Constructors
	public Part() {
	}

	public Part(String id, String itemNumber, String makeBuy, String name, String keyedName) {
		this.id = id;
		this.itemNumber = itemNumber;
		this.makeBuy = makeBuy;
		this.name = name;
		this.keyedName = keyedName;
	}

	// Getters and Setters
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getItemNumber() {
		return itemNumber;
	}

	public void setItemNumber(String itemNumber) {
		this.itemNumber = itemNumber;
	}

	public String getMakeBuy() {
		return makeBuy;
	}

	public void setMakeBuy(String makeBuy) {
		this.makeBuy = makeBuy;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getKeyedName() {
		return keyedName;
	}

	public void setKeyedName(String KeyedName) {
		this.keyedName = KeyedName;
	}

}
