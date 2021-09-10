package com.pmg.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;
@Log4j
public class Intercep extends HandlerInterceptorAdapter{
		@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
			HttpSession session = request.getSession();
			System.out.println("인터셉터여");
			if(session == null) {
				System.out.println("세션 널이여");
				response.sendRedirect("/user/signUp");
				return false;
			}
			return true;
		}
	}
