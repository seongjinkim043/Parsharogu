package com.pa.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "users") // DB 테이블명은 관례상 소문자+복수형
public class User {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;
    
    @Column(nullable = false, unique = true)
    private String loginid;     // 아이디 (예: みょんみょん36)
    
    @Column(nullable = false)
    private String password;     // 비밀번호 (예: ヨルシカ01)
    
    @Column(nullable = false, unique = true)  
    private String nickname;    // 닉네임 (예: 黒川７７)
    
    private String email;	// 이메일
    private String profileImg; // 이미지 경로     

    // 기본 생성자
    public User() {}
   
}