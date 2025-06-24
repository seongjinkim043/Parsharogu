package com.pa.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;

public class XSSFilter implements Filter{
    public FilterConfig filterConfig;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    	// TODO Auto-generated method stub
    	this.filterConfig = filterConfig;
    }

    public void destroy(){
        this.filterConfig = null;
    }

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		chain.doFilter(new RequestWrapper((HttpServletRequest) request), response);
		
	}
}