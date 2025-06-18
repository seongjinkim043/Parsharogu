package com.pa.service;

import com.pa.dto.SignupFormDTO;
import com.pa.dto.UserDTO;

public interface UserService {
	 void signup(SignupFormDTO signupFormDTO);
    UserDTO login(String loginid, String password);
    UserDTO getProfile(Long userId);
	boolean isLoginidDuplicate(String loginid); 
}

