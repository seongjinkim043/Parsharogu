package com.pa.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.pa.entity.Ikitai;
import com.pa.entity.Region;
import com.pa.entity.User;

public interface IkitaiRepository extends JpaRepository<Ikitai, Long> {
    List<Ikitai> findByUser(User user);

	Optional<Ikitai> findByUserAndRegion(User user, Region region);
	
	boolean existsByUserAndRegion(User user, Region region);
	
	@Query("SELECT i.region.regionId FROM Ikitai i WHERE i.user.userId = :userId")
    List<String> findRegionIdsByUserId(@Param("userId") Long userId);
}
