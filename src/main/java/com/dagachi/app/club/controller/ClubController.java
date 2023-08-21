package com.dagachi.app.club.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.dagachi.app.Pagination;
import com.dagachi.app.club.dto.BoardAndImageDto;
import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubBoardCreateDto;
import com.dagachi.app.club.dto.ClubCreateDto;
import com.dagachi.app.club.dto.ClubMemberRole;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ClubUpdateDto;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubBoardAttachment;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.common.DagachiUtils;
import com.dagachi.app.member.entity.MemberDetails;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/club")
@Slf4j
@SessionAttributes({"inputText"})
public class ClubController {
	
	static final int LIMIT = 10;
	
	@Autowired
	private ClubService clubService;
	
	@GetMapping("/main.do")
	public void Detail() {
	}
	
	
	@GetMapping("/&{domain}/clubBoardList.do")
	public String boardList(
			@PathVariable("domain") String domain,
			Model model
	) {
		model.addAttribute("domain", domain);
		return "/club/clubBoardList";
	}
	
	@GetMapping("/&{domain}/clubBoardCreate.do")
	public String boardCreate(
			@PathVariable("domain") String domain,
			Model model
	) {
		
		model.addAttribute("domain", domain);
		return "/club/clubBoardCreate";
	}
	
	@PostMapping("/{domain}/boardCreate.do")
	public String boardCreate(
			@Valid ClubBoardCreateDto _board,
			BindingResult bindingResult,
			@RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles
	) throws IllegalStateException, IOException{
		List<ClubBoardAttachment> attachments = new ArrayList<>();
		for(MultipartFile upFile : upFiles) {
			if(!upFile.isEmpty()) {
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = DagachiUtils.getRenameFilename(originalFilename);
				File destFile = new File(renamedFilename);
				upFile.transferTo(destFile);
				
				ClubBoardAttachment attach=
						ClubBoardAttachment.builder()
						.originalFilename(originalFilename)
						.renamedFilename(renamedFilename)
						.build();
				log.debug("attach = {}",attach);
				log.debug("_board = {}",_board);
				attachments.add(attach);
				
			}
		}
		
		
		//지금 문제잇음
		return "/club/clubBoardList";
	}
	
	
	/**
	 * 메인화면에서 모임 검색
	 * @author 종환
	 */
	@GetMapping("/clubSearch.do")
	public void clubSearch(
			@RequestParam(defaultValue = "1") int page,
			@RequestParam String inputText,
			HttpServletRequest request,
			Model model) {
		String getCount = "getCount";
		
		Map<String, Object> params = new HashMap<>();
        params.put("page", page);
        params.put("limit", LIMIT);
        params.put("inputText", inputText);
		
		List<ClubSearchDto> clubs = clubService.clubSearch(params);
		model.addAttribute("clubs", clubs);
		
		params.put("getCount", getCount);
		int totalCount = clubService.clubSearch(params).size();
		String url = request.getRequestURI();
		url += "#&inputText=" + inputText;
		String pageBar = Pagination.getPagebar(page, LIMIT, totalCount, url);
		pageBar = pageBar.replaceAll("\\?", "&");
		pageBar = pageBar.replaceAll("#&", "\\?");
		model.addAttribute("pagebar", pageBar);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("inputText", inputText);
	}
	
	/**
	 * 메인에서 모임 검색 후 필터 추가 검색
	 * @author 종환
	 */
	@GetMapping("/searchClubWithFilter.do")
	public String searchClubWithFilter(
			@RequestParam(defaultValue = "1") int page,
			@RequestParam String category,
			@RequestParam String area,
			HttpServletRequest request,
			HttpSession session,
			Model model) {
		String getCount = "getCount";
		String inputText = (String) session.getAttribute("inputText");
		Map<String, Object> params = new HashMap<>();
		params.put("area", area);
        params.put("page", page);
        params.put("limit", LIMIT);
        params.put("category", category);
        params.put("inputText", inputText);
        
        List<ClubSearchDto> clubs = clubService.searchClubWithFilter(params);
		model.addAttribute("clubs", clubs);
		
		params.put("getCount", getCount);
		int totalCount = clubService.searchClubWithFilter(params).size();
		log.debug("totalCount, clubs = {}{}", totalCount, clubs);
		String url = request.getRequestURI();
		url += "#&inputText=" + inputText + "&area=" + area + "&category=" + category;
		String pageBar = Pagination.getPagebar(page, LIMIT, totalCount, url);
		pageBar = pageBar.replaceAll("\\?", "&");
		pageBar = pageBar.replaceAll("#&", "\\?");
		model.addAttribute("pagebar", pageBar);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("inputText", inputText);
        
		return "/club/clubSearch";
	}
	
	
	
	@GetMapping("/chatList.do")
	public void chatList() {
		
	}
	
	@GetMapping("/chatRoom.do")
	public void chatRoom() {
		
	}
	
	/**
	 * 인덱스 페이지에서 클럽 상세보기 할 때 매핑입니다.
	 * 도메인도 domain 변수 안에 넣어놨습니다. (창환)
	 * - layout 가져오도록 수정(동찬)
	 */
	@GetMapping("/&{domain}")
	public String clubDetail(
			@PathVariable("domain") String domain,
			Model model) {
//		log.debug("domain = {}", domain);

		int clubId = clubService.findByDomain(domain).getClubId();
		ClubLayout layout = clubService.findLayoutById(clubId);
		List<BoardAndImageDto> boardAndImages = clubService.findBoardAndImageById(clubId);
		log.debug("boardAndImages = {}", boardAndImages);
		
		model.addAttribute("domain", domain);
		model.addAttribute("boardAndImages", boardAndImages);
		model.addAttribute("layout", layout);
		return "club/clubDetail";
	}
	
	
	/**
	 * 메인에서 소모임 전체 조회(카드로 출력)
	 * @author 준한
	 */
	@GetMapping("/clubList.do")
	public ResponseEntity<?> clubList(
			){
		List<ClubAndImage> clubAndImages = new ArrayList<>();
		clubAndImages = clubService.clubList();
		for(ClubAndImage cAI: clubAndImages) {
			int clubId = clubService.clubIdFindByDomain(cAI.getDomain());
			List<String> clubTag = (List)clubService.findClubTagById(clubId);
		}
		return ResponseEntity.status(HttpStatus.OK).body(clubAndImages);
	}
	


	/**
	 * 해당 모임의 회원관리 클릭시
	 * @author 창환
	 */
	@GetMapping("/&{domain}/manageMember.do")
	public String manageMemeber(
			@PathVariable("domain") String domain,
			@AuthenticationPrincipal MemberDetails member,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain); // 해당 클럽의 아이디(pk) 가져오기
		List<ManageMember> clubApplies = clubService.clubApplyByFindByClubId(clubId); // clubId로 club_apply, member 테이블 조인
//		log.debug("clubId = {}", clubId);
//		log.debug("clubApplies = {}", clubApplies);
		
		List<ClubMember> clubMembers = clubService.clubMemberByFindAllByClubId(clubId); // clubId로 club_member 조회(방장 제외)
//		log.debug("clubMembers = {}", clubMembers);
		
		List<JoinClubMember> joinClubMembersInfo = clubService.clubMemberInfoByFindByMemberId(clubMembers);	// 해당 모임에 가입된 회원 정보(이름, 닉네임, 가입일)
		log.debug("joinClubMembersInfo = {}", joinClubMembersInfo);
		
		JoinClubMember host = clubService.hostFindByClubId(clubId);
		log.debug("host = {}", host);
		
		
		String loginMemberId = member.getMemberId(); // 로그인 한 회원 아이디
		ClubMemberRole clubMemberRole = ClubMemberRole.builder()
				.clubId(clubId)
				.loginMemberId(loginMemberId)
				.build();
		// 로그인한 회원 아이디로 해당 모임의 권한 가져오기
		int memberRole = clubService.memberRoleFindByMemberId(clubMemberRole);
		
//		log.debug("memberRole = {}", memberRole);
		
		model.addAttribute("clubApplies", clubApplies);
		model.addAttribute("joinClubMembersInfo", joinClubMembersInfo);
		model.addAttribute("host", host); // 해당 모임의 방장 정보(아이디, 이름, 닉네임, 가입일, 권한)
		model.addAttribute("loginMemberId", loginMemberId);
		model.addAttribute("memberRole", memberRole); // 해당 모임에서 로그인한 회원의 권한
		
		return "/club/manageMember";
	}


	@GetMapping("/{domain}/findBoardType.do")
	public ResponseEntity<?> boardList(
			@RequestParam(required = false, defaultValue = "0" )int boardType,
			@PathVariable("domain") String domain
	){
	

		Club club= clubService.findByDomain(domain);
		int clubId=club.getClubId();
		
		
		int _type = (boardType != 0) ? boardType : 0;
		
		ClubBoard clubBoard=ClubBoard.builder()
				.clubId(clubId)
				.type(_type)
				.build();
		
		List<ClubBoard> boards= clubService.boardList(clubBoard);
		
		
		return ResponseEntity.status(HttpStatus.OK).body(boards);
	}
	
	@GetMapping("/{domain}/boardDetail.do")
	public String cluboardDetail(
			@PathVariable("domain") String domain,
			@RequestParam int no,
			Model model
	) {
		ClubBoard clubBoard= clubBoardGet(domain, no);
		
		model.addAttribute("clubBoard",clubBoard);
		
		return "/club/clubBoardDetail";
	}
	
	@PostMapping("/{domain}/likeCheck.do")
	public ResponseEntity<?> likeCheck(
			@RequestParam int boardId,
			@RequestParam boolean like,
			@PathVariable("domain") String domain
	){
		
		ClubBoard board= clubService.findByBoardId(boardId);
		log.debug("board ={}", board);
		log.debug("boardId ={}", boardId);
		int likeCount= board.getLikeCount();
		int result;
		if(like) {
			likeCount=likeCount+1;
			board.setLikeCount(likeCount);
			result = clubService.updateBoard(board);
		}
		else {
			likeCount=likeCount-1;
			board.setLikeCount(likeCount);
			result= clubService.updateBoard(board);
		}
		
		
		return ResponseEntity.status(HttpStatus.OK).body(board);
	}
	
	@GetMapping("/{domain}/boardUpdate.do")
	public String boardUpdate(
			@PathVariable("domain") String domain,
			@RequestParam int no,
			Model model
	) {
		ClubBoard clubBoard= clubBoardGet(domain, no);
		
		model.addAttribute("clubBoard",clubBoard);
		model.addAttribute("domain",domain);
		
		return "/club/clubBoardUpdate";
	}


	
	/**
	 * 해당 모임의 방장, 부방장은 모임에 가입되어있는 회원의 권한을 변경 가능
	 * @author 창환
	 */
	@PostMapping("/&{domain}/clubMemberRole.do")
	public String clubMemberRoleUpdate(
			@PathVariable("domain") String domain,
			@RequestParam String memberId,
			@RequestParam int clubMemberRole) {
		
		log.debug("memberId = {}", memberId);
		log.debug("clubMemberRole = {}", clubMemberRole);
		
		ClubMemberRoleUpdate member = ClubMemberRoleUpdate.builder()
				.memberId(memberId)
				.clubMemberRole(clubMemberRole)
				.build();
		
		log.debug("member = {}", member);
		int result = clubService.clubMemberRoleUpdate(member);
		log.debug("result = {}", result);
		
		return "redirect:/club/&" + domain + "/manageMember.do";
	}
	

	@GetMapping("/clubCreate.do")
	public void clubCreate() throws Exception {
		
	}
	
	/**
	 * 클럽 비활성화 버튼( 클럽테이블의 status값을 Y -> N으로 변경)
	 * @author 준한
	 */
	@GetMapping("/&{domain}/clubDisabled.do")
	public String clubDisabled(
			@PathVariable("domain") String domain
			) {
		int clubId = clubService.clubIdFindByDomain(domain); // 해당 클럽의 아이디(pk) 가져오기
		int result = clubService.clubDisabled(clubId);
		return "redirect:/";
	}
	
	@GetMapping("/findAddress.do")
	public ResponseEntity<?> findAddress(String keyword) throws UnsupportedEncodingException {
		
		if (keyword == null || keyword == "") return null;
		String SearchType = "address";
		
		JsonArray documents = DagachiUtils.kakaoMapApi(keyword, SearchType);

        Gson gson = new Gson();

        List<String> addressList = new ArrayList<>();
        for (JsonElement document : documents) {
            JsonObject item = document.getAsJsonObject();
            String addressName = item.get("address_name").getAsString();
            addressList.add(addressName);
        }
        return ResponseEntity.status(HttpStatus.OK).body(addressList);
	}

	@PostMapping("/clubCreate.do")
	public String clubCreate(@Valid ClubCreateDto _club, 
			BindingResult bindingResult,
			@AuthenticationPrincipal MemberDetails member,
			@RequestParam(value = "upFile") MultipartFile upFile) throws IllegalStateException, IOException {
		
		// 1. 파일저장
		String uploadDir = "/club/profile/";
		ClubProfile clubProfile = null;
		if(!upFile.isEmpty()) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename); // 20230807_142828888_123.jpg
			File destFile = new File(uploadDir + renamedFilename); // 부모디렉토리 생략가능. spring.servlet.multipart.location 값을 사용
			upFile.transferTo(destFile); // 실제파일 저장
			
			clubProfile = ClubProfile.builder()
					.originalFilename(originalFilename)
					.renamedFilename(renamedFilename)
					.build();
		}
		
		List<String> tagList = new ArrayList<>();
		for (String tag : _club.getTags().split(",")) {
			tagList.add(tag);
		}
		
		// 2. db저장
		ClubDetails club = ClubDetails.builder()
				.clubName(_club.getClubName())
				.activityArea(_club.getActivityArea())
				.category(_club.getCategory())
				.tagList(tagList)
				.domain(_club.getDomain())
				.introduce(_club.getIntroduce())
				.enrollQuestion(_club.getEnrollQuestion())
				.clubProfile(clubProfile)
				.build();
		
		System.out.println(club);
				
		int result = clubService.insertClub(club);
		
		
		return "redirect:/club/clubCreate.do";
	}
	
	@GetMapping("/&{domain}/clubUpdate.do")
	public String clubUpdate(
			@PathVariable("domain") String domain,
			Model model
			) {
		int clubId = clubService.clubIdFindByDomain(domain);
		Club club = clubService.findClubById(clubId);
		ClubProfile clubProfile = clubService.findClubProfileById(clubId);
		List<ClubTag> clubTagList = clubService.findClubTagById(clubId);
		
		log.debug("club = {}", club);
		log.debug("clubProfile={}",clubProfile);
		log.debug("clubTag = {}", clubTagList);
		
		model.addAttribute("club",club);
		model.addAttribute("clubProfile",clubProfile);
		model.addAttribute("clubTagList",clubTagList);
		
		return "club/clubUpdate";
	}
	
	@PostMapping("/&{domain}/clubUpdate.do")
	public String clubUpdate(
			@PathVariable("domain") String domain,
			@Valid ClubUpdateDto _club, 
			BindingResult bindingResult,
			@AuthenticationPrincipal MemberDetails member,
			@RequestParam(value = "upFile") MultipartFile upFile) throws IllegalStateException, IOException {
		int clubId = clubService.clubIdFindByDomain(domain);
		// 1. 파일저장
		
		String uploadDir = "/clubProfile/";
		ClubProfile clubProfile = null;
		if(!upFile.isEmpty()) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename); // 20230807_142828888_123.jpg
			File destFile = new File(uploadDir + renamedFilename); // 부모디렉토리 생략가능. spring.servlet.multipart.location 값을 사용
			upFile.transferTo(destFile); // 실제파일 저장
			
			clubProfile = ClubProfile.builder()
					.originalFilename(originalFilename)
					.renamedFilename(renamedFilename)
					.build();
		}
		
		List<String> tagList = new ArrayList<>();
		for (String tag : _club.getTags().split(",")) {
			tagList.add(tag);
		}
		
		// 2. db저장
		ClubDetails club = ClubDetails.builder()
				.clubName(_club.getClubName())
				.activityArea(_club.getActivityArea())
				.category(_club.getCategory())
				.tagList(tagList)
				.domain(_club.getDomain())
				.introduce(_club.getIntroduce())
				.enrollQuestion(_club.getEnrollQuestion())
				.clubProfile(clubProfile)
				.build();
		club.setClubId(clubId);
		
		System.out.println(club);
		int result = clubService.updateClub(club);
		
		
		return "redirect:/";
	}
	
	public ClubBoard clubBoardGet(String domain, int no) {
		
		Club club= clubService.findByDomain(domain);
		int clubId=club.getClubId();
		int boardId = no;
		ClubBoard _clubBoard=ClubBoard.builder()
				.clubId(clubId)
				.boardId(boardId)
				.build();

		ClubBoard clubBoard=clubService.findByBoard(_clubBoard);
		
		return clubBoard;
	}
	
}
