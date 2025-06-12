package com.pa.dto;

import java.sql.Date;

public class ReviewDTO {
    private Long id;
    private String placeId;
    private String content;
    private String imageUrl;
    private Date createdAt;
    
    public ReviewDTO(String content, String imageUrl, Date createdAt) {
    	this.id = id;
    	this.placeId = placeId;
        this.content = content;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
    }
    // getters/setters
}