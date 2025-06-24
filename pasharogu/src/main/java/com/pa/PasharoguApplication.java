package com.pa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;

import com.pa.filter.XSSFilter;


@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class PasharoguApplication {

	public static void main(String[] args) {
		SpringApplication.run(PasharoguApplication.class, args);
	}
	
	 	@Bean
	    public FilterRegistrationBean<XSSFilter> xssFilterRegistration() {
	        FilterRegistrationBean<XSSFilter> registrationBean = new FilterRegistrationBean<>();
	        
	        registrationBean.setFilter(new XSSFilter());
	        registrationBean.addUrlPatterns("/*");  // 모든 요청에 필터 적용
	        registrationBean.setOrder(1);  // 필터 실행 순서 (필요시 조정)

	        return registrationBean;
	    }

} 