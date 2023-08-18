package com.dagachi.app.club.service;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.repository.ClubRepository;
import com.dagachi.app.member.entity.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ClubServiceImpl implements ClubService {

	@Autowired
	private ClubRepository clubRepository;
	
	
	@Override
	public List<Club> adminClubSearch(String keyword, String column) {
		return clubRepository.adminClubSearch(keyword, column);
	}
	
	
	@Override
	public List<Club> adminClubList() {
		return clubRepository.adminClubList();
	}
	
	
	@Override
	public List<ClubAndImage> clubList() {
		return clubRepository.clubList();
	}
	
	
	@Override
	public List<Member> adminMemberList() {
		return clubRepository.adminMemberList();
	}
	
	
	@Override
	public List<ClubSearchDto> clubSearch(String inputText) {
		List<ClubSearchDto> clubs = clubRepository.clubSearch(inputText);
		// 모임 인원 가져오기
		for (ClubSearchDto club : clubs) club.setMemberCount(clubRepository.countClubMember(club.getClubId()));
		return clubs;
	}
	
	
	@Override
	public int clubIdFindByDomain(String domain) {
		return clubRepository.clubIdFindByDomain(domain);
	}
	
	
	@Override
	public List<ClubBoard> boardList(int boardType) {
		return clubRepository.boardList(boardType);
	}
	
	
	@Override
	public List<ManageMember> clubApplyByFindByClubId(int clubId) {
		return clubRepository.clubApplyByFindByClubId(clubId);
	}
		
	@Override
	public int clubDisabled(int clubId) {
		return clubRepository.clubDisabled(clubId);
	}
	
}
