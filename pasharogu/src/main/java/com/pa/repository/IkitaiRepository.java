package com.pa.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pa.entity.Ikitai;
import com.pa.entity.Region;
import com.pa.entity.User;

public interface IkitaiRepository extends JpaRepository<Ikitai, Long> {
    List<Ikitai> findByUser(User user);

	Optional<Ikitai> findByUserAndRegion(User user, Region region);
}
