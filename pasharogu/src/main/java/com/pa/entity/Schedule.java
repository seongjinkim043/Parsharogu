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
    @Column(name = "SCHEDULE_ID", length = 50)
    private String scheduleId;

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

    
    @Column(name = "AMOUNT")
    private Integer amount;// 쓴 돈 저장
    
    // ⭐ 추가! (User와 연결)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;
    
    // 기본 생성자 필수
    public Schedule() {}

    // 필요하면 생성자 추가 가능
    public Schedule(String scheduleId, String title, LocalDateTime startDate, LocalDateTime endDate, Integer allDay, User user) {
        this.scheduleId = scheduleId;
        this.title = title;
        this.startDate = startDate;
        this.endDate = endDate;
        this.allDay = allDay;
        this.user = user;
    }

}