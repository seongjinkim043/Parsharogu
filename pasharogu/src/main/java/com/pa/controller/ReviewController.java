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
import com.pa.service.RegionService;
import com.pa.service.ReviewService;
import com.pa.repository.UserRepository;
import com.pa.entity.User;

import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/api/reviews")
public class ReviewController {
	
	@Autowired
	private ReviewRepository reviewRepository;
	
	@Autowired
	private UserRepository userRepository;

    private final ReviewService reviewService;
    
    @GetMapping("/write")
    public String showWritePage(@RequestParam("regionId") String regionId, Model model) {
    	model.addAttribute("regionId", regionId);
    	return "write";
    }
    
    // 리뷰 작성 
    @PostMapping("/write")
    @ResponseBody
    public Map<String, Object> writeReview(@RequestParam("regionId") String regionId,
    						   @RequestParam("rating") int rating,
    						   @RequestParam("content") String content,
    						   @RequestParam(value = "images", required = false) MultipartFile[] images,
    						   HttpSession session) throws IOException  {
    	Long userId = (Long) session.getAttribute("userId");
    	Map<String, Object> result = new HashMap<>();
  
    	if (userId == null) {
    		
    		result.put("status", "fail");
    		result.put("redirect", "/login");
    		return result;
    	}
    	
    	User user = userRepository.findById(userId)
    			.orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));
    	
    	// 1. 리뷰 저장
    	Review review = new Review();
    	review.setUser(user);
    	review.setRegionId(regionId);
    	review.setContent(content);
    	review.setRating(rating);
    	review.setCreateAt(LocalDateTime.now());
    	
    	List<ReviewImage> reviewImages = new ArrayList<>();
    	
    	
//    	2. 이미지 저장
    	if (images != null) {  // 이미지 배열이 아예 null 일 수도 있으니 체크
    	    for (MultipartFile file : images) {
    	        if (file != null && !file.isEmpty()) {
    	            String originalFilename = file.getOriginalFilename();
    	            String cleandFilename = originalFilename.replaceAll("[^a-zA-Z0-9\\.\\-]", "_");
    	            String filename = UUID.randomUUID() + "_" + cleandFilename;

    	            String uploadDir = "\\\\192.168.0.48\\img";
    	            File uploadFolder = new File(uploadDir);
    	            if (!uploadFolder.exists()) {
    	                uploadFolder.mkdirs();
    	            }

    	            File dest = new File(uploadFolder, filename);
    	            file.transferTo(dest);

    	            ReviewImage img = new ReviewImage();
    	            img.setImagePath("/upload/" + filename);
    	            img.setReview(review);
    	            reviewImages.add(img);
    	        }
    	    }
    	}
    	
    	if (content.length() > 1000) {
    		result.put("status", "fail");
    		result.put("error", "리뷰는 1000자 이내로 작성해야 합니다.");
    		return result;
    	}

    	
    	review.setImages(reviewImages);
    	reviewRepository.save(review);

    	result.put("status", "success");
    	return result;
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

	    List<Review> myReviews = reviewRepository.findByUserUserId(userId);
	    List<ReviewDTO> reviewDTOs = new ArrayList<>();

	    for (Review review : myReviews) {
	        ReviewDTO dto = new ReviewDTO();
	        dto.setRegionId(review.getRegionId());
	        dto.setUserId(String.valueOf(review.getUserId())); // 필요한 형식으로 변환
	        dto.setContent(review.getContent());
	        dto.setRating(review.getRating());
	        dto.setDate(review.getCreateAt().toString()); // 포맷이 필요하면 따로 포맷터 쓰기
	        dto.setProfileImg(review.getUser().getProfileImg()); // User 객체에서 이미지 가져올 수 있다면

	        // 이미지 경로 추출
	        List<String> imageUrls = new ArrayList<>();
	        if (review.getImages() != null) {
	            for (ReviewImage img : review.getImages()) {
	                imageUrls.add(img.getImagePath());
	            }
	        }
	        dto.setImageUrls(imageUrls);

	        reviewDTOs.add(dto);
	    }

	    model.addAttribute("reviews", reviewDTOs);

	    return "mypage"; // → mypage.jsp
	}

	

	}

//    @GetMapping("/user/{userId}")
//    public List<Review> getUserReviews(@PathVariable String userId) {
//        return reviewService.getReviewsByUserId(userId);
//    }