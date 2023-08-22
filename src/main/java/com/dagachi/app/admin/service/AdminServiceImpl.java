package com.dagachi.app.admin.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dagachi.app.club.service.ClubServiceImpl;
import com.dagachi.app.member.service.MemberServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService{

}
