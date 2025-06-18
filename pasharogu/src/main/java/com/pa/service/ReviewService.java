package com.pa.service;

import org.springframework.stereotype.Service;

import com.pa.dto.ReviewDTO;
import com.pa.entity.Review;
import com.pa.repository.ReviewRepository;

import java.util.List;

@Service
public interface ReviewService {

	List<ReviewDTO> getReviewsByRegion(String regionName);
	
	List<ReviewDTO> getReviewsByUserId(String userId);
	
	public ReviewDTO getReviewById(Long id);
   
}
