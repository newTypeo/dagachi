package com.dagachi.app.admin.service;

import java.util.List;
import java.util.Map;

import com.dagachi.app.admin.dto.AdminInquiryUpdateDto;
import com.dagachi.app.admin.entity.AdminInquiry;
import com.dagachi.app.admin.entity.MainPage;
import com.dagachi.app.club.entity.ClubBoardAttachment;

public interface AdminService {

	AdminInquiry findInquiry(int inquiryId);

	int updateInquiry(AdminInquiryUpdateDto inquiryUpdate);

	List<MainPage> getMainBanner();



	List<AdminInquiry> adminInquiryList(AdminInquiry adminInquiry, Map<String, Object> params);
	int inquirySize(AdminInquiry adminInquiry);

	List<AdminInquiry> searchInquirys(Map<String, Object> searchInquirydMap, Map<String, Object> params);
	List<AdminInquiry> searchInquiry(Map<String, Object> searchInquirydMap);

	int updateBanner(ClubBoardAttachment attach);


}
