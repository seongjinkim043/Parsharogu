package com.pa.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import com.pa.dto.LoginFormDTO;
import com.pa.repository.UserRepository;
import com.pa.entity.User;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserRepository userRepository;

	@GetMapping("/login")
	public String loginForm() {
	    // 로그인 폼 요청
		return "login";
	}
	
	@PostMapping("/login")
	public String login(LoginFormDTO form, HttpSession session, Model model) {
		
		//입력받은 ID, 비밀번호 받기
	    String username = form.getLoginId();
	    String password = form.getPassword();

	    // Optional<User>로 ID 검색후 받기
	    Optional<User> optionalUser = userRepository.findByUsername(username);

	    // 사용자 존재 여부 체크
	    if (optionalUser.isEmpty() || !optionalUser.get().getPassword().equals(password)) {
	        model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
	        return "user/login";
	    }

	    User user = optionalUser.get();

	    // 로그인 성공 → 세션에 저장
	    session.setAttribute("loginUser", user);

	    return "redirect:/main";
	}
	
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate(); // 세션 초기화
	    return "redirect:/login";
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
