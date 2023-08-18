package com.dagachi.app.club.service;

import java.util.List;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.member.entity.Member;

public interface ClubService {

	List<Club> adminClubSearch(String keyword, String column);

	
	List<Club> adminClubList();

	
	List<ClubAndImage> clubList();

	
	List<Member> adminMemberList();

	
	List<ClubSearchDto> clubSearch(String inputText);

	
	int clubIdFindByDomain(String domain);

	
	List<ClubBoard> boardList(int boardType);

	
	List<ManageMember> clubApplyByFindByClubId(int clubId);
	
	
	int clubDisabled(int clubId);


	int insertClub(Club club);


	Club findClubById(int clubId);
	ClubProfile findClubProfileById(int clubId);
	List<ClubTag> findClubTagById(int clubId);



	int updateClub(ClubDetails club);
	


}
