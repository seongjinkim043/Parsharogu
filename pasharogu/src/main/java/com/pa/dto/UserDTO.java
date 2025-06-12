package com.pa.dto;

import lombok.Data;

@Data
public class UserDTO {

    private Long userId;
    private String username;
    private String password;
    private String email;
    private String bio;
    private String profileImg;

    // 생성자, getter/setter 생략
}
