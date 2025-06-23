package com.pa.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pa.dto.LoginFormDTO;
import com.pa.dto.SignupFormDTO;
import com.pa.dto.UserDTO;
import com.pa.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
	 @Autowired
	 private UserService userService; 
	 
	 @GetMapping("/login")
	 public String loginForm() {
	    return "login";
	 }
	
	 @PostMapping("/login")
	 public String login(LoginFormDTO form, Model model, HttpSession session) {
		    try {
		        System.out.println("로그인 시도: " + form.getLoginid()); // 디버깅용
		        UserDTO loginUser = userService.login(form.getLoginid(), form.getPassword());
		        session.setAttribute("loginUser", loginUser);
		        System.out.println("로그인 성공: " + loginUser.getLoginid()); // 디버깅용
		        return "redirect:/main";
		    } 
		    catch (RuntimeException e) {
		    	System.out.println("로그인 실패: " + e.getMessage()); // 디버깅용
		    	model.addAttribute("errorMessage", "存在しないIDまたはパスワードです");
		    	return "login";
		    }
	 }
	
	@GetMapping("/signup")
	public String signinform() {
		return "signup";
	}
    
	@PostMapping("/signup")
	public String signup(SignupFormDTO form, Model model) {
	    System.out.println("Controller reached!!!!!!!!!!!!!!!!!");
	    try {
	        System.out.println("Calling service..............");
	        userService.signup(form);
	        return "redirect:/login";
	    }
	    catch (RuntimeException e) {
	        model.addAttribute("error", e.getMessage());
	        return "signup";
	    }
	}
	
	@ResponseBody
	@GetMapping("/check-username")
	public Map<String, Boolean> checkLoginid(@RequestParam("loginid") String loginid) {
	    boolean exists = userService.isLoginidDuplicate(loginid);
	    return Map.of("exists", exists);
	}
	 
	@GetMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate();
	    return "redirect:/";
	}
	
}