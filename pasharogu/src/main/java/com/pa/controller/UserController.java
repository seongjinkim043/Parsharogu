package com.pa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.pa.dto.LoginFormDTO;
import com.pa.dto.SignupFormDTO;
import com.pa.dto.UserDTO;
import com.pa.service.UserService;


@Controller
public class UserController {
	
	 @Autowired
	    private UserService userService; 
	 
	@GetMapping("/login")
	public String loginForm() {
	    // 로그인 폼 요청
		return "login";
	}
	
	 @PostMapping("/login")
	 public String login(LoginFormDTO form, Model model) {
		    try {
		        System.out.println("로그인 시도: " + form.getLoginid()); // 디버깅용
		        UserDTO loginUser = userService.login(form.getLoginid(), form.getPassword());
		        System.out.println("로그인 성공: " + loginUser.getLoginid()); // 디버깅용
		        return "redirect:/";
		    } catch (RuntimeException e) {
		        System.out.println("로그인 실패: " + e.getMessage()); // 디버깅용
		        model.addAttribute("error", e.getMessage());
		        return "login";
		    }
		}
	
	@GetMapping("/signup")
	public String signinform() {
	    // 회원가입 폼 요청
		return "signup";
	}
	
	
	@PostMapping("/signup")
	public String signup(SignupFormDTO form, Model model) {
	    try {
	        userService.signup(form);
	        return "redirect:/login";
	    } catch (RuntimeException e) {
	        model.addAttribute("error", e.getMessage());
	        return "signup";
	    }
	}
	
	@GetMapping("/logout")
	public String logout() {
	    
	    return "redirect:/";
	}
	

	
//	
//	@GetMapping("/mypage")
//	public String mypage(Model model) {
//		//마이페이지 내용 보여주기
//		
//		return "user/mypage";
//	}

}
