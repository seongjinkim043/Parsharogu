package com.pa.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "REGION")
@Data
public class Region {
	@Id
	@Column(name = "REGION_ID")
	private String regionId;
	
	@Column(name = "NAME")
	private String name;
	
	@Column(name = "DESCRIPTION")
	private String description;
	
	@Column(name = "SVG_ID")
	private String svgId;  
	
	@Column(name = "IMAGE_URL")
	private String imageUrl;  

	@Column(name = "AVERAGE_RATING")
	private String averageRating;  
}
