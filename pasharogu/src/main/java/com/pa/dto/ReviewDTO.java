package com.pa.dto;

import lombok.Data;

@Data
public class ReviewDTO {
    private String username;      // 작성자 이름
    private String content;       // 리뷰 내용
    private int rating;           // 별점
    private String createdDate;   // 작성일 (문자열로 포맷팅)
}
