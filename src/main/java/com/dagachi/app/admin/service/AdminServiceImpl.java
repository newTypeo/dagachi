package com.dagachi.app.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.dto.AdminInquiryUpdateDto;
import com.dagachi.app.admin.entity.AdminInquiry;
import com.dagachi.app.admin.entity.MainPage;
import com.dagachi.app.admin.repository.AdminRepository;
import com.dagachi.app.club.service.ClubServiceImpl;
import com.dagachi.app.member.service.MemberServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService{
	
	
	@Autowired
	private AdminRepository  adminRepository;
	
	@Override
	public AdminInquiry findInquiry(int inquiryId) {
		return adminRepository.findInquiry(inquiryId);
	}

	@Override
	public int updateInquiry(AdminInquiryUpdateDto inquiryUpdate) {
		return adminRepository.updateInquiry(inquiryUpdate);
	}
	
	@Override
	public List<MainPage> getMainBanner() {
		return adminRepository.getMainBanner();
	}



	@Override
	public List<AdminInquiry> adminInquiryList(AdminInquiry adminInquiry, Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return adminRepository.inquiryList(adminInquiry,rowBounds);
	}

	@Override
	public int inquirySize(AdminInquiry adminInquiry) {
		return adminRepository.inquirySize(adminInquiry);
	}

	@Override
	public List<AdminInquiry> searchInquirys(Map<String, Object> searchInquirydMap, Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return adminRepository.searchInquirys(searchInquirydMap,rowBounds);
	}

	@Override
	public List<AdminInquiry> searchInquiry(Map<String, Object> searchInquirydMap) {
		return adminRepository.searchInquiry(searchInquirydMap);
	}


}
