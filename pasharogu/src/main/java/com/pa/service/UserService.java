package com.pa.service;

import com.pa.dto.UserDTO;

public interface UserService {
    void signup(UserDTO userDTO);
    UserDTO getProfile(Long userId);
}

