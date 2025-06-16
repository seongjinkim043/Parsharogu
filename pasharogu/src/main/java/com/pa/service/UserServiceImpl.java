package com.pa.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pa.dto.SignupFormDTO;
import com.pa.dto.UserDTO;
import com.pa.entity.User;
import com.pa.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override //담당 JM
    public void signup(SignupFormDTO signupFormDTO) {
        User user = new User();
        user.setLoginid(signupFormDTO.getLoginid());
        user.setPassword(signupFormDTO.getPassword()); // 해시처리 필요
        user.setNickname(signupFormDTO.getNickname());
        user.setEmail(signupFormDTO.getEmail());
        user.setProfileImg(signupFormDTO.getProfileImg());
        userRepository.save(user);
    }

    @Override
    public UserDTO getProfile(Long userId) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다"));

        UserDTO dto = new UserDTO();
        dto.setUserId(user.getUserId());
        dto.setLoginid(user.getLoginid());
        dto.setNickname(user.getNickname());
        dto.setEmail(user.getEmail());
        dto.setProfileImg(user.getProfileImg());
//		dto.setBio(user.getBio());
        return dto;
    }

    @Override //담당자 JM
    public UserDTO login(String loginid, String password) {
        // 1. 사용자 조회
        Optional<User> optionalUser = userRepository.findByLoginid(loginid);
        
        System.out.println("입력된 비밀번호: " + password);
        System.out.println("DB 비밀번호: " + optionalUser.get().getPassword());
        // 2. 사용자 존재 여부 및 비밀번호 확인
        if (optionalUser.isEmpty() || !optionalUser.get().getPassword().equals(password)) {
            
        	throw new RuntimeException("아이디 또는 비밀번호가 잘못되었습니다.");
        }
        // 3. 로그인 성공 시 UserDTO로 변환하여 반환
        User user = optionalUser.get();
        UserDTO userDTO = new UserDTO();
        userDTO.setUserId(user.getUserId());
        userDTO.setLoginid(user.getLoginid());
        userDTO.setNickname(user.getNickname());
        userDTO.setEmail(user.getEmail());
        userDTO.setProfileImg(user.getProfileImg());
        
        return userDTO;
    }

}

