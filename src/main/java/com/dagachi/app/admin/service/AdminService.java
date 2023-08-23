package com.dagachi.app.admin.service;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.dto.AdminInquiryUpdateDto;

public interface AdminService {

	AdminInquiryCreateDto findInquiry(int inquiryId);

	int updateInquiry(AdminInquiryUpdateDto inquiryUpdate);

}
