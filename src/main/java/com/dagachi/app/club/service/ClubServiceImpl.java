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
import com.dagachi.app.club.dto.ClubManageApplyDto;
import com.dagachi.app.club.dto.ClubEnrollDto;
import com.dagachi.app.club.dto.ClubMemberRole;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.ClubScheduleAndMemberDto;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.GalleryAndImageDto;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.KickMember;
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
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.club.repository.ClubRepository;
import com.dagachi.app.member.entity.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class ClubServiceImpl implements ClubService {

	@Autowired
	private ClubRepository clubRepository;

	@Override
	public List<Club> adminClubList(Map<String, Object> params) {
		if ((String) params.get("getCount") != null) {
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
	public int ClubEnroll(ClubEnrollDto enroll) {
	    return clubRepository.ClubEnroll(enroll);
	}

	@Override
	public List<ClubSearchDto> clubSearch(Map<String, Object> params) {
		if ((String) params.get("getCount") != null) {
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
	public List<ClubSearchDto> searchClubWithFilter(Map<String, Object> params) {
		if ((String) params.get("getCount") != null) {
			return clubRepository.searchClubWithFilter(params);
		}

		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<ClubSearchDto> clubs = clubRepository.searchClubWithFilter(rowBounds, params);

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
		int result=0;
			result=clubRepository.updateBoard(_board);
			
			List<ClubBoardAttachment> attachments = ((ClubBoardDetails) _board).getAttachments();
			if (attachments != null && !attachments.isEmpty()) {
				for (ClubBoardAttachment attach : attachments) {
					attach.setBoardId(_board.getBoardId());
					result = clubRepository.insetAttachment(attach);
				}
			}

			
		return result;
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
	public List<JoinClubMember> clubMemberInfoByFindByMemberId(List<ClubMember> clubMembers, int clubId) {
		List<JoinClubMember> joinClubMembers = new ArrayList<>();

		for(ClubMember clubMember : clubMembers) {
			Map<String, Object> params = Map.of("clubId", clubId, "memberId", clubMember.getMemberId());
			joinClubMembers.add(clubRepository.clubMemberInfoByFindByMemberId(params));
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
		if (clubProfile != null) {
			clubProfile.setClubId(club.getClubId());
			result = clubRepository.insertClubProfile(clubProfile);
		}
		// clubTag 저장
		for (String tag : ((ClubDetails) club).getTagList()) {
			ClubTag clubTag = new ClubTag(club.getClubId(), tag);
			result = clubRepository.insertClubTag(clubTag);
		}
		// layout 생성
		result = clubRepository.insertLayout(club.getClubId());
		return result;
	}

	@Override
	public List<ClubBoardAttachment> findAttachments(int no) {
		return clubRepository.findAttachments(no);
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
		if (clubProfile != null) {
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
	public int postBoard(ClubBoard clubBoard) {
		int result = 0;

		result = clubRepository.postBoard(clubBoard);

		List<ClubBoardAttachment> attachments = ((ClubBoardDetails) clubBoard).getAttachments();
		if (attachments != null && !attachments.isEmpty()) {
			for (ClubBoardAttachment attach : attachments) {
				attach.setBoardId(clubBoard.getBoardId());
				result = clubRepository.insetAttachment(attach);
			}
		}
		return result;
	}

	@Override
	public ClubBoardAttachment findAttachment(int attachNo) {
		return clubRepository.findAttachment(attachNo);
	}

	@Override
	public List<ClubAndImage> clubListById(String memberId) {
		return clubRepository.clubListById(memberId);
	}

	@Override
	public List<BoardAndImageDto> findBoardAndImageById(int clubId) {
		return clubRepository.findBoardAndImageById(clubId);
	}

	@Override
	public JoinClubMember hostFindByClubId(int clubId) {
		return clubRepository.hostFindByClubId(clubId);
	}

	@Override
	public int memberRoleFindByMemberId(ClubMemberRole clubMemberRole) {
		int result = 0;
		try {
			result = clubRepository.memberRoleFindByMemberId(clubMemberRole);
		} catch (Exception e) {
			System.out.println("헉");
			result = 10;
			System.out.println(result);
		}
		return result;
	}

	@Override
	public int kickMember(KickMember kickMember) {
		return clubRepository.kickMember(kickMember);
	}

	@Override

	public int insertClubRecentVisitd(String memberId, int clubId) {
		return clubRepository.insertClubRecentVisitd(memberId, clubId);
	}

	public List<GalleryAndImageDto> findgalleryById(int clubId) {
		return clubRepository.findgalleryById(clubId);

	}

	@Override
	public List<Member> findMemberByClubId(int clubId) {
		return clubRepository.findMemberByClubId(clubId);
	}

	@Override
	public int delAttachment(int id) {
		return clubRepository.delAttachment(id);
	}

	@Override
	public List<ClubAndImage> categoryList(String category) {
		return clubRepository.categoryList(category);
	}
	
	@Override
	public int permitApply(ClubManageApplyDto clubManageApplyDto) {
		return clubRepository.permitApply(clubManageApplyDto);
	}
	@Override
	public int refuseApply(ClubManageApplyDto clubManageApplyDto) {
		return clubRepository.refuseApply(clubManageApplyDto);
	}
	
	
	@Override
	public List<ClubScheduleAndMemberDto> findScheduleById(int clubId) {
		return clubRepository.findScheduleById(clubId);
	}

	@Override
	public int updateThumbnail(ClubBoardAttachment clubBoardAttachment) {
		return clubRepository.updateThumbnail(clubBoardAttachment);
	}
	
	@Override
	public int delClubBoard(int boardId) {
		int result=0;
		
		List<ClubBoardAttachment> attachments = clubRepository.findAttachments(boardId);
		if(!attachments.isEmpty()) {
			for(ClubBoardAttachment attachment : attachments) {
				int id=attachment.getId();
				result=clubRepository.delAttachment(id);
			}
		}
		result=clubRepository.delClubBoard(boardId);
		
		return result;
	}

}
