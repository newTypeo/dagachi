package com.dagachi.app.club.service;

import java.util.List;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.member.entity.Member;

public interface ClubService {

	List<Club> adminClubSearch(String keyword, String column);

	List<Club> adminClubList();

	List<ClubAndImage> clubList();

	List<Member> adminMemberList();

	List<Club> clubSearch(String inputText);
	
	List<ClubBoard> boardList(int boardType);

}
