package com.pa.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Entity
@Table(name = "SCHEDULE")
@Getter
@Setter
@ToString
public class Schedule {

    @Id
    @Column(name = "ID", length = 50)
    private String id;

    @Column(name = "TITLE", nullable = false, length = 100)
    private String title;

    @Column(name = "START_DATE", nullable = false)
    private LocalDateTime startDate;

    @Column(name = "END_DATE")
    private LocalDateTime endDate;

    @Column(name = "ALL_DAY", nullable = false)
    private Integer allDay;

    @Column(name = "CREATED_AT", updatable = false, insertable = false)
    private LocalDateTime createdAt;

    // 기본 생성자 필수
    public Schedule() {}

    // 필요하면 생성자 추가 가능
    public Schedule(String id, String title, LocalDateTime startDate, LocalDateTime endDate, Integer allDay) {
        this.id = id;
        this.title = title;
        this.startDate = startDate;
        this.endDate = endDate;
        this.allDay = allDay;
    }
}