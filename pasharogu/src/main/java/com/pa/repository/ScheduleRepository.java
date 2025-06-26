package com.pa.repository;

import com.pa.entity.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, String> {

    // ⭐ 유저별 일정 조회 추가
    List<Schedule> findByUserUserId(Long userId);

    // 기존 금액 관련 쿼리
    @Query(value = "SELECT COALESCE(SUM(amount), 0) " +
                   "FROM schedule " +
                   "WHERE TO_CHAR(start_date, 'YYYY-MM') = :yearMonth", nativeQuery = true)
    Integer getMonthlyTotal(@Param("yearMonth") String yearMonth);

    @Query(value = "SELECT TO_CHAR(start_date, 'YYYY-MM-DD'), COALESCE(SUM(amount), 0) " +
                   "FROM schedule " +
                   "WHERE TO_CHAR(start_date, 'YYYY-MM') = :yearMonth " +
                   "GROUP BY TO_CHAR(start_date, 'YYYY-MM-DD')", nativeQuery = true)
    List<Object[]> getDailyAmountMap(@Param("yearMonth") String yearMonth);
}
