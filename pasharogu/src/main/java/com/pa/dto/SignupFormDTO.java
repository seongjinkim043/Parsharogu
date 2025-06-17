package com.pa.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

	@Data
	public class SignupFormDTO {
		
		private String loginid;
	    private String password;
	    private String nickname;
	    private String email;
	    private MultipartFile profileImg; // 프로필 이미지 파일
	
	}