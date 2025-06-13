package com.pa.dto;

import lombok.Data;

@Data
public class ScheduleDTO {
    private int scheduleId;
    private String description;
    private String startDate;
    private String endDate;
}
