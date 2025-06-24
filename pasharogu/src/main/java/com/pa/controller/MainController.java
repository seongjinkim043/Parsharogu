package com.pa.controller;

import com.pa.dto.RegionDTO;
import com.pa.service.IkitaiService;
import com.pa.service.RegionService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

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
@RequiredArgsConstructor
public class MainController {

	/**
	 * 지역 정보를 처리하는 서비스 객체
	 */
    
    private final RegionService regionService;
    private final IkitaiService ikitaiService;

    /**
     * 메인 페이지 요청을 처리
     * 모든 지역 정보를 조회하여 Model에 달고, main.jsp 뷰를 반환
     * 
     * @param model 뷰에 데이터를 전달하기 위한 객체
     * @return main.jsp 페이지 이름
     */
    @GetMapping("/main")
    public String root(Model model, HttpSession session) {
        List<RegionDTO> regions = regionService.getAllRegions();
        model.addAttribute("regions", regions);
        
        Long userId = (Long) session.getAttribute("userId");
        if(userId != null) {
        	List<String> ikitaiRegionIds = ikitaiService.getRegionIdsByUser(userId);
        	model.addAttribute("ikitaiRegionIds", ikitaiRegionIds);
        }
        return "main";
    }
}
