package com.pa.service;


import com.pa.dto.RegionDTO;
import com.pa.dto.ReviewDTO;
import com.pa.entity.Region;
import com.pa.entity.Review;
import com.pa.entity.ReviewImage;
import com.pa.repository.RegionRepository;
import com.pa.repository.ReviewRepository;
import com.pa.service.RegionService;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Base64;


import org.springframework.stereotype.Service;

/**
 * RegionService의 구현 클래스
 * 지역 정보 조회 관련 비즈니스 로직
 */
@Service
public class RegionServiceImpl implements RegionService {
	
	private final RegionRepository regionRepository;
	
	private final ReviewRepository reviewRepository;

	/**
	 * 생성자 주입을 통해 RegionRepository를 전달받아 초기화
	 * 
	 * @param regionRepository 지역 정보에 접근하는 JPA 리포지토리
	 */
    public RegionServiceImpl(RegionRepository regionRepository, ReviewRepository reviewRepository) {
        this.regionRepository = regionRepository;
        this.reviewRepository = reviewRepository;
    }
    
    /**
     * 모든 지역 정보를 조회하여 DTO 리스트로 변환
     * Entity 객체를 외부로 직접 노출하지 않고 DTO로 변환하여 제공
     */
    @Override
    public List<RegionDTO> getAllRegions() {
    	return regionRepository.findAll().stream()
    			.map(region -> {
    				RegionDTO dto = new RegionDTO();
    				dto.setRegionId(region.getRegionId());
    				dto.setName(region.getName());
    				dto.setSvgId(region.getSvgId());
    				return dto;
    			}).collect(Collectors.toList());
    	
    }
    
    /**
     * 주어진 지역 ID에 해당하는 지역 정보를 조회하여 DTO로 변환
     * 해당 지역이 존재하지 않을 경우 null을 반환
     */
    @Override
    public RegionDTO getRegionInfo(String regionId) {
        Region region = regionRepository.findById(regionId).orElse(null);
        if (region == null) return null;

        RegionDTO dto = new RegionDTO();
        dto.setRegionId(region.getRegionId());
        dto.setName(region.getName());
        dto.setSvgId(region.getSvgId());
        dto.setImagePath(region.getImagePath());
        
        
        
        List<ReviewDTO> reviews = getReviewsForRegion(regionId);
        dto.setReviews(reviews);
        
        double avg = reviews.stream()
        		.mapToDouble(ReviewDTO::getRating)
        		.average()
        		.orElse(0.0);
        
        dto.setAvgRating(avg);
        
        return dto;
    }
    
    @Override
    public List<ReviewDTO> getReviewsForRegion(String regionId) {
        List<Review> reviews = reviewRepository.findByRegionRegionId(regionId);
        List<ReviewDTO> dtoList = new ArrayList<>();
        
        for (Review review : reviews) {
            ReviewDTO dto = new ReviewDTO();
            
            if (review.getUser() != null) {
                dto.setUserId(review.getUser().getNickname());
                dto.setProfileImg(review.getUser().getProfileImg());
            } else {
                dto.setUserId("익명");
                
            }

            dto.setDate(review.getCreateAt() != null ? review.getCreateAt().toString() : "");
            dto.setContent(review.getContent());
            dto.setRating(review.getRating());

            List<String> imageUrls = review.getImages() != null ?
                review.getImages().stream().map(ReviewImage::getImagePath).toList()
                : List.of();

            dto.setImageUrls(imageUrls);
            dtoList.add(dto);
            
       
        }
        
        return dtoList;
    }




}