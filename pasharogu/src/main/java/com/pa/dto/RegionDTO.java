package com.pa.dto;

import lombok.Data;

@Data
public class RegionDTO {

	// 뭐야 왜 안보내져
	private String regionId;
	private String name;
	private String description;
	private String svgId;
	
	private Double averageRating;
	
}

