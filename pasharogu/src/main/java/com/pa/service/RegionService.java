package com.pa.service;

import java.util.List;

import com.pa.dto.RegionDTO;
import com.pa.dto.ReviewDTO;

public interface RegionService {
	List<RegionDTO> getAllRegions();
	RegionDTO getRegionInfo(String regionId);
	
	List<ReviewDTO> getReviewsForRegion(String regionId);

}