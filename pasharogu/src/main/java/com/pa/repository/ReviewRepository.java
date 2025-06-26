package com.pa.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.pa.entity.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByUserUserId(Long userId);
   
    @Query("SELECT r FROM Review r WHERE r.region.regionId = :regionId ORDER BY r.createAt DESC")
    List<Review> findReviewsByRegionIdOrdered(@Param("regionId") String regionId);
	
	  @Query("SELECT AVG(r.rating) FROM Review r WHERE r.regionId = :regionId")
	    Double findAverageRatingByRegionId(@Param("regionId") String regionId);

}