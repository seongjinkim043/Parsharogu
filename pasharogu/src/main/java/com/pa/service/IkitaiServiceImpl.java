package com.pa.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.pa.dto.IkitaiDTO;
import com.pa.entity.Ikitai;
import com.pa.entity.Region;
import com.pa.entity.User;
import com.pa.repository.IkitaiRepository;
import com.pa.repository.RegionRepository;
import com.pa.repository.UserRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IkitaiServiceImpl implements IkitaiService {

    private final RegionRepository regionRepository;
    private final UserRepository userRepository;
    private final IkitaiRepository ikitaiRepository;

    @Override
    @Transactional
    public boolean toggleIkitai(String username, String regionId) {
//        User user = userRepository.findByLoginid(username)
//            .orElseThrow(() -> new UsernameNotFoundException("User not found"));
//
//        Region region = regionRepository.findById(regionId)
//            .orElseThrow(() -> new IllegalArgumentException("Region not found"));
//
//        Optional<Ikitai> existing = ikitaiRepository.findByUserAndRegion(user, region);
//
//        if (existing.isPresent()) {
//            ikitaiRepository.delete(existing.get());
//            return false; // removed
//        } else {
//            Ikitai ikitai = new Ikitai();
//            ikitai.setUser(user);
//            ikitai.setRegion(region);
//            ikitaiRepository.save(ikitai);
//            return true; // added
//        }
    	
    	//임시 반환값
    	return true;
    }

    @Override
    @Transactional
    public boolean isAdded(String username, String regionId) {
//        User user = userRepository.findByLoginid(username)
//            .orElseThrow(() -> new UsernameNotFoundException("User not found"));
//
//        Region region = regionRepository.findById(regionId)
//            .orElseThrow(() -> new IllegalArgumentException("Region not found"));
//
//        return ikitaiRepository.existsByUserAndRegion(user, region);
    	
    	//임시 false 반환
    	return false;
    }

    @Override
    @Transactional

    public List<IkitaiDTO> getIkitaiListByLoginid(String loginId) {
//        User user = userRepository.findByLoginid(loginId)
//            .orElseThrow(() -> new UsernameNotFoundException("User not found"));
//
//        List<Ikitai> ikitais = ikitaiRepository.findByUser(user);
//
//        return ikitais.stream().map(ikitai -> {
//            IkitaiDTO dto = new IkitaiDTO();
//            dto.setRegionId(ikitai.getRegion().getRegionId());
//            dto.setImageUrl(ikitai.getRegion().getImageUrl());
//
//            dto.setAverageRating(ikitai.getRegion().getAverageRating()); // 이미 double 타입
//
//            dto.setLiked(true);
//            return dto;
//        }).collect(Collectors.toList());
    	
    	//더미 데이터 반환용
    	IkitaiDTO dummy = new IkitaiDTO();
        dummy.setRegionId("dummyRegion");
        dummy.setImageUrl("dummyImageUrl");
        dummy.setAverageRating(4.5);
        dummy.setLiked(true);

        return List.of(dummy);

    }

}