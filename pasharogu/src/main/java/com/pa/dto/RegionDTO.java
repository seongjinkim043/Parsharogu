package com.pa.dto;

import java.util.List;

import lombok.Data;

@Data
public class RegionDTO {

	// 뭐야 왜 안보내져
	private String regionId;
	private String name;
	private String description;
	private String svgId;
	private double rating;
	private Double avgRating;
	private String imagePath;
	
	private List<ReviewDTO> reviews;
	
}

