package com.pa.repository;

import com.pa.entity.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, String> {

    @Query("SELECT COALESCE(SUM(s.amount), 0) FROM Schedule s WHERE FUNCTION('DATE_FORMAT', s.startDate, '%Y-%m') = :yearMonth")
    Integer getMonthlyTotal(@Param("yearMonth") String yearMonth);

    @Query("SELECT FUNCTION('DATE_FORMAT', s.startDate, '%Y-%m-%d'), COALESCE(SUM(s.amount), 0) " +
           "FROM Schedule s " +
           "WHERE FUNCTION('DATE_FORMAT', s.startDate, '%Y-%m') = :yearMonth " +
           "GROUP BY FUNCTION('DATE_FORMAT', s.startDate, '%Y-%m-%d')")
    List<Object[]> getDailyAmountMap(@Param("yearMonth") String yearMonth);

}
