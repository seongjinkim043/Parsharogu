package com.pa.dto;

import lombok.Data;

@Data
public class UserDTO {

    private Long userId;
    private String loginid;
    private String password;
    private String nickname;
    private String email;
    private String profileImg;
//  private String bio;
}