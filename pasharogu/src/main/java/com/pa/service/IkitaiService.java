package com.pa.service;

import java.util.List;

import com.pa.dto.IkitaiDTO;

public interface IkitaiService {
    boolean toggleIkitai(String username, String regionId);

    boolean isAdded(String username, String regionId);

    List<IkitaiDTO> getIkitaiListByLoginid(String userId);
}
