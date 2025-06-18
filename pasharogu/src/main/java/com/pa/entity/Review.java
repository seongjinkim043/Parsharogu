package com.pa.entity;


import java.time.LocalDate;
import java.util.*;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "review")
@Data
public class Review {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "review_seq_generator")
	@SequenceGenerator(name = "review_seq_generator", sequenceName = "REVIEW_SEQ", allocationSize = 1)
	@Column(name = "REVIEW_ID")
	private Long reviewId;
    
    // Review 삭제 시 이미지 자동 삭제
    @OneToMany(mappedBy = "review", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ReviewImage> images = new ArrayList<>();

    @Column(name = "user_id")
    private Long userId;
    private String content;
    private int rating;	//별점
    
    @Column(name = "region_id")
    private String regionId;


    public Review() {}


}


