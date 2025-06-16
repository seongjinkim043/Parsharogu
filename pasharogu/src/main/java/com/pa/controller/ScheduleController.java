package com.pa.controller;

import com.pa.entity.Schedule;
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

    public ScheduleController(ScheduleService scheduleService) {
        this.scheduleService = scheduleService;
    }

    @GetMapping("/schedule.do")
    public String schedulePage() {
        return "schedule";
    }
    

    @GetMapping("/index")
       public String index() {
       	return "index";
       }

    @ResponseBody
    @GetMapping("/scheduleList.do")
    public ResponseEntity<List<Map<String, Object>>> scheduleList() {
        List<Schedule> schedules = scheduleService.findAll();

        List<Map<String, Object>> response = schedules.stream().map(schedule -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", schedule.getScheduleId());
            map.put("title", schedule.getTitle());
            map.put("start", schedule.getStartDate().toString());

            if (schedule.getEndDate() != null) {
                map.put("end", schedule.getEndDate().toString());
            } else {
                map.put("end", schedule.getStartDate().toString());
            }

            // DayView 정상 표시를 위해 allDay false 고정
            map.put("allDay", false);

            // multiDayFlag 계산
            long daysBetween = ChronoUnit.DAYS.between(
                schedule.getStartDate().toLocalDate(),
                schedule.getEndDate() != null ? schedule.getEndDate().toLocalDate() : schedule.getStartDate().toLocalDate()
            );
            map.put("multiDayFlag", daysBetween >= 1);

            return map;
        }).toList();

        return ResponseEntity.ok(response);
    }

    @ResponseBody
    @PostMapping("/scheduleAdd.do")
    public ResponseEntity<Map<String, Object>> scheduleAdd(@RequestBody Map<String, Object> payload) {
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

    @ResponseBody
    @PostMapping("/scheduleUpdate.do")
    public ResponseEntity<Void> scheduleUpdate(@RequestBody Map<String, Object> payload) {
        String id = (String) payload.get("id");
        Schedule schedule = scheduleService.findById(id);

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

    @ResponseBody
    @PostMapping("/scheduleDelete.do")
    public ResponseEntity<Void> scheduleDelete(@RequestBody Map<String, Object> payload) {
        String id = (String) payload.get("id");
        scheduleService.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
