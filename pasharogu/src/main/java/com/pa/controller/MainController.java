package com.pa.controller;

import com.pa.dto.RegionDTO;
import com.pa.service.RegionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class MainController {

    @Autowired
    private RegionService regionService;

    @GetMapping("/main")
    public String root(Model model) {
        List<RegionDTO> regions = regionService.getAllRegions();
        model.addAttribute("regions", regions);
        return "main";
    }
}
