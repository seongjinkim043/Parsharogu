package com.pa.pasharogu;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@GetMapping("/login")
	public String loginForm() {
		return "user/login";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam String username) {
		// 로그인 처리 구현
		return "redirect:/mypage";
	}
	
	@GetMapping("/signup")
	public String signupForm() {
		return "user/signup";
	}
	
//	@PostMapping("/signup")
//	public String signup(userDTO userDTO) {
//		//회원가입 처리 구현
//		
//		return "redirect:/user/login";
//	}
//	
//	@GetMapping("/mypage")
//	public String mypage(Model model) {
//		//마이페이지 내용 보여주기
//		
//		return "user/mypage";
//	}

}
