package com.pa.controller;

import com.pa.dto.UserDTO;
import com.pa.entity.Schedule;
import com.pa.entity.User;
import com.pa.repository.UserRepository;
import com.pa.service.ScheduleService;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Controller
public class ScheduleController {

    private final ScheduleService scheduleService;
    private final UserRepository userRepository;

    public ScheduleController(ScheduleService scheduleService, UserRepository userRepository) {
        this.scheduleService = scheduleService;
        this.userRepository = userRepository;
    }

    @GetMapping("/schedule.do")
    public String schedulePage() {
        return "schedule";
    }

    @GetMapping("/index")
    public String index() {
        return "index";
    }

    // ✅ 유저별 일정 조회
    @ResponseBody
    @GetMapping("/scheduleList.do")
    public ResponseEntity<List<Map<String, Object>>> scheduleList(
            @SessionAttribute("loginUser") UserDTO userDto) {

        List<Schedule> schedules = scheduleService.findByUser(userDto.getUserId());

        List<Map<String, Object>> response = schedules.stream().map(schedule -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", schedule.getScheduleId());
            map.put("title", schedule.getTitle());
            map.put("start", schedule.getStartDate().toString());
            map.put("end", schedule.getEndDate() != null ? schedule.getEndDate().toString() : schedule.getStartDate().toString());
            map.put("allDay", false);

            long daysBetween = ChronoUnit.DAYS.between(
                    schedule.getStartDate().toLocalDate(),
                    schedule.getEndDate() != null ? schedule.getEndDate().toLocalDate() : schedule.getStartDate().toLocalDate()
            );
            map.put("multiDayFlag", daysBetween >= 1);

            return map;
        }).toList();

        return ResponseEntity.ok(response);
    }

    // ✅ 일정 추가
    @ResponseBody
    @PostMapping("/scheduleAdd.do")
    public ResponseEntity<Map<String, Object>> scheduleAdd(
            @SessionAttribute("loginUser") UserDTO userDto,
            @RequestBody Map<String, Object> payload) {

        // 실제 DB에 있는 User 엔티티 조회
        User user = userRepository.findById(userDto.getUserId())
                .orElseThrow(() -> new RuntimeException("존재하지 않는 사용자입니다."));

        Schedule schedule = new Schedule();
        schedule.setScheduleId(UUID.randomUUID().toString());
        schedule.setTitle((String) payload.get("title"));
        schedule.setStartDate(LocalDateTime.parse((String) payload.get("start")));

        if (payload.get("end") != null && !payload.get("end").toString().isEmpty()) {
            schedule.setEndDate(LocalDateTime.parse((String) payload.get("end")));
        } else {
            schedule.setEndDate(null);
        }

        schedule.setAllDay(0);
        schedule.setUser(user);

        Schedule saved = scheduleService.save(schedule);

        Map<String, Object> response = new HashMap<>();
        response.put("id", saved.getScheduleId());
        response.put("title", saved.getTitle());
        response.put("start", saved.getStartDate().toString());
        response.put("end", saved.getEndDate() != null ? saved.getEndDate().toString() : saved.getStartDate().toString());
        response.put("allDay", false);

        long daysBetween = ChronoUnit.DAYS.between(
                saved.getStartDate().toLocalDate(),
                saved.getEndDate() != null ? saved.getEndDate().toLocalDate() : saved.getStartDate().toLocalDate()
        );
        response.put("multiDayFlag", daysBetween >= 1);

        return ResponseEntity.ok(response);
    }

    // ✅ 일정 수정
    @ResponseBody
    @PostMapping("/scheduleUpdate.do")
    public ResponseEntity<Void> scheduleUpdate(
            @SessionAttribute("loginUser") UserDTO userDto,
            @RequestBody Map<String, Object> payload) {

        Schedule schedule = scheduleService.findById((String) payload.get("id"));

        if (!schedule.getUser().getUserId().equals(userDto.getUserId())) {
            return ResponseEntity.status(403).build(); // 권한 없음
        }

        schedule.setTitle((String) payload.get("title"));
        schedule.setStartDate(LocalDateTime.parse((String) payload.get("start")));

        if (payload.get("end") != null && !payload.get("end").toString().isEmpty()) {
            schedule.setEndDate(LocalDateTime.parse((String) payload.get("end")));
        } else {
            schedule.setEndDate(null);
        }

        schedule.setAllDay(0);
        scheduleService.save(schedule);

        return ResponseEntity.ok().build();
    }

    // ✅ 일정 삭제
    @ResponseBody
    @PostMapping("/scheduleDelete.do")
    public ResponseEntity<Void> scheduleDelete(
            @SessionAttribute("loginUser") UserDTO userDto,
            @RequestBody Map<String, Object> payload) {

        Schedule schedule = scheduleService.findById((String) payload.get("id"));

        if (!schedule.getUser().getUserId().equals(userDto.getUserId())) {
            return ResponseEntity.status(403).build(); // 권한 없음
        }

        scheduleService.deleteById(schedule.getScheduleId());

        return ResponseEntity.ok().build();
    }
}
