package com.dagachi.app.club.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.repository.ClubRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ClubServiceImpl implements ClubService {

	@Autowired
	private ClubRepository clubRepository;
	
	@Override
	public List<Club> clubSearch(String keyword, String column) {
		return clubRepository.clubSearch(keyword, column);
	}
	
	@Override
	public List<Club> adminClubList() {
		return clubRepository.adminClubList();
	}
	
	@Override
	public List<ClubAndImage> clubList() {
		return clubRepository.clubList();
	}
	
}
