package com.pa.service;

import com.pa.dto.ReviewDTO;
import com.pa.service.ReviewService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Override
    public List<ReviewDTO> getReviewsByRegion(String regionName) {
        List<ReviewDTO> list = new ArrayList<>();

        if ("도쿄".equals(regionName)) {
            ReviewDTO r1 = new ReviewDTO();
            r1.setUsername("하나");
            r1.setContent("도쿄타워가 너무 예뻤어요!");
            r1.setRating(5);
            r1.setCreatedDate("2025-06-13");

            ReviewDTO r2 = new ReviewDTO();
            r2.setUsername("지민");
            r2.setContent("벚꽃 시즌에 가면 최고입니다.");
            r2.setRating(4);
            r2.setCreatedDate("2025-06-10");

            list.add(r1);
            list.add(r2);

        } else if ("오사카".equals(regionName)) {
            ReviewDTO r1 = new ReviewDTO();
            r1.setUsername("유나");
            r1.setContent("도톤보리 너무 활기차요!");
            r1.setRating(4);
            r1.setCreatedDate("2025-06-09");

            list.add(r1);
        }

        return list;
    }
    
    @Override
    public List<ReviewDTO> getReviewsByUserId(String userId) {
    	List<ReviewDTO> list = new ArrayList<>();
    	
    	return list;
    }
}
