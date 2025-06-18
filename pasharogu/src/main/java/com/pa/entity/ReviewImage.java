package com.pa.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GenerationType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "REVIEW_IMAGE")
@Data
@NoArgsConstructor
public class ReviewImage {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "IMAGE_PATH", nullable = false, length = 500)
	private String imagePath;
	
	@Column(name = "UPLOADED_AT", insertable = false, updatable = false)
	private LocalDateTime uploadedAt;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "REVIEW_ID", nullable = false)
	private Review review;

}
