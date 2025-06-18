package com.pa.service;

import com.pa.dto.ReviewDTO;
import com.pa.entity.Review;
import com.pa.entity.User;
import com.pa.repository.ReviewRepository;
import com.pa.repository.UserRepository;
import com.pa.service.ReviewService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewRepository reviewRepository;

	@Autowired
	private UserRepository userRepository;

	@Override
	public ReviewDTO getReviewById(Long id) {
	    Review review = reviewRepository.findById(id)
	        .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));

	    User user = review.getUser();

	    ReviewDTO dto = new ReviewDTO();
	    dto.setUsername(user.getNickname());
	    dto.setContent(review.getContent());
	    dto.setRating(review.getRating());
	    dto.setCreatedDate(review.getCreateAt().toString());

	    List<String> imagePaths = review.getImages().stream()
	        .map(img -> img.getImagePath())
	        .toList();
	    dto.setImageUrls(imagePaths);

	    return dto;
	}
  
    
    @Override
    public List<ReviewDTO> getReviewsByUserId(String userId) {
    	List<ReviewDTO> list = new ArrayList<>();
    	
    	return list;
    }



	@Override
	public List<ReviewDTO> getReviewsByRegion(String regionName) {
		// TODO Auto-generated method stub
		return null;
	}
}
