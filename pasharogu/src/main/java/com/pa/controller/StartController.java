package com.pa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class StartController {

	@GetMapping("/")
	public String start() {
		return "start";
	}
	
}
