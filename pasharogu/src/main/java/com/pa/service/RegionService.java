package com.pa.service;

import java.util.List;

import com.pa.dto.RegionDTO;

public interface RegionService {
	List<RegionDTO> getAllRegions();
	RegionDTO getRegionInfo(String regionId);

}