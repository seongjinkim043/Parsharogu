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
import com.pa.repository.ReviewRepository;
import com.pa.repository.UserRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IkitaiServiceImpl implements IkitaiService {

    private final RegionRepository regionRepository;
    private final UserRepository userRepository;
    private final IkitaiRepository ikitaiRepository;
    private final ReviewRepository reviewRepository;

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

        return ikitais.stream().map(ikitai -> {
            IkitaiDTO dto = new IkitaiDTO();
            dto.setRegionId(ikitai.getRegion().getRegionId());

            // ✅ JSP에서 출력용 데이터 설정
            dto.setRegionName(ikitai.getRegion().getName());
            dto.setImageUrl(ikitai.getRegion().getImagePath());  // ✅ DB 경로 그대로 사용

            // ✅ 평균 평점 계산
            Double avgRating = reviewRepository.findAverageRatingByRegionId(ikitai.getRegion().getRegionId());
            dto.setAverageRating(avgRating != null ? Math.round(avgRating * 10) / 10.0 : 0.0);

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

	@Override
	public List<IkitaiDTO> getIkitaiListForUser(Long userId) {
		// TODO Auto-generated method stub
		return null;
	}
}
