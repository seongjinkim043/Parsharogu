package com.pa.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.pa.dto.RegionDTO;
import com.pa.service.RegionService;



@RestController
@RequestMapping("/region")
public class RegionController {

	@Autowired
	private RegionService regionService;
	
	public RegionController(RegionService regionService) {
		this.regionService = regionService;
	}
	
	@GetMapping("/info")
	@ResponseBody
	public ResponseEntity<?> getRegionInfo(@RequestParam("region") String regionId) {
	    if (regionId == null || regionId.trim().isEmpty()) {
	        return ResponseEntity.badRequest()
	                .body(Map.of("error", "Region ID is required"));
	    }

	    RegionDTO dto = regionService.getRegionInfo(regionId);
	    if (dto == null) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND)
	                .body(Map.of("error", "Region not found"));
	    }

	    return ResponseEntity.ok(dto);
	}


	
	 @GetMapping("/map")
	    public String showMap(Model model) {
	        List<RegionDTO> regions = regionService.getAllRegions();
	        model.addAttribute("regions", regions);
	        return "region/map"; // views/region/map.jsp
	    }
}