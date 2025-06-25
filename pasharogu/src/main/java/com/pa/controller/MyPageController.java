package com.pa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pa.dto.IkitaiDTO;
import com.pa.dto.ReviewDTO;
import com.pa.dto.UserDTO;
import com.pa.service.IkitaiService;
import com.pa.service.ReviewService;
import com.pa.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageController {
	@Autowired
	private UserService userService; // ✅ 여기 선언해야 userService를 사용할 수 있음
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private IkitaiService ikitaiService;
    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
    	
    	   // 1. 세션에서 로그인된 사용자 정보 꺼내기
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        // 2. 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
        if (loginUser == null) {
            return "redirect:/login?message=login_required";
        }

        // 3. 프로필 정보 조회
        try {
            UserDTO profile = userService.getProfile(loginUser.getUserId()); // ✅ 인스턴스로 호출!
            model.addAttribute("user", profile);
            
            List<ReviewDTO> reviews = reviewService.getReviewsByUserId(loginUser.getUserId());
            model.addAttribute("reviews", reviews);
            model.addAttribute("reviewCount", reviews.size()); //리뷰 개수 추가
            
            int ikitaiCount = ikitaiService.countByUserId(loginUser.getUserId());
            model.addAttribute("ikitaiCount", ikitaiCount); //위시리스트 개수 추가
            
            List<IkitaiDTO> ikitaiList = ikitaiService.getIkitaiListByLoginid(loginUser.getUserId());
            model.addAttribute("ikitaiList", ikitaiList); // ❌ 현재 빠짐
            
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // 예외 발생 시 에러 페이지로 이동 (원하는 대로 수정 가능)
        }
    	    return "mypage"; // => /WEB-INF/views/mypage.jsp    	
    }
    
    @GetMapping("/myreviews")
    @ResponseBody
    public List<ReviewDTO> getMyReviews(HttpSession session) {
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return List.of(); // 빈 리스트 반환 (비로그인 시)
        }
        return reviewService.getReviewsByUserId(loginUser.getUserId());
    }
}