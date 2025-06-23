package com.pa.service;

import org.springframework.stereotype.Service;

import com.pa.dto.ReviewDTO;
import com.pa.entity.Review;
import com.pa.repository.ReviewRepository;

import java.util.List;

public interface ReviewService {
    ReviewDTO getReviewById(Long id);
    List<ReviewDTO> getReviewsByUserId(Long userId);   
    List<ReviewDTO> getReviewsByRegion(String regionId);
}

