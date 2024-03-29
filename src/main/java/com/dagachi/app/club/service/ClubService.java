package com.dagachi.app.club.service;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import com.dagachi.app.club.dto.BoardAndImageDto;
import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubDetailDto;
import com.dagachi.app.club.dto.ClubEnrollDto;
import com.dagachi.app.club.dto.ClubGalleryAndImage;
import com.dagachi.app.club.dto.ClubManageApplyDto;
import com.dagachi.app.club.dto.ClubMemberAndImage;
import com.dagachi.app.club.dto.ClubMemberRole;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.ClubNameAndCountDto;
import com.dagachi.app.club.dto.ClubReportDto;
import com.dagachi.app.club.dto.ClubScheduleAndMemberDto;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ClubStyleUpdateDto;
import com.dagachi.app.club.dto.CreateGalleryDto;
import com.dagachi.app.club.dto.GalleryAndImageDto;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.KickMember;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.BoardComment;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubBoardAttachment;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubGalleryDetails;
import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubRecentVisited;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.member.entity.Member;

public interface ClubService {

	List<Club> adminClubList(Map<String, Object> params);

	List<ClubAndImage> clubList();
	
	List<Member> adminMemberList();
	
	List<ClubSearchDto> clubSearch(Map<String, Object> params);
	
	int clubIdFindByDomain(String domain);

	List<ClubApply> clubApplyfindByClubId(int clubId);

	List<ClubBoard> boardList(ClubBoard clubBoard, Map<String, Object> params);

	Club findByDomain(String domain);

	ClubBoard findByBoard(ClubBoard _clubBoard);

	ClubBoard findByBoardId(int boardId);

	int updateBoard(ClubBoard _board);

	List<ManageMember> clubApplyByFindByClubId(int clubId);
	
	int clubDisabled(int clubId);

	List<ClubMember> clubMemberByFindAllByClubId(int clubId);

	List<JoinClubMember> clubMemberInfoByFindByMemberId(List<ClubMember> clubMembers, int clubId);
	
	int insertClub(Club club, String memberId);

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
	
	
	int insertClubRecentVisitd(String memberId, int clubId);

	int updateThumbnail(ClubBoardAttachment clubBoardAttachment);

	List<ClubAndImage> categoryList(String category);
	
	int permitApply(ClubManageApplyDto clubManageApplyDto);
	
	int refuseApply(ClubManageApplyDto clubManageApplyDto);
	
	List<ClubScheduleAndMemberDto> findScheduleById(int clubId);

	List<ClubAndImage> recentVisitClubs(String loginMemberId);

	int delClubBoard(int boardId);
	
	int ClubEnroll(ClubEnrollDto enroll);

	int clubEnrollDuplicated(ClubApply clubApply);

	int insertClubReport(@Valid ClubReportDto clubReportDto);
	
	List<ClubAndImage> searchJoinClub(String memberId);

	List<ClubMemberAndImage> findClubMembers(int clubId);

	int clubStyleUpdate(@Valid ClubStyleUpdateDto style);

	List<ClubBoard> searchBoard(Map<String, Object> searchBoardMap);

	int updateClubTitleImage(ClubLayout clubLayout);

	int updateClubMainImage(ClubLayout clubLayout);

	int updateClubMainContent(ClubLayout clubLayout);

	int boardSize(ClubBoard clubBoard);
	
	int checkDuplicateClubLike(int targetId);

	int clubLike(Map<String, Object> params);

	List<ClubSearchDto> findClubByDistance(Map<String, Object> params);
	
	List<ClubBoard> searchBoards(Map<String, Object> searchBoardMap, Map<String, Object> params);

	List<ClubAndImage> findAllClubLike(String loginMemberId);

	List<ClubGalleryAndImage> clubGalleryAndImageFindByClubId(int clubId);

	List<Club> findClubsByMemberId(String memberId);

	ClubNameAndCountDto findClubInfoById(int clubId);
	
	int likeBoard(Map<String, Object> params);

	int checkBoardLiked(Map<String, Object> params);
	
	List<GalleryAndImageDto> findGalleryAndImageByGalleryId(int id);

	int clubGalleryDelete(int id);

	int clubGalleryCreate(CreateGalleryDto createGalleryDto);

	int clubGalleryCreate2(CreateGalleryDto createGalleryDto);

	int cancelClubLike(Map<String, Object> params);

	int boardCommentCreate(BoardComment comment);

	List<BoardComment> findComments(int no);

	BoardComment findBoardComment(int commentId);

	int clubMemberDelete(Map<String, Object> params);

	ClubMember findClubMemberRoleByClubId(Map<String, Object> params);

	int postGallery(ClubGalleryDetails clubGallery);

	int checkDuplicateClubIdAndId(Map<String, Object> params);

	ClubDetailDto findClubDetailByDomainAndMemberId(Map<String, String> domainAndMemberId);

	List<BoardAndImageDto> findBoardAndImageByMap(Map<String, Object> params);

	
	

}
