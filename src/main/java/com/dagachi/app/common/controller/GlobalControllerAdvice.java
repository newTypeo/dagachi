package com.dagachi.app.common.controller;

import javax.validation.ConstraintViolationException;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class GlobalControllerAdvice {
	
	//Exception 클래스의 하위 예외 가 발생하더라도 처리하는 핸들러
	// 로그에 예외 메시지와 스택 트레이스를 출력한 후 "common/error" 뷰를 반환
	@ExceptionHandler
	public String exceptionHandler(Exception e) {
		log.error(e.getMessage(), e);
		return "common/error";
	}
	
	//ConstraintViolationException이 발생할 때 호출
	// 데이터 유효성 검사,제약 조건과 관련된 오류 
	@ExceptionHandler(ConstraintViolationException.class)
	public String invalidRequestValue(ConstraintViolationException e) {
		log.error(" 입력값 오류 " + e.getMessage(), e);
		return "common/error";
	}

}
