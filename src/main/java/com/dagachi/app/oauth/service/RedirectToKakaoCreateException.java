package com.dagachi.app.oauth.service;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class RedirectToKakaoCreateException extends Exception {
	
    @ExceptionHandler(RedirectToKakaoCreateException.class)
    public String handleRedirectToKakaoCreate() {
        return "redirect:/member/memberKakaoCreate.do";
    }

}
