package com.pa.dto;

import lombok.Data;

	@Data
	public class SignupFormDTO {
	    private String loginid;
	    private String nickname;
	    private String email;
	    private String password;
	    private String profileImg; // 프로필 이미지 경로
	    
	    // getter/setter
	}

