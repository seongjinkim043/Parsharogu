package com.pa.controller;

import com.pa.entity.Schedule;
import com.pa.service.ScheduleService;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class ScheduleController {

    // 서비스 주입
    private final ScheduleService scheduleService;

    public ScheduleController(ScheduleService scheduleService) {
        this.scheduleService = scheduleService;
    }

    // 페이지 호출
    @GetMapping("/schedule.do")
    public String schedulePage() {
        return "schedule"; // schedule.jsp 호출
    }

    // 일정 리스트 반환 (FullCalendar 형식에 맞춤)
    @ResponseBody
    @GetMapping("/scheduleList.do")
    public ResponseEntity<List<Map<String, Object>>> scheduleList() {
        List<Schedule> schedules = scheduleService.findAll();

        List<Map<String, Object>> response = schedules.stream().map(schedule -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", schedule.getId());
            map.put("title", schedule.getTitle());
            map.put("start", schedule.getStartDate().toLocalDate().toString());

            // end 처리 → FullCalendar는 end 날짜 '다음날'까지 표시해야 함 (+1 day)
            if (schedule.getEndDate() != null) {
                map.put("end", schedule.getEndDate().toLocalDate().plusDays(1).toString());
            } else {
                map.put("end", schedule.getStartDate().toLocalDate().plusDays(1).toString());
            }

            map.put("allDay", schedule.getAllDay() == 1);

            return map;
        }).toList();

        return ResponseEntity.ok(response);
    }

    // 일정 추가
    @ResponseBody
    @PostMapping("/scheduleAdd.do")
    public ResponseEntity<Schedule> scheduleAdd(@RequestBody Map<String, Object> payload) {
        Schedule schedule = new Schedule();
        schedule.setId(UUID.randomUUID().toString());
        schedule.setTitle((String) payload.get("title"));

        // 날짜 포맷터
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

        // 시작일 설정
        schedule.setStartDate(LocalDateTime.parse(payload.get("start") + "T00:00:00", formatter));

        // 종료일 설정
        if (payload.get("end") != null && !payload.get("end").toString().isEmpty()) {
            schedule.setEndDate(LocalDateTime.parse(payload.get("end") + "T00:00:00", formatter));
        } else {
            schedule.setEndDate(null);
        }

        // allDay 처리 (1 고정)
        schedule.setAllDay(1);

        // 저장 처리
        Schedule saved = scheduleService.save(schedule);

        return ResponseEntity.ok(saved);
    }

    // 일정 삭제
    @ResponseBody
    @PostMapping("/scheduleDelete.do")
    public ResponseEntity<Void> scheduleDelete(@RequestBody Map<String, Object> payload) {
        String id = (String) payload.get("id");
        scheduleService.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
