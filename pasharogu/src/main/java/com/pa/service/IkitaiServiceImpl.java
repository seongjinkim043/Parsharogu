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

    @Transactional
    @Override
    public boolean toggleIkitai(Long userId, String regionId) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new IllegalArgumentException("User not found"));

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

    @Override
    @Transactional
    public boolean isAdded(Long userId, String regionId) {
        return ikitaiRepository.existsByUser_UserIdAndRegion_RegionId(userId, regionId);
    }

    @Override
    @Transactional
    public List<IkitaiDTO> getIkitaiListByLoginid(Long userId) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        List<Ikitai> ikitais = ikitaiRepository.findByUser(user);
        
        System.out.println("sadfsadf");

        return ikitais.stream().map(ikitai -> {
            IkitaiDTO dto = new IkitaiDTO();
            dto.setRegionId(ikitai.getRegion().getRegionId());

            // ⭐ JSP 에서 regionName 사용하므로 추가
            dto.setRegionName(ikitai.getRegion().getName());

            // ⭐ 이미지 경로 예시 (원하는 경로 규칙에 맞춰 수정 가능)
            dto.setImageUrl("/images/region/" + ikitai.getRegion().getRegionId() + ".jpg");

            // ⭐ 평균 평점 (현재 Region 에 없음 → 임시 고정 값 사용 중)
            dto.setAverageRating(5.0);

            dto.setLiked(true);

            return dto;
        }).collect(Collectors.toList());
    }

    @Override 
    public int countByUserId(Long userId) {
        List<IkitaiDTO> list = getIkitaiListByLoginid(userId);
        return list.size();
    }

    @Override
    public List<String> getRegionIdsByUser(Long userId) {
        return ikitaiRepository.findRegionIdsByUserId(userId);
    }
}
