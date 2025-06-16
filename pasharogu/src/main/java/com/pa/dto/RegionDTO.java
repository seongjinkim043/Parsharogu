package com.pa.dto;

import lombok.Data;

@Data
public class RegionDTO {

	private String regionId;
	private String name;
	private String description;
	private String svgId;
	
	private Double averageRating;
	
	public String getName() {
		return name;
	}
	
	public void setName() {
		this.name = name;
	}
}

