package com.pa.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import com.pa.dto.IkitaiDTO;
import com.pa.service.IkitaiService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/ikitai")
@RequiredArgsConstructor
public class IkitaiController {

    private final IkitaiService ikitaiService;

    @PostMapping("/toggle")
    public String toggleIkitai(@RequestBody Map<String, String> payload, HttpSession session) {
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "로그인이 필요합니다.");
        }

        Long userId = (Long) userIdObj;
        String regionId = payload.get("regionId");
        boolean added = ikitaiService.toggleIkitai(userId, regionId);
        System.out.println("TOGGLE: userId=" + userId + ", regionId=" + regionId + ", added=" + added);
        return added ? "added" : "removed";
    }

    @GetMapping("/check")
    public Map<String, Object> checkIkitai(@RequestParam("regionId") String regionId, HttpSession session) {
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return Map.of(
                "isAdded", false,
                "regionId", regionId
            );
        }
        Long userId = (Long) userIdObj;
        boolean isAdded = ikitaiService.isAdded(userId, regionId);
        return Map.of(
            "isAdded", isAdded,
            "regionId", regionId
        );
    }

    // ✅ 추가: 사용자의 이키타이 리스트 반환 (이미지 포함)
    @GetMapping("/list")
    public List<IkitaiDTO> getIkitaiList(HttpSession session) {
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "로그인이 필요합니다.");
        }
        Long userId = (Long) userIdObj;
        return ikitaiService.getIkitaiListByLoginid(userId);
    }
}
