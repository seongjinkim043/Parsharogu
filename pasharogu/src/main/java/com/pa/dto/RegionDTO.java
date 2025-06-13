package com.pa.dto;

import lombok.Data;

@Data
public class RegionDTO {

	private String name;
	private String description;
	private double rating;
	
	public String getName() {
		return name;
	}
	
	public void setName() {
		this.name = name;
	}
}

