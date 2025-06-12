package com.pa.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Ikitai {
    @Id @GeneratedValue
    private Long id;

    private String placeName;
    private String memo;

    @ManyToOne
    private User user;
}
