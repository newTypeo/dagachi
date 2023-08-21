package com.dagachi.app.club.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dagachi.app.club.dto.BoardAndImageDto;
import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.club.repository.ClubRepository;
import com.dagachi.app.member.entity.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class ClubServiceImpl implements ClubService {


	@Autowired
	private ClubRepository clubRepository;
	
	
	@Override
	public List<Club> adminClubList(Map<String, Object> params) {
		if((String) params.get("getCount") != null) {
			return clubRepository.adminClubList(params);
		}
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return clubRepository.adminClubList(rowBounds, params);
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
	public List<ClubSearchDto> clubSearch(Map<String, Object> params) {
		if((String) params.get("getCount") != null) {
			return clubRepository.clubSearch(params);
		}
		
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<ClubSearchDto> clubs = clubRepository.clubSearch(rowBounds, params);
		
		// 모임 인원 가져오기
		for (ClubSearchDto club : clubs) 
			club.setMemberCount(clubRepository.countClubMember(club.getClubId()));
		
		return clubs;
	}
	
	
	@Override
	public int clubIdFindByDomain(String domain) {
		return clubRepository.clubIdFindByDomain(domain);
	}
	
	
	@Override
	public List<ClubBoard> boardList(ClubBoard clubBoard) {
		return clubRepository.boardList(clubBoard);
	}
	
	@Override
	public Club findByDomain(String domain) {
		return clubRepository.findByDomain(domain);
	}
	
	@Override
	public ClubBoard findByBoard(ClubBoard _clubBoard) {
		return clubRepository.findByBoard(_clubBoard);
	}
	
	@Override
	public ClubBoard findByBoardId(int boardId) {
		return clubRepository.findByBoardId(boardId);
	}

	@Override
	public int updateBoard(ClubBoard _board) {
		return clubRepository.updateBoard(_board);
	}
	
	@Override
	public List<ManageMember> clubApplyByFindByClubId(int clubId) {
		return clubRepository.clubApplyByFindByClubId(clubId);
	}
	
	
	@Override
	public int clubDisabled(int clubId) {
		return clubRepository.clubDisabled(clubId);
	}
	
	
	@Override
	public List<ClubMember> clubMemberByFindAllByClubId(int clubId) {
		return clubRepository.clubMemberByFindAllByClubId(clubId);
	}
	
	
	@Override
	public List<JoinClubMember> clubMemberInfoByFindByMemberId(List<ClubMember> clubMembers) {
		List<JoinClubMember> joinClubMembers = new ArrayList<>();
		for(ClubMember clubMember : clubMembers) {
			joinClubMembers.add(clubRepository.clubMemberInfoByFindByMemberId(clubMember.getMemberId()));
		}
		
		return joinClubMembers;
	}
		
	@Override
	public int insertClub(Club club) {
		int result = 0;
		// club 저장
		result = clubRepository.insertClub(club);
		log.debug("club = " + club);
		// clubProfile 저장
		ClubProfile clubProfile = ((ClubDetails) club).getClubProfile();
		if(clubProfile != null) {
			clubProfile.setClubId(club.getClubId());
			result = clubRepository.insertClubProfile(clubProfile);
		}
		// clubTag 저장
		for (String tag : ((ClubDetails) club).getTagList()) {
			ClubTag clubTag = new ClubTag(club.getClubId(), tag);
			result = clubRepository.insertClubTag(clubTag);
		}
		return result;
	}
	
	@Override
	public Club findClubById(int clubId) {
		return clubRepository.findClubById(clubId);
	}
	@Override
	public ClubProfile findClubProfileById(int clubId) {
		return clubRepository.findClubProfileById(clubId);
	}
	@Override
	public List<ClubTag> findClubTagById(int clubId) {
		return clubRepository.findClubTagById(clubId);
	}
	
	@Override
	public int updateClub(ClubDetails club) {
		int result = 0;
		// club 저장
		result = clubRepository.updateClub(club);
		log.debug("club = " + club);
		// clubProfile 저장
		ClubProfile clubProfile = ((ClubDetails) club).getClubProfile();
		if(clubProfile != null) {
			clubProfile.setClubId(club.getClubId());
			result = clubRepository.updateClubProfile(clubProfile);
		}
		result = clubRepository.deleteClubTag(club);
		// clubTag 저장
		for (String tag : ((ClubDetails) club).getTagList()) {
			ClubTag clubTag = new ClubTag(club.getClubId(), tag);
			result = clubRepository.insertClubTag(clubTag);
		}
		
		return result;
	}
	@Override
	public int clubMemberRoleUpdate(ClubMemberRoleUpdate member) {
		return clubRepository.clubMemberRoleUpdate(member);
	}


	@Override
	public List<ClubApply> clubApplyfindByClubId(int clubId) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<ClubBoard> boardList(int boardType) {
		return null;
	}
	
	@Override
	public ClubLayout findLayoutById(int clubId) {
		return clubRepository.findLayoutById(clubId);
	}
	
	@Override
	public List<BoardAndImageDto> findBoardAndImageById(int clubId) {
		return clubRepository.findBoardAndImageById(clubId);
	}
}

