package com.pa.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pa.entity.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByUserUserId(Long userId);
	List<Review> findByRegionRegionId(String regionId);
}