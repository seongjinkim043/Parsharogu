package com.pa.dto;

import lombok.Data;

@Data
public class IkitaiDTO {
    
    private String regionId;   // 지역 이름
    private String imageUrl;    // 지역 사진
    private double averageRating;   // 평균평점
    private boolean liked; // 유저가 이 지역을 찜했는지 여부
}
