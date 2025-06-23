package com.pa.service;

import java.util.List;

import com.pa.dto.IkitaiDTO;

public interface IkitaiService {
    boolean toggleIkitai(Long userId, String regionId);

    boolean isAdded(Long userId, String regionId);

    List<IkitaiDTO> getIkitaiListByLoginid(Long userId);
    int countByUserId(Long userId);
}
