package com.pa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.pa.entity.Review;
import com.pa.service.ReviewService;

import java.util.List;

@RestController
@RequestMapping("/api/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    @Autowired
    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping("/user/{userId}")
    public List<Review> getUserReviews(@PathVariable String userId) {
        return reviewService.getReviewsByUserId(userId);
    }
}
