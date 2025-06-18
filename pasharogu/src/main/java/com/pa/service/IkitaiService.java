package com.pa.service;

import java.util.Optional;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.pa.entity.Ikitai;
import com.pa.entity.Region;
import com.pa.entity.User;
import com.pa.repository.IkitaiRepository;
import com.pa.repository.RegionRepository;
import com.pa.repository.UserRepository;

import jakarta.transaction.Transactional;
import lombok.Data;
import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
@Data
public class IkitaiService {

    private final RegionRepository regionRepository;
    private final UserRepository userRepository;
    private final IkitaiRepository ikitaiRepository;

    @Transactional
    public boolean toggleIkitai(String username, String regionId) {
        User user = userRepository.findByUsername(username)
            .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        Region region = regionRepository.findById(regionId)
            .orElseThrow(() -> new IllegalArgumentException("Region not found"));

        Optional<Ikitai> existing = ikitaiRepository.findByUserAndRegion(user, region); 


        if (existing.isPresent()) {
            ikitaiRepository.delete(existing.get());
            return false; // removed
        } else {
            Ikitai ikitai = new Ikitai();
            ikitai.setUser(user);
            ikitai.setRegion(region);
            ikitaiRepository.save(ikitai);
            return true; // added
        }
    }
}
