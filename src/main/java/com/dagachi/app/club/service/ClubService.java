package com.dagachi.app.club.service;

import java.util.List;
import java.util.Map;

import com.dagachi.app.club.dto.BoardAndImageDto;
import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubMemberRole;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.KickMember;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.GalleryAndImageDto;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubBoardAttachment;
import com.dagachi.app.club.entity.ClubBoardDetails;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubGalleryAttachment;
import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.member.entity.Member;

public interface ClubService {

	List<Club> adminClubList(Map<String, Object> params);

	List<ClubAndImage> clubList();
	
	List<Member> adminMemberList();
	
	List<ClubSearchDto> clubSearch(Map<String, Object> params);
	
	int clubIdFindByDomain(String domain);

	List<ClubApply> clubApplyfindByClubId(int clubId);

	List<ClubBoard> boardList(ClubBoard clubBoard);

	Club findByDomain(String domain);

	ClubBoard findByBoard(ClubBoard _clubBoard);

	ClubBoard findByBoardId(int boardId);

	int updateBoard(ClubBoard _board);

	List<ClubBoard> boardList(int boardType);
	
	List<ManageMember> clubApplyByFindByClubId(int clubId);
	
	int clubDisabled(int clubId);

	List<ClubMember> clubMemberByFindAllByClubId(int clubId);

	List<JoinClubMember> clubMemberInfoByFindByMemberId(List<ClubMember> clubMembers);
	
	int insertClub(Club club);

	Club findClubById(int clubId);
	ClubProfile findClubProfileById(int clubId);
	List<ClubTag> findClubTagById(int clubId);

	int updateClub(ClubDetails club);
	
	int clubMemberRoleUpdate(ClubMemberRoleUpdate member);

	ClubLayout findLayoutById(int clubId);

	int postBoard(ClubBoard clubBoard);

	List<ClubBoardAttachment> findAttachments(int no);

	ClubBoardAttachment findAttachment(int attachNo);
	
	List<ClubAndImage> clubListById(String memberId);
	
	List<ClubSearchDto> searchClubWithFilter(Map<String, Object> params);

	List<BoardAndImageDto> findBoardAndImageById(int clubId);

	JoinClubMember hostFindByClubId(int clubId);

	int memberRoleFindByMemberId(ClubMemberRole clubMemberRole);

	List<GalleryAndImageDto> findgalleryById(int clubId);
	
	int kickMember(KickMember kickMember);

	int delAttachment(int id);
	
	List<Member> findMemberByClubId(int clubId);
	
	int insertClubRecentVisitd(String memberId, int clubId);


}
