package com.pa.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pa.entity.Schedule;
import com.pa.repository.ScheduleRepository;

@Service
public class ScheduleService {

    private final ScheduleRepository scheduleRepository;

    public ScheduleService(ScheduleRepository scheduleRepository) {
        this.scheduleRepository = scheduleRepository;
    }

    // 전체 일정 조회
    public List<Schedule> findAll() {
        return scheduleRepository.findAll();
    }

    // 일정 저장
    public Schedule save(Schedule schedule) {
        return scheduleRepository.save(schedule);
    }

    // 일정 삭제
    public void deleteById(String id) {
        scheduleRepository.deleteById(id);
    }
}