package com.pa.pasharogu;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

	@GetMapping("/pasharogu")
	@ResponseBody
	public String index() {
		return "안녕하세요 Pasharogu에 오신것을 환영합니다.";
		
	}
	
	@GetMapping("/")
	public String root() {
		return "hello";
	}
}
