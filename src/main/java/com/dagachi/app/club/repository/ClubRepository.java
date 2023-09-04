package com.dagachi.app.club.repository;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.club.dto.BoardAndImageDto;
import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubManageApplyDto;
import com.dagachi.app.club.dto.ClubEnrollDto;
import com.dagachi.app.club.dto.ClubGalleryAndImage;
import com.dagachi.app.club.dto.ClubMemberRole;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.ClubNameAndCountDto;
import com.dagachi.app.club.dto.ClubReportDto;
import com.dagachi.app.club.dto.ClubScheduleAndMemberDto;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.KickMember;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ClubStyleUpdateDto;
import com.dagachi.app.club.dto.CreateGalleryDto;
import com.dagachi.app.club.dto.GalleryAndImageDto;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.BoardComment;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubBoardAttachment;
import com.dagachi.app.club.entity.ClubBoardDetails;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubGalleryAttachment;
import com.dagachi.app.club.entity.ClubGalleryDetails;
import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubRecentVisited;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.member.entity.CbcLike;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberProfile;


@Mapper
public interface ClubRepository {

   
   List<Club> adminClubList(RowBounds rowBounds, Map<String, Object> params); 
   List<Club> adminClubList(Map<String, Object> params);
   
   @Select("(SELECT c.*, p.*, cm.member_count FROM club c JOIN club_profile p ON c.club_id = p.club_id LEFT JOIN (SELECT club_id, COUNT(member_id) AS member_count FROM club_member GROUP BY club_id) cm ON c.club_id = cm.club_id where rownum <=25) order by 5 desc")
   List<ClubAndImage> clubList();
    
   
   @Select("select * from member")
   List<Member> adminMemberList();

   
   List<ClubSearchDto> clubSearch(RowBounds rowBounds, Map<String, Object> params);
   List<ClubSearchDto> clubSearch(Map<String, Object> params);
   
   @Select("select club_id from club where domain = #{domain}")
   int clubIdFindByDomain(String domain);
   
   @Select("select count(*) from club_member where club_id = #{clubId}")
   int countClubMember(int clubId);
   
   
   @Update("update club set status = 'N' where club_id = #{clubId}")
   int clubDisabled(int clubId);

   
   @Select("select * from club_member where club_id = #{clubId} and club_member_role != 3")
   List<ClubMember> clubMemberByFindAllByClubId(int clubId);

   
   JoinClubMember clubMemberInfoByFindByMemberId(Map<String, Object> params);
   
	
	List<ClubBoard> boardList(ClubBoard clubBoard,RowBounds rowBounds);

	@Select("select * from club where domain= #{domain}")
	Club findByDomain(String domain);

	@Select("select * from club_board where club_id= #{clubId} and board_id =#{boardId}")
	ClubBoard findByBoard(ClubBoard _clubBoard);

	@Select("select * from club_board where board_id= #{boardId}")
	ClubBoard findByBoardId(int boardId);

	@Update("update club_board set title=#{title}, content=#{content}, type=#{type} , status=#{status}, like_count=#{likeCount} where board_id=#{boardId}")
	int updateBoard(ClubBoard _board);




	@Update("update club_member set club_member_role = #{clubMemberRole} where member_id = #{memberId}")
	int clubMemberRoleUpdate(ClubMemberRoleUpdate member);





	
	List<ManageMember> clubApplyByFindByClubId(int clubId);

	
	@Insert("insert into club values (seq_club_id.nextVal, #{clubName}, #{activityArea}, #{category}, default, sysdate, default, 0, #{introduce}, #{enrollQuestion}, #{domain})")
	@SelectKey(
			before = false, 
			keyProperty = "clubId", 
			resultType = int.class,
			statement = "select seq_club_id.currval from dual")
	int insertClub(Club club);

	@Insert("insert into club_profile values (#{clubId}, #{originalFilename}, #{renamedFilename}, default)")
	int insertClubProfile(ClubProfile clubProfile);

	@Insert("insert into club_tag values (#{clubId}, #{tag})")
	int insertClubTag(ClubTag clubTag);

	@Select("select * from club where club_Id = #{clubId}")
	Club findClubById(int clubId);

	@Select("select * from club_profile where club_Id = #{clubId}")
	ClubProfile findClubProfileById(int clubId);

	@Select("select * from club_tag where club_Id = #{clubId}")
	List<ClubTag> findClubTagById(int clubId);

	@Update("update club set club_name = #{clubName}, activity_area=#{activityArea}, category=#{category}, introduce=#{introduce}, enroll_question = #{enrollQuestion} where club_id = #{clubId}")
	int updateClub(ClubDetails club);
	
	@Delete("delete club_tag where club_id=#{clubId}")
	int deleteClubTag(ClubDetails club);

	@Update("update club_profile set original_filename = #{originalFilename}, renamed_filename=#{renamedFilename} where club_id=#{clubId}")
	int updateClubProfile(ClubProfile clubProfile);
	
	@Select("select * from club_layout where club_Id = #{clubId}")
	ClubLayout findLayoutById(int clubId);
	
	@Insert("insert into club_board (board_id, club_id, writer, title, content, type) " +
	        "values (seq_club_board_id.nextval, #{clubId}, #{writer}, #{title}, #{content}, #{type})")
	@SelectKey(
			before = false, 
			keyProperty = "boardId", 
			resultType = int.class,
			statement = "select seq_club_board_id.currval from dual")
	int postBoard(ClubBoard clubBoard);
	
	@Insert("insert into club_board_attachment (id, board_id, original_filename, renamed_filename,created_at, thumbnail) " +
	        "values (seq_club_board_attachment_id.nextval, #{boardId}, #{originalFilename}, #{renamedFilename}, default , #{thumbnail})")
	int insetAttachment(ClubBoardAttachment attach);
	
	@Select("select * from club_board_attachment where board_id = #{no}")
	List<ClubBoardAttachment> findAttachments(int no);
	
	@Select("select * from club_board_attachment where id = #{attachNo}")
	ClubBoardAttachment findAttachment(int attachNo);
	

	@Select("(select * from (SELECT a.*, b.count AS member_count FROM (SELECT c.*, i.member_id FROM club c JOIN member_interest i ON c.category = i.interest WHERE i.member_id = #{memberId}) a LEFT JOIN (SELECT club_id, COUNT(*) AS count FROM club_member GROUP BY club_id) b ON a.club_id = b.club_id) c left join (select * from club_profile) d on c.club_id = d.club_id where rownum <=10)order by 5 desc")
	List<ClubAndImage> clubListById(String memberId);
	
	List<ClubSearchDto> searchClubWithFilter(Map<String, Object> params);
	List<ClubSearchDto> searchClubWithFilter(RowBounds rowBounds, Map<String, Object> params);

	@Select("select * from (select * from club_board cb left join club_board_attachment ca on cb.board_id = ca.board_id where (ca.thumbnail = 'Y' or ca.thumbnail is null) and club_id = #{clubId} order by cb.board_id desc) where rownum <= 100")
	List<BoardAndImageDto> findBoardAndImageById(int clubId);

	JoinClubMember hostFindByClubId(int clubId);
	
	@Select("select club_member_role from club_member where club_id = #{clubId} and member_id = #{loginMemberId}")
	int memberRoleFindByMemberId(ClubMemberRole clubMemberRole);
	
	@Select("select * from (select * from club_gallery cg left join club_gallery_attachment ca on cg.gallery_id = ca.gallery_id where (ca.thumbnail = 'Y' or ca.thumbnail is null) and club_id = #{clubId} order by cg.gallery_id desc) where rownum <= 8")
	List<GalleryAndImageDto> findgalleryById(int clubId);

	@Delete("delete from club_member where club_id = #{clubId} and member_id = #{memberId}")
	int kickMember(KickMember kickMember);
	
	@Delete("delete from club_board_attachment where id=#{id}")
	int delAttachment(int id);
	
	@Insert("insert into recent_visit_list values(#{memberId}, #{clubId}, default)")
	int insertClubRecentVisitd(String memberId, int clubId);

	
	@Select("select * from recent_visit_list")
	List<ClubRecentVisited> findAllrecentVisitClubs();
	
	@Select("select count(*) from recent_visit_list where club_id = #{clubId}")
	int checkDuplicateClubId(int clubId);

	
	@Update("update club_board_attachment set thumbnail=#{thumbnail} where id=#{id}")
	int updateThumbnail(ClubBoardAttachment clubBoardAttachment);
	
	List<ClubAndImage> categoryList(String category);


	@Insert("insert into club_member values(#{memberId}, #{clubId}, default, null, default, default)")
	int permitApply(ClubManageApplyDto clubManageApplyDto);
	
	@Delete("delete from club_apply where member_id = #{memberId} and club_id = #{clubId}")
	int refuseApply(ClubManageApplyDto clubManageApplyDto);
	
	
	List<ClubScheduleAndMemberDto> findScheduleById(int clubId);
	
	@Select("select * from recent_visit_list r join club c on r.club_id = c.club_id join club_profile w on c.club_id = w.club_id where member_id = #{loginMemberId}")
	List<ClubAndImage> recentVisitClubs(String loginMemberId);

	@Delete("delete from club_board where board_Id=#{boardId}")
	int delClubBoard(int boardId); 

	@Insert("insert into club_apply values(#{clubId},#{memberId},#{answer})")
	int ClubEnroll(ClubEnrollDto enroll);
	
	@Select("select count(*) from club_apply where club_id = #{clubId} and member_id= #{memberId}")
	int clubEnrollDuplicated(ClubApply clubApply);
	
	@Insert("insert into club_report (id, club_id, reason, reporter, created_at) values(seq_club_report_id.nextval, #{clubId}, #{reason}, #{reporter}, default)")
	int insertClubReport(@Valid ClubReportDto clubReportDto);
	
	@Update("update club set report_count = report_count + 1 where club_id = #{clubId}")
	int addReportCount(@Valid ClubReportDto clubReportDto);
	
	@Select("select * from club_member a left join club b on a.club_id= b.club_id left join club_profile c on a.club_id = c.club_id where a.member_id = #{memberId}")
	List<ClubAndImage> searchJoinClub(String memberId);
	
	@Select("select * from club_member where club_id = #{clubId}")
	List<Member> findMemberByClubId(int clubId);
	
	@Select("select * from member_profile where member_id = #{id}")
	List<MemberProfile> findProfileById(String id);
	
	@Select("select * from member where member_id = #{id}")
	Member findMemberById(String id);
	
	@Update("update club_layout set type=#{type}, font=#{font}, background_color=#{backgroundColor}, font_color=#{fontColor}, point_color=#{pointColor} where club_id=#{clubId}")
	int clubStyleUpdate(ClubStyleUpdateDto style);
	
	List<ClubBoard> searchBoard(Map<String, Object> searchBoardMap);
	
	@Update("update club_layout set title = #{title} where club_id = #{clubId}")
	int updateClubTitleImage(ClubLayout clubLayout);
	
	@Update("update club_layout set main_image = #{mainImage} where club_id = #{clubId}")
	int updateClubMainImage(ClubLayout clubLayout);
	
	@Update("update club_layout set main_content = #{mainContent} where club_id = #{clubId}")
	int updateClubMainContent(ClubLayout clubLayout);
	
	@Select("select count(*) from cbc_like where target_id = #{targetId} and type = 2")
	int checkDuplicateClubLike(int targetId);
	
	@Insert("insert into cbc_like values(#{memberId}, 1, #{targetId}, default)")
	int clubLike(Map<String, Object> params);
	
	@Delete("delete from CBC_like where member_id = #{memberId} and type = 1 and target_id = #{targetId}")
	int cancelClubLike(Map<String, Object> params);
	
	List<ClubSearchDto> findClubByDistance(Map<String, Object> params);

	int boardSize(ClubBoard clubBoard);
	
	List<ClubBoard> searchBoards(Map<String, Object> searchBoardMap, RowBounds rowBounds);
	
	@Select("select * from club join club_profile on club.club_id = club_profile.club_id left join cbc_like on club.club_id = cbc_like.target_id where member_id = #{loginMemberId}")
	List<ClubAndImage> findAllClubLike(String loginMemberId);
	
	@Select("select * from club_gallery a join club_gallery_attachment b on a.gallery_id = b.gallery_id where (club_id = #{clubId} and thumbnail = 'Y') order by 9")
	List<ClubGalleryAndImage> clubGalleryAndImageFindByClubId(int clubId);
	
	@Select("select * from club c join club_member cm on (c.club_id = cm.club_id) where cm.member_id = #{memberId} and c.status = 'Y'")
	List<Club> findClubsByMemberId(String memberId);
	
	@Select("select club_name, created_at, (select count(*) from club_member where club_id = #{clubId}) member_count from club where club_id = #{clubId}")
	ClubNameAndCountDto findClubInfoById(int clubId);
	
	@Insert("insert into CBC_like values(#{memberId}, 2, #{targetId}, default)")
	int insertClubLike(Map<String, Object> params);
	
	@Delete("delete from CBC_like where member_id = #{memberId} and type = 2 and target_id = #{targetId}")
	int deleteClubLike(Map<String, Object> params);
	
	@Select("select count(*) from CBC_like where member_id = #{memberId} and type = #{type} and target_id = #{targetId}")
	int checkBoardLiked(Map<String, Object> params);
	
	@Select("select * from club_gallery a join club_gallery_attachment b on a.gallery_id = b.gallery_id where a.gallery_id = #{galleryId}")
	List<GalleryAndImageDto> findGalleryAndImageByGalleryId(int id);
	
	@Delete("delete club_gallery_attachment where gallery_id = #{id}")
	int clubGalleryAttachDelete(int id);
	
	@Delete("delete club_gallery where gallery_id = #{id}")
	int clubGalleryDelete(int id);
	
	@Insert("insert into club_gallery (gallery_id,club_id,member_id,status) values(seq_club_gallery_id.nextval, #{clubId},#{memberId},'Y')")
	int clubGalleryCreate(CreateGalleryDto createGalleryDto);
	
	
	@Insert("insert into club_gallery_attachment (id,gallery_id,original_filename,renamed_filename, thumbnail) values (seq_club_gallery_attachment_id.nextval,seq_club_gallery_id.currval,#{originalFilename},#{renamedFilename},'Y')")
	int clubGalleryAttachCreate(CreateGalleryDto createGalleryDto);
	
	@Insert("insert into club_gallery_attachment (id,gallery_id,original_filename,renamed_filename, thumbnail) values (seq_club_gallery_attachment_id.nextval,seq_club_gallery_id.currval,#{originalFilename},#{renamedFilename},'N')")
	int clubGalleryCreate2(CreateGalleryDto createGalleryDto);
	
	@Insert("insert into board_comment (comment_id, board_id,writer,content,created_at,status) values (seq_board_comment_id.nextval,#{boardId},#{writer}, #{content},default,default)")
	@SelectKey(
			before = false, 
			keyProperty = "commentId", 
			resultType = int.class,
			statement = "select seq_board_comment_id.currval from dual")
	int boardCommentCreate(BoardComment comment);
	
	@Select("select * from board_comment where board_id=#{no} order by created_at desc")
	List<BoardComment> findComments(int no);
	
	@Select("select * from  board_comment where comment_id=#{commentId}")
	BoardComment findBoardComment(int commentId);
	
	@Delete("delete from club_member where member_id = #{memberId} and club_id = #{clubId} and club_member_role != 3")
	int clubMemberDelete(Map<String, Object> params);
	
	@Select("select * from club_member where member_id = #{memberId} and club_id = #{clubId}")
	ClubMember findClubMemberRoleByClubId(Map<String, Object> params);
	
	@Insert("insert into club_gallery (gallery_id, club_id, member_id) " +
	        "values (seq_club_gallery_id.nextval, #{clubId}, #{memberId})")
	@SelectKey(
			before = false, 
			keyProperty = "galleryId", 
			resultType = int.class,
			statement = "select seq_club_gallery_id.currval from dual")
	int postGallery(ClubGalleryDetails clubGallery);
	
	@Insert("insert into club_gallery_attachment (id, gallery_id, original_filename, renamed_filename,created_at, thumbnail) " +
	        "values (seq_club_gallery_attachment_id.nextval, #{galleryId}, #{originalFilename}, #{renamedFilename}, default , #{thumbnail})")
	int insertAttachment(ClubGalleryAttachment attach);
	
	@Insert("insert into club_member values(#{memberId}, #{clubId}, default, sysdate, 3, default)")
	int insertClubLeaderById(Map<String, Object> params);
	
	@Select("select count(*) from recent_visit_list where club_id = #{clubId} and member_id = #{memberId}")
	int checkDuplicateClubIdAndId(Map<String, Object> params);
	
	
}
   