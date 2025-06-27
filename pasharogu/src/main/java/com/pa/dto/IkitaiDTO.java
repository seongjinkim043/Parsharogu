package com.pa.dto;

import lombok.Data;

@Data
public class IkitaiDTO {

    private String regionId;       // ex) AOM
    private String regionName;     // ex) 青森県 ← Region 의 name 필드
    private String imageUrl;       // 현재는 "" 처리
    private double averageRating;  // 지금은 고정 4.5
    private boolean liked;         // true
    private String imagePath;
}