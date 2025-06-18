package com.pa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.pa.dto.ReviewDTO;
import com.pa.entity.Review;
import com.pa.repository.ReviewRepository;
import com.pa.service.ReviewService;

import jakarta.servlet.http.HttpSession;

import java.util.List;

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
    public String writeReview(@RequestParam String regionId,
    						  @RequestParam int rating,
    						  @RequestParam String content,
    						  HttpSession session) {
    	Long userId = (Long) session.getAttribute("userId");
    	
    	if (userId == null) {
    		
    		return "redirect:/login";
    	}
    	
    	Review review = new Review();
    	review.setRegionId(regionId);
    	review.setUserId(userId);
    	review.setContent(content);
//    	review.setRating(rating);
    	
    	reviewRepository.save(review);
    	return "redirect:/main";
    }
    			

    @Autowired
    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }
    
	@GetMapping("/list")
	public List<ReviewDTO> getReviewList(@RequestParam String region) {
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
