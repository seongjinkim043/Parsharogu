package com.pa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.pa.dto.RegionDTO;
import com.pa.service.RegionService;

@RestController
@RequestMapping("/region")
public class RegionController {

	@Autowired
	private RegionService regionService;
	
	@GetMapping("/info")
	public RegionDTO getRegionInfo(@RequestParam("region") String region) {
		return regionService.getRegionInfo(region);
	}
}