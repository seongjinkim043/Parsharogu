package com.pa.dto;
import lombok.Data;

public class ScheduleDTO {

	private String id;
    private String title;
    private String start;  // FullCalendar는 문자열 "yyyy-MM-ddTHH:mm:ss" 형식으로 요구
    private String end;
    private boolean allDay;
    
    // Optional: createdAt 제외해도 무방
    private String createdAt;

    // Getters & Setters
	
}
