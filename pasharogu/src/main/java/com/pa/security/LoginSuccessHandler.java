package com.pa.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;
//공사중 주의!공사중 주의!공사중 주의!공사중 주의!공사중 주의!공사중 주의!공사중 주의!공사중 주의!공사중 주의!공사중 주의!공사중 주의!
//@Log4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

//	@Override
//	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
//			throws IOException, ServletException {
//
//		log.warn("Login Success");
//
//		List<String> roleNames = new ArrayList<>();
//
//		auth.getAuthorities().forEach(authority -> {
//
//			roleNames.add(authority.getAuthority());
//
//		});
//
//		log.warn("ROLE NAMES: " + roleNames);
//
//		if (roleNames.contains("ROLE_ADMIN")) {
//
//			response.sendRedirect("/sample/admin");
//			return;
//		}
//
//		if (roleNames.contains("ROLE_MEMBER")) {
//
//			response.sendRedirect("/sample/member");
//			return;
//		}
//
//		response.sendRedirect("/");
//	}
}
