package com.dagachi.app.club.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.repository.ClubRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ClubServiceImpl implements ClubService {

	@Autowired
	private ClubRepository clubRepository;
	
	@Override
	public List<Club> clubSearch(String keyword) {
		return clubRepository.clubSearch(keyword);
	}
	
	@Override
	public List<Club> adminClubList() {
		return clubRepository.adminClubList();
	}
	
}
