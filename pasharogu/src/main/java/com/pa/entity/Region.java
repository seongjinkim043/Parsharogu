package com.pa.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Region {
    @Id
    private String regionId;
    private String name;
    private String description;
    private String svgId;
    private double rating;
    private Double averageRating;
    private String imageUrl;

    // getter, setter (Lombok @Data 쓰셔도 됩니다)
}
