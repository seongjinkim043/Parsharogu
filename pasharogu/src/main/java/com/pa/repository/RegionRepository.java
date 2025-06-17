package com.pa.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pa.entity.Region;

public interface RegionRepository extends JpaRepository<Region, String> {

}
