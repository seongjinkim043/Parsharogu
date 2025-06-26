package com.pa.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.pa.entity.Schedule;
import com.pa.repository.ScheduleRepository;

@Service
public class ScheduleService {

    private final ScheduleRepository scheduleRepository;

    public ScheduleService(ScheduleRepository scheduleRepository) {
        this.scheduleRepository = scheduleRepository;
    }

    public List<Schedule> findAll() {
        return scheduleRepository.findAll();
    }

    public Schedule save(Schedule schedule) {
        return scheduleRepository.save(schedule);
    }

    public void deleteById(String id) {
        scheduleRepository.deleteById(id);
    }

    public Schedule findById(String id) {
        return scheduleRepository.findById(id).orElseThrow(() -> new RuntimeException("Schedule not found"));
    }

    public Integer getMonthlyTotal(String yearMonth) {
        return scheduleRepository.getMonthlyTotal(yearMonth);
    }

    public Map<String, Integer> getDailyAmountMap(String yearMonth) {
        List<Object[]> results = scheduleRepository.getDailyAmountMap(yearMonth);

        return results.stream()
                .collect(Collectors.toMap(
                        r -> (String) r[0],
                        r -> ((Number) r[1]).intValue()
                ));
    }

    // ⭐ 유저별 일정 조회 추가
    public List<Schedule> findByUser(Long userId) {
        return scheduleRepository.findByUserUserId(userId);
    }
}
