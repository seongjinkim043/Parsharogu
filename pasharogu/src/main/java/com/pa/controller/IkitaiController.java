package com.pa.controller;

import java.security.Principal;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.pa.service.IkitaiService;

import lombok.RequiredArgsConstructor;


@RestController
@RequestMapping("/ikitai")
@RequiredArgsConstructor
public class IkitaiController {

    private final IkitaiService ikitaiService;

    @PostMapping("/toggle")
    @ResponseBody
    public String toggleIkitai(@RequestParam("regionId") String regionId, Principal principal) {
        String username = principal.getName();
        boolean added = ikitaiService.toggleIkitai(username, regionId);
        return added ? "added" : "removed";
    }
    
    @GetMapping("/check")
    @ResponseBody
    public boolean checkIkitai(@RequestParam("regionId") String regionId, Principal principal) {
        String username = principal.getName();
        return ikitaiService.isAdded(username, regionId);
    }
}
    
