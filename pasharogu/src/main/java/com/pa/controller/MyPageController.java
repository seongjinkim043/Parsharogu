package com.pa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {

    @GetMapping("/mypage")
    public String mypage() {
        return "mypage";  // /WEB-INF/views/mypage.jsp 로 이동
    }
}
