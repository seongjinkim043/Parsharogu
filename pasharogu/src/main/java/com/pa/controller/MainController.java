package com.pa.controller;

import com.pa.dto.RegionDTO;
import com.pa.service.RegionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

/**
 * 메인 페이지를 처리하는 컨트롤러
 * 지역 데이터를 조회하여 뷰에 전달
 */
@Controller
public class MainController {

	/**
	 * 지역 정보를 처리하는 서비스 객체
	 */
    @Autowired
    private RegionService regionService;

    /**
     * 메인 페이지 요청을 처리
     * 모든 지역 정보를 조회하여 Model에 달고, main.jsp 뷰를 반환
     * 
     * @param model 뷰에 데이터를 전달하기 위한 객체
     * @return main.jsp 페이지 이름
     */
    @GetMapping("/main")
    public String root(Model model) {
        List<RegionDTO> regions = regionService.getAllRegions();
        model.addAttribute("regions", regions);
        return "main";
    }
}
