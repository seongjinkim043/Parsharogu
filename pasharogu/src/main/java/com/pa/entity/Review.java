package com.pa.entity;


import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id")
    private Long userId;
    private String placeId;
    private String content;
    private String imageUrl;
    private int rating;	//별점
    private LocalDate createdDate;
    private String regionId;


    public Review() {}


	public void setRegionId(String regionId) {
		// TODO Auto-generated method stub
		
	}
}


