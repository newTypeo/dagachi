package com.dagachi.app.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.dto.AdminInquiryUpdateDto;
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
	public AdminInquiryCreateDto findInquiry(int inquiryId) {
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
}
