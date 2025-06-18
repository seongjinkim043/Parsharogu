package com.pa.service;

import java.io.File;
import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pa.dto.SignupFormDTO;
import com.pa.dto.UserDTO;
import com.pa.entity.User;
import com.pa.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public void signup(SignupFormDTO signupFormDTO) {
        System.out.println("🔥 Service reached!");
        
        User user = new User();
        user.setLoginid(signupFormDTO.getLoginid());
        user.setPassword(signupFormDTO.getPassword());
        user.setNickname(signupFormDTO.getNickname());
        user.setEmail(signupFormDTO.getEmail());

        MultipartFile imageFile = signupFormDTO.getProfileImg();

        if (imageFile != null && !imageFile.isEmpty()) {
            try {
            	String uploadDir = "C:/spring_uploads/"; // 16번의 시도 끝의 결정 = 절대 경로로 지정

            	File uploadPath = new File(uploadDir);
            	if (!uploadPath.exists()) {
            	    uploadPath.mkdirs();
            	}

            	String originalFilename = imageFile.getOriginalFilename();
            	String fileName = UUID.randomUUID() + "_" + originalFilename;
            	File dest = new File(uploadDir + fileName);

            	// 서버에 파일 저장
            	imageFile.transferTo(dest);

            	// DB에는 경로로 저장
            	user.setProfileImg("/uploads/" + fileName);
            } catch (IOException e) {
                e.printStackTrace(); // 에러 로그
                throw new RuntimeException("이미지 업로드 실패: " + e.getMessage());
            }
        }

        System.out.println("Saving user to DB...");
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

