package com.pa.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@Entity
@Data
public class Ikitai {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ikitai_seq_gen")
	@SequenceGenerator(name = "ikitai_seq_gen", sequenceName = "IKITAI_SEQ", allocationSize = 1)
	@Column(name = "IKITAI_ID")
	private Long ikitaiId;
	
    @ManyToOne
    @JoinColumn(name = "region_id")  // DB 실제 컬럼명
    private Region region;

    @ManyToOne
    @JoinColumn(name = "user_id")    // DB 실제 컬럼명
    private User user;
	
	
}
