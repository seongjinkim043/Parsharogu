package com.pa.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.pa.entity.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByUserUserId(Long userId);
	List<Review> findByRegionRegionId(String regionId);
	
	  @Query("SELECT AVG(r.rating) FROM Review r WHERE r.regionId = :regionId")
	    Double findAverageRatingByRegionId(@Param("regionId") String regionId);

}