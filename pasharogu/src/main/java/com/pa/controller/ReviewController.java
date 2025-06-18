package com.pa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.pa.dto.ReviewDTO;
import com.pa.entity.Review;
import com.pa.entity.ReviewImage;
import com.pa.repository.ReviewRepository;
import com.pa.service.ReviewService;

import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/api/reviews")
public class ReviewController {
	
	 @Autowired
	 private ReviewRepository reviewRepository;

    private final ReviewService reviewService;
    
    @GetMapping("/write")
    public String showWritePage(@RequestParam("regionId") String regionId, Model model) {
    	model.addAttribute("regionId", regionId);
    	return "write";
    }
    
    @PostMapping("/write")
    public String writeReview(@RequestParam("regionId") String regionId,
    						  @RequestParam("rating") int rating,
    						  @RequestParam("content") String content,
//    						  @RequestParam("images") List<MultipartFile> images,
    						  HttpSession session) throws IOException  {
    	Long userId = (Long) session.getAttribute("userId");
    	
    	if (userId == null) {
    		
    		return "redirect:/login";
    	}
    	
    	// 1. 리뷰 저장
    	Review review = new Review();
    	review.setRegionId(regionId);
    	review.setUserId(userId);
    	review.setContent(content);
//    	review.setRating(rating);
    	
    	List<ReviewImage> reviewImages = new ArrayList<>();
    	
    	
    	// 2. 이미지 저장
//    	for (MultipartFile file : images) {
//    		if(!file.isEmpty()) {
//    			String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
//    			String uploadDir = "/resources/static/img";
//    			File dest = new File(uploadDir, filename);
//    			file.transferTo(dest);
//    			
//    			ReviewImage img = new ReviewImage();
//    			img.setImagePath("/upload/" + filename);
//    			img.setReview(review); // 연관관계 설정
//    			reviewImages.add(img);
//    		}
//    	}
//    	
    	review.setImages(reviewImages);
    	reviewRepository.save(review);
    	return "redirect:/main";
    }
    			

    @Autowired
    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }
    
	@GetMapping("/list")
	public List<ReviewDTO> getReviewList(@RequestParam("region") String region) {
	return reviewService.getReviewsByRegion(region);
    }
	
	@GetMapping("/mypage")
    public String myPage(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        List<Review> myReviews = reviewRepository.findByUserId(userId);
        model.addAttribute("reviews", myReviews);

        return "mypage"; // → mypage.jsp
    }
//    @GetMapping("/user/{userId}")
//    public List<Review> getUserReviews(@PathVariable String userId) {
//        return reviewService.getReviewsByUserId(userId);
//    }
    
    
    
}
