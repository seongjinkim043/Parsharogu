package com.pa.pasharogu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class PasharoguApplication {

	public static void main(String[] args) {
		SpringApplication.run(PasharoguApplication.class, args);
	}

}
