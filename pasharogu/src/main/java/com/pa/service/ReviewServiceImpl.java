package com.pa.service;

import com.pa.dto.ReviewDTO;
import com.pa.entity.Review;
import com.pa.repository.ReviewRepository;
import com.pa.service.ReviewService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    /** 개별 리뷰 조회 */
    @Override
    @Transactional
    public ReviewDTO getReviewById(Long id) {
        Review review = reviewRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));

        return toDTO(review);
    }

    /** 특정 유저가 작성한 리뷰 목록 */
    @Override
    @Transactional
    public List<ReviewDTO> getReviewsByUserId(Long userId) {
        List<Review> reviews = reviewRepository.findByUserUserId(userId);

        return reviews.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    /** 지역명으로 리뷰 목록 */
    @Override
    @Transactional
    public List<ReviewDTO> getReviewsByRegion(String regionName) {
        List<Review> reviews = reviewRepository.findByRegionRegionId(regionName);

        return reviews.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    /** 엔티티 → DTO 변환 */
    private ReviewDTO toDTO(Review review) {
        ReviewDTO dto = new ReviewDTO();
        dto.setUserId(review.getUser().getNickname());      // 닉네임
        dto.setContent(review.getContent());
        dto.setRating(review.getRating());
        dto.setDate(review.getCreateAt().toString());  // 포맷 변경 원하면 DateTimeFormatter 사용
        dto.setRegionId(review.getRegion().getRegionId());
        dto.setRegionName(review.getRegion().getName());
        dto.setImageUrls(
            review.getImages().stream()
                  .map(img -> img.getImagePath())
                  .collect(Collectors.toList())
        );
        return dto;
    }
}
