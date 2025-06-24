package com.pa.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.pa.filter.XSSFilter;

@Configuration
public class FilterConfig {
	@Bean
    public FilterRegistrationBean<XSSFilter> xssFilterRegistration() {
           FilterRegistrationBean<XSSFilter> registrationBean = new FilterRegistrationBean<>();
        
		        registrationBean.setFilter(new XSSFilter());
		        registrationBean.addUrlPatterns("/*");  // 모든 요청에 필터 적용
		        registrationBean.setOrder(1);  // 필터 실행 순서 (필요시 조정)
		
		        return registrationBean;

	}
}
