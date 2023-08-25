package com.dagachi.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.dto.AdminInquiryUpdateDto;
import com.dagachi.app.admin.entity.AdminInquiry;
import com.dagachi.app.admin.entity.MainPage;

public interface AdminService {

	AdminInquiry findInquiry(int inquiryId);

	int updateInquiry(AdminInquiryUpdateDto inquiryUpdate);

	List<MainPage> getMainBanner();

	Map<String, Object> adminInquiryList(Map<String, Object> params);

}
