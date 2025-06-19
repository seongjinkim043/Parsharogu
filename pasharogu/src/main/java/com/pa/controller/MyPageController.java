package com.pa.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.pa.dto.IkitaiDTO;
import com.pa.dto.ReviewDTO;
import com.pa.service.IkitaiService;
import com.pa.service.ReviewService;

@Controller
public class MyPageController {

    private final ReviewService reviewService;
    private final IkitaiService ikitaiService;

    public MyPageController(ReviewService reviewService, IkitaiService ikitaiService) {
        this.reviewService = reviewService;
        this.ikitaiService = ikitaiService;
    }

    @GetMapping("/mypage")
    public String showMyPage(Model model, Principal principal) {
        String userId = principal.getName(); // 로그인한 사용자 ID

        List<ReviewDTO> reviews = reviewService.getReviewsByUserId(userId);
        List<IkitaiDTO> ikitaiList = ikitaiService.getIkitaiListByloginid(userId);

        model.addAttribute("reviews", reviews);
        model.addAttribute("ikitaiList", ikitaiList);

        return "mypage";
    }
}
