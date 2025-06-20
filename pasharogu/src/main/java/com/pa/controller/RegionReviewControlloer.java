package com.pa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.pa.dto.RegionDTO;
import com.pa.service.RegionService;

@Controller
@RequestMapping("/review")  // API와 구분
public class RegionReviewControlloer {

    @Autowired
    private RegionService regionService;

    @GetMapping("")
    public String reviewPage(@RequestParam("region") String regionId, Model model) {
        RegionDTO region = regionService.getRegionInfo(regionId);
        model.addAttribute("region", region);
        return "review";  // review.jsp
    }
    
    
}
