package com.dagachi.app.admin.service;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.dto.AdminInquiryUpdateDto;
import com.dagachi.app.admin.entity.MainPage;

public interface AdminService {

	AdminInquiryCreateDto findInquiry(int inquiryId);

	int updateInquiry(AdminInquiryUpdateDto inquiryUpdate);

	List<MainPage> getMainBanner();

}
