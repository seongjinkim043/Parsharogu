package com.pa.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Entity
@Data
public class Ikitai {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private User user;            // 등록한 사용자
    @ManyToOne
    private Region region;
	
	
}
