package com.pa.dto;

import java.util.List;

import lombok.Data;

@Data
public class ReviewDTO {
	private Long regionId;
    private String userId;      // 작성자 이름
    private String content;       // 리뷰 내용
    private int rating;           // 별점
    private String createdAt;   // 작성일 (문자열로 포맷팅)
    private String profileImg;        // 프로필 이미지 경로
    private List<String> imageUrls;   // 리뷰 이미지 리스트 (3장까지 가능)
}
