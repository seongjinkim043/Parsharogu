package com.pa.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Entity
@Data
public class Ikitai {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name = "region_id")  // DB 실제 컬럼명
    private Region region;

    @ManyToOne
    @JoinColumn(name = "user_id")    // DB 실제 컬럼명
    private User user;
	
	
}
