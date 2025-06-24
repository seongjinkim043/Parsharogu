package com.pa.service;

import java.io.File;
import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.pa.dto.SignupFormDTO;
import com.pa.dto.UserDTO;
import com.pa.entity.User;
import com.pa.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;
    private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    
    @Override
    public UserDTO login(String loginid, String password) {
    	
    	Optional<User> optionalUser = userRepository.findByLoginid(loginid);
    	// 디버그용
    	System.out.println("입력된 비밀번호: " + password);
    	System.out.println("DB 비밀번호: " + optionalUser.get().getPassword());
    	
    	if (optionalUser.isEmpty()) {
    		throw new RuntimeException("아이디 또는 비밀번호가 잘못되었습니다.");
    	}    		
    	User user = optionalUser.get();
    	
    	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        System.out.println("입력된 비밀번호: " + password);
        System.out.println("DB 비밀번호(암호화): " + user.getPassword());
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("아이디 또는 비밀번호가 잘못되었습니다.");
        }
    	
    	UserDTO userDTO = new UserDTO();
    	userDTO.setUserId(user.getUserId());
    	userDTO.setLoginid(user.getLoginid());
    	userDTO.setNickname(user.getNickname());
    	userDTO.setEmail(user.getEmail());
    	userDTO.setProfileImg(user.getProfileImg());
    	
    	return userDTO;
    }

    @Override
    public void signup(SignupFormDTO signupFormDTO) {
        System.out.println("Service reached!!!!");
        
        User user = new User();
        user.setLoginid(signupFormDTO.getLoginid());
        
        String encodedPassword = passwordEncoder.encode(signupFormDTO.getPassword());
        user.setPassword(encodedPassword);
        user.setNickname(signupFormDTO.getNickname());
        user.setEmail(signupFormDTO.getEmail());

        MultipartFile imageFile = signupFormDTO.getProfileImg();

        if (imageFile != null && !imageFile.isEmpty()) {
            try {
            	String uploadDir = "C:/spring_uploads/";
            	File uploadPath = new File(uploadDir);
            	if (!uploadPath.exists()) {
            	    uploadPath.mkdirs();
            	}
            	String originalFilename = imageFile.getOriginalFilename();
            	String fileName = UUID.randomUUID() + "_" + originalFilename;
            	File dest = new File(uploadDir + fileName);
            	imageFile.transferTo(dest);
            	user.setProfileImg("/uploads/" + fileName);
            } catch (IOException e) {
                e.printStackTrace(); 
                throw new RuntimeException("이미지 업로드 실패: " + e.getMessage());
            }
        }	else {
            user.setProfileImg("/img/default-profile.png");
        }
        System.out.println("Saving user to DB................");
        userRepository.save(user);
    }
    
    @Override
    public UserDTO getProfile(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다"));
        UserDTO dto = new UserDTO();
        dto.setUserId(user.getUserId());
        dto.setLoginid(user.getLoginid());
        dto.setNickname(user.getNickname());
        dto.setEmail(user.getEmail());
        dto.setProfileImg(user.getProfileImg());
        return dto;
    }

    	@Override
    	public boolean isLoginidDuplicate(String loginid) {
		  return userRepository.existsByLoginid(loginid); 
		  }
}