package com.pa.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;

@Controller
public class ScheduleController {

    // 서버 내 임시 일정 저장소 (스레드 안전 리스트)
    private final List<Map<String, Object>> scheduleStore = new CopyOnWriteArrayList<>();

    public ScheduleController() {
        // 초기 예시 일정 등록
        Map<String, Object> schedule01 = new HashMap<>();
        schedule01.put("id", "sch01");
        schedule01.put("title", "이건 하드코딩 직접 입력한 거");
        schedule01.put("start", "2025-06-17");
        schedule01.put("end", "2025-06-24");
        schedule01.put("allDay", true);

        Map<String, Object> schedule02 = new HashMap<>();
        schedule02.put("id", "sch02");
        schedule02.put("title", "일정02");
        schedule02.put("start", "2025-05-14T09:00:00");
        schedule02.put("end", "2025-05-16T09:00:00");
        schedule02.put("allDay", false);

        scheduleStore.add(schedule01);
        scheduleStore.add(schedule02);
    }

    // 일정 페이지 호출
    @GetMapping("/schedule.do")
    public String schedulePage() {
        return "schedule";  // schedule.jsp 호출
    }

    // 일정 리스트 반환
    @ResponseBody
    @GetMapping("/scheduleList.do")
    public ResponseEntity<List<Map<String, Object>>> scheduleList() {
        return new ResponseEntity<>(scheduleStore, HttpStatus.OK);
    }

    // 일정 추가 - AJAX POST 요청 처리
    @PostMapping("/scheduleAdd.do")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> scheduleAdd(@RequestBody Map<String, Object> payload) {
        String title = (String) payload.get("title");
        String start = (String) payload.get("start");
        String end = (String) payload.get("end");

        // allDay 판단: start와 end가 날짜만(시간 없는 형식)인지 확인
        boolean allDay = isAllDayEvent(start, end);

        String id = UUID.randomUUID().toString();

        Map<String, Object> event = new HashMap<>();
        event.put("id", id);
        event.put("title", title);
        event.put("start", start);
        event.put("end", end);
        event.put("allDay", allDay);

        scheduleStore.add(event);  // 서버 내 저장소에 추가

        return new ResponseEntity<>(event, HttpStatus.OK);
    }

    // allDay 이벤트 판단 유틸 메서드
    private boolean isAllDayEvent(String start, String end) {
        // 시간이 포함되어 있으면 false, 없으면 true
        if (start == null) return false;

        boolean startIsDateOnly = !start.contains("T");
        boolean endIsDateOnly = (end == null) || !end.contains("T");

        return startIsDateOnly && endIsDateOnly;
    }
}
