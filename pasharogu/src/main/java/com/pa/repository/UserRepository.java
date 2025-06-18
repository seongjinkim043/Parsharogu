package com.pa.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pa.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {

	Optional<User> findByLoginid(String username);      // 로그인 시 사용
    Optional<User> findByNickname(String nickname);    // 닉네임으로 검색 JM
    Optional<User> findByEmail(String email);          // 이메일로 검색 JM
	boolean existsByLoginid(String loginid);
}

