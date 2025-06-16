package com.pa.service;


import com.pa.dto.RegionDTO;
import com.pa.service.RegionService;
import org.springframework.stereotype.Service;

@Service
public class RegionServiceImpl implements RegionService {

    @Override
    public RegionDTO getRegionInfo(String regionName) {
        RegionDTO dto = new RegionDTO();
        dto.setName(regionName);

        if ("도쿄".equals(regionName)) {
            dto.setDescription("일본의 수도 도쿄는 문화와 기술의 중심지입니다.");
            dto.setAverageRating(4.8);
        } else if ("오사카".equals(regionName)) {
            dto.setDescription("오사카는 먹거리와 유쾌한 분위기로 유명합니다.");
            dto.setAverageRating(4.5);
        } else {
            dto.setDescription("해당 지역 정보가 없습니다.");
            dto.setAverageRating(0.0);
        }

        return dto;
    }
}
