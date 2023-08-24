package com.dagachi.app.club.controller;

import static com.dagachi.app.common.DagachiUtils.*;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StopWatch;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dagachi.app.Pagination;
import com.dagachi.app.club.common.Status;
import com.dagachi.app.club.dto.BoardAndImageDto;
import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubBoardCreateDto;
import com.dagachi.app.club.dto.ClubCreateDto;
import com.dagachi.app.club.dto.ClubManageApplyDto;
import com.dagachi.app.club.dto.ClubMemberAndImage;
import com.dagachi.app.club.dto.ClubEnrollDto;
import com.dagachi.app.club.dto.ClubMemberRole;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.ClubReportDto;
import com.dagachi.app.club.dto.ClubScheduleAndMemberDto;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ClubStyleUpdateDto;
import com.dagachi.app.club.dto.ClubUpdateDto;
import com.dagachi.app.club.dto.GalleryAndImageDto;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.KickMember;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.dto.SearchClubBoard;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubBoardAttachment;
import com.dagachi.app.club.entity.ClubBoardDetails;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubRecentVisited;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.common.DagachiUtils;
import com.dagachi.app.member.entity.ActivityArea;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberProfile;
import com.dagachi.app.member.service.MemberService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/club")
@SessionAttributes({ "inputText" })
public class ClubController {

	private final JavaMailSender javaMailSender;
	
	static final int LIMIT = 10;

	@Autowired
	private MemberService memberService;

	@Autowired
	private ClubService clubService;

	@Autowired
	public ClubController(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}


	@GetMapping("/main.do")
	public void Detail() {
	}

	@GetMapping("/{domain}/clubEnroll.do")
	public String ClubEnroll(@PathVariable("domain") String domain, RedirectAttributes redirectAttr, Model model,
			@AuthenticationPrincipal MemberDetails member) {
		int clubId = clubService.clubIdFindByDomain(domain);
		System.out.println(clubId);
		Club club = clubService.findClubById(clubId);
		model.addAttribute("club", club);

		ClubApply clubApply = new ClubApply(clubId, member.getMemberId(), null);

		int result = clubService.clubEnrollDuplicated(clubApply);

		if (result == 1) {
			redirectAttr.addFlashAttribute("msg", "이미 가입 신청한 모임 입니다.");
			return "redirect:/club/" + domain;
		}

		return "/club/clubEnroll";
	}

	@PostMapping("/{domain}/clubEnroll.do")
	public String ClubEnroll(@Valid ClubEnrollDto enroll, Model model, @PathVariable("domain") String domain,
			@AuthenticationPrincipal MemberDetails member, RedirectAttributes redirectAttr) {
		System.out.println(domain);
		enroll.setMemberId(member.getMemberId());
		int result = clubService.ClubEnroll(enroll);
		redirectAttr.addFlashAttribute("msg", "💡가입 신청 완료.💡");
		return "redirect:/club/" + domain;
	}

	@GetMapping("/{domain}/clubBoardList.do")
	public String boardList(@PathVariable("domain") String domain, Model model) {
		model.addAttribute("domain", domain);
		return "/club/clubBoardList";
	}

	@GetMapping("/{domain}/clubBoardCreate.do")
	public String boardCreate(@PathVariable("domain") String domain, Model model) {

		model.addAttribute("domain", domain);
		return "/club/clubBoardCreate";
	}

	@PostMapping("/{domain}/boardCreate.do")
	public String boardCreate(@Valid ClubBoardCreateDto _board, @PathVariable("domain") String domain,
			BindingResult bindingResult, @RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles)
			throws IllegalStateException, IOException {
		List<ClubBoardAttachment> attachments = new ArrayList<>();
		if (!upFiles.isEmpty())
			attachments = insertAttachment(upFiles, attachments);
		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();
		ClubBoardDetails clubBoard = ClubBoardDetails.builder().clubId(clubId).writer("honggd").attachments(attachments)
				.title(_board.getTitle()).content(_board.getContent()).type(_board.getType()).build();
		int result = clubService.postBoard(clubBoard);
		// 작성자 수정해야함
		return "/club/clubBoardList";
	}

	/**
	 * 메인화면에서 모임 검색
	 * 
	 * @author 종환
	 */
	@GetMapping("/clubSearch.do")
	public void clubSearch(@RequestParam(defaultValue = "1") int page, @RequestParam String inputText,
			HttpServletRequest request, Model model) {
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
	 * 
	 * @author 종환
	 */
	@GetMapping("/searchClubWithFilter.do")
	public String searchClubWithFilter(@RequestParam(defaultValue = "1") int page, @RequestParam String category,
			@RequestParam String area, HttpServletRequest request, HttpSession session, Model model) {

		String getCount = "getCount";
		String inputText = (String) session.getAttribute("inputText");
		Map<String, Object> params = new HashMap<>();
		params.put("area", area);
		params.put("page", page);
		params.put("limit", LIMIT);
		params.put("category", category);
		params.put("inputText", inputText);

		List<ClubSearchDto> clubs = clubService.searchClubWithFilter(params);

		params.put("getCount", getCount);
		int totalCount = clubService.searchClubWithFilter(params).size();
		log.debug("totalCount, clubs = {}{}", totalCount, clubs);
		String url = request.getRequestURI();
		url += "#&inputText=" + inputText + "&area=" + area + "&category=" + category;
		String pageBar = Pagination.getPagebar(page, LIMIT, totalCount, url);
		pageBar = pageBar.replaceAll("\\?", "&");
		pageBar = pageBar.replaceAll("#&", "\\?");

		model.addAttribute("area", area);
		model.addAttribute("category", category);
		model.addAttribute("clubs", clubs);
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
	 * 가입신청 승인 & 거절 - 승인시에는 dto.isPermit이 true로 온다.
	 * 
	 * @author 종환
	 */
	@PostMapping("/{domain}/manageApply.do")
	public String permitApply(@PathVariable("domain") String domain, ClubManageApplyDto clubManageApplyDto) {

		if (clubManageApplyDto.isPermit())
			clubService.permitApply(clubManageApplyDto); // 가입 승인
		else
			clubService.refuseApply(clubManageApplyDto); // 가입 거절

		return "redirect:/club/" + domain + "/manageMember.do";
	}

	@GetMapping("clubSearchSurrounded.do")

	public void clubSearchSurrounded(@AuthenticationPrincipal MemberDetails member, Model model) {
		ActivityArea activityArea = memberService.findActivityAreaById(member.getMemberId());
		String mainAreaId = activityArea.getMainAreaId();
		model.addAttribute("mainAreaId", mainAreaId);
	}
	
	/**
<<<<<<< HEAD
	 * 비동기로 주변모임 검색
	 * 
=======
	 * 활동지역 중심 주변모임 검색
>>>>>>> branch 'master' of https://github.com/newTypeo/dagachi
	 * @author 종환
	 */
	@GetMapping("clubSearchByDistance.do")
	public ResponseEntity<?> clubSearchByDistance(
			@RequestParam int distance, 
			@RequestParam String mainAreaName, // "서울특별시 **구 **동"
			@AuthenticationPrincipal MemberDetails member) throws UnsupportedEncodingException {
		// 거리 별로 360에 나눌 각도 Map 셋팅
		Map<Integer, Double> anglePattern = // km(key)별로 360도를 나눌 각도(value) 
				Map.of(1, 45.0, 2, 30.0, 3, 22.5, 4, 18.0, 5, 15.0, 6, 11.25, 7, 9.0, 8, 7.5, 9, 6.0, 10, 5.0);
		
		JsonArray documents = kakaoMapApi(mainAreaName, "address"); // api요청 결과를 json배열로 반환하는 method
		JsonElement document = documents.getAsJsonArray().get(0);
	    JsonObject item = document.getAsJsonObject();
		double x = item.get("x").getAsDouble();
		double y = item.get("y").getAsDouble();
		
		// 싸인 코사인으로 계산하는 메소드
		Set<String> zoneSet = getAreaNamesByDistance(x, y, distance, anglePattern); // 검색할 km기반으로 주변 동이름이 들어있는 set 반환
		
		
		// 주변의 모든 법정동리스트로 모임 조회 후 리턴
		// List<Club> clubs = clubService.findClubByDistance(zoneSet);
		
		
		
		// 중복된 모임을 어떻게 필터링할 수 있을까?
		
		
		return ResponseEntity.status(HttpStatus.OK).body("안녕~");
	}

	/**
	 * 인덱스 페이지에서 클럽 상세보기 할 때 매핑입니다. 도메인도 domain 변수 안에 넣어놨습니다. (창환) - layout 가져오도록
	 * 
	 * @author 동찬
	 */
	@GetMapping("/{domain}")
	public String clubDetail(@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member,
			Model model) {

		int clubId = clubService.clubIdFindByDomain(domain);

		ClubLayout layout = clubService.findLayoutById(clubId);

		List<BoardAndImageDto> boardAndImages = clubService.findBoardAndImageById(clubId);
		List<GalleryAndImageDto> galleries = clubService.findgalleryById(clubId);
		List<ClubScheduleAndMemberDto> schedules = clubService.findScheduleById(clubId);

		String memberId = member.getMemberId();
		// 최근 본 모임 전체 조회 (현우)
		List<ClubRecentVisited> recentVisitClubs = clubService.findAllrecentVisitClubs();

		int checkDuplicate = clubService.checkDuplicateClubId(clubId);

		log.debug("recentVisitClubs = {}", recentVisitClubs);

		// 최근 본 모임 클릭 시 중복검사 후 db에 삽입
		if (checkDuplicate == 0) {
			int result = clubService.insertClubRecentVisitd(memberId, clubId);
		}

		ClubMemberRole clubMemberRole = ClubMemberRole.builder().clubId(clubId).loginMemberId(memberId).build();

		// 로그인한 회원 아이디로 해당 모임의 권한 가져오기
		int memberRole = clubService.memberRoleFindByMemberId(clubMemberRole);
		model.addAttribute("memberId", memberId);
		model.addAttribute("memberRole", memberRole);

		model.addAttribute("domain", domain);
		model.addAttribute("galleries", galleries);
		model.addAttribute("boardAndImages", boardAndImages);
		model.addAttribute("schedules", schedules);
		model.addAttribute("layout", layout);

		return "club/clubDetail";
	}

	/**
	 * 메인에서 소모임 전체 조회(카드로 출력)
	 * 
	 * @author 준한
	 */
	@GetMapping("/clubList.do")
	public ResponseEntity<?> clubList() {
		List<ClubAndImage> clubAndImages = new ArrayList<>();
		clubAndImages = clubService.clubList();
//		for(ClubAndImage cAI: clubAndImages) {
//			int clubId = clubService.clubIdFindByDomain(cAI.getDomain());
//			List<String> clubTag = (List)clubService.findClubTagById(clubId);
//		}

//		System.out.println(clubTag);
		return ResponseEntity.status(HttpStatus.OK).body(clubAndImages);
	}

	/**
	 * 로그인 했을때 로그인객체의 관심사로 소모임 추천 출력(카드)
	 * 
	 * @author 준한
	 */
	@GetMapping("/loginClubList.do")
	public ResponseEntity<?> loginClubList(@AuthenticationPrincipal MemberDetails member) {
		String memberId = member.getMemberId();

		List<ClubAndImage> clubAndImages = new ArrayList<>();
		clubAndImages = clubService.clubListById(memberId);
		return ResponseEntity.status(HttpStatus.OK).body(clubAndImages);
	}


	/**
	 * 모임 신고
	 * @author 창환
	 */
	@PostMapping("/{domain}/clubReport.do")
	public ResponseEntity<?> clubReport(@PathVariable("domain") String domain, @Valid ClubReportDto clubReportDto) {

		int clubId = clubService.clubIdFindByDomain(domain);
		clubReportDto.setClubId(clubId);

		int result = clubService.insertClubReport(clubReportDto);
		System.out.println("result = " + result);

		return ResponseEntity.status(HttpStatus.OK).body(clubReportDto);
	}

	/**
	 * 사용자가 해당 카테고리를 hover한 값을 db에서 조회 후 반환
	 * 
	 * @author 창환
	 */
	@GetMapping("/categoryList.do")
	public ResponseEntity<?> categoryList(@RequestParam String category) {
//		log.debug(category);

		// 사용자가 hover한 카테고리 이름을 바탕으로 db에서 조회
		List<ClubAndImage> _clubAndImages = clubService.categoryList(category);

		// 5개만 뽑아서 넘겨줄 리스트 생성
		List<ClubAndImage> clubAndImages = new ArrayList<>();

		// 조회한 결과가 존재하고, 조회된 결과가 5개 이상인 경우
		if (_clubAndImages != null && !_clubAndImages.isEmpty() && !(_clubAndImages.size() <= 5)) {
			// 5개만 리스트에 담음

			for(int i=0; i<5; i++) {
				clubAndImages.add(_clubAndImages.get(i));
			}
		}
		// 조회된 결과가 5개 미만인 경우
		else {
			for (ClubAndImage one : _clubAndImages) {
				clubAndImages.add(one);
			}
		}

		return ResponseEntity.status(HttpStatus.OK).body(clubAndImages);
	}

	/**
	 * 해당 모임의 회원관리 클릭시
	 * 
	 * @author 창환
	 */
	@GetMapping("/{domain}/manageMember.do")
	public String manageMemeber(@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain); // 해당 클럽의 아이디(pk) 가져오기

		List<ManageMember> clubApplies = clubService.clubApplyByFindByClubId(clubId); // clubId로 club_apply, member 테이블
																						// 조인
//		log.debug("clubId = {}", clubId);
//		log.debug("clubApplies = {}", clubApplies);

		List<ClubMember> clubMembers = clubService.clubMemberByFindAllByClubId(clubId); // clubId로 club_member 조회(방장 제외)
//		log.debug("clubMembers = {}", clubMembers);

		List<JoinClubMember> joinClubMembersInfo = clubService.clubMemberInfoByFindByMemberId(clubMembers, clubId); // 해당
																													// 모임에
																													// 가입된
																													// 회원
																													// 정보(이름,
																													// 닉네임,
																													// 가입일)
//		log.debug("joinClubMembersInfo = {}", joinClubMembersInfo);

		JoinClubMember host = clubService.hostFindByClubId(clubId);
//		log.debug("host = {}", host);

		String loginMemberId = member.getMemberId(); // 로그인 한 회원 아이디
		ClubMemberRole clubMemberRole = ClubMemberRole.builder().clubId(clubId).loginMemberId(loginMemberId).build();
		// 로그인한 회원 아이디로 해당 모임의 권한 가져오기
		int memberRole = clubService.memberRoleFindByMemberId(clubMemberRole);

//		log.debug("memberRole = {}", memberRole);

		model.addAttribute("host", host); // 해당 모임의 방장 정보(아이디, 이름, 닉네임, 가입일, 권한)
		model.addAttribute("clubId", clubId); // 가입승인 시 필요 (종환)
		model.addAttribute("memberRole", memberRole); // 해당 모임에서 로그인한 회원의 권한
		model.addAttribute("clubApplies", clubApplies);
		model.addAttribute("loginMemberId", loginMemberId); // 로그인한 회원의 아이디
		model.addAttribute("joinClubMembersInfo", joinClubMembersInfo); // 해당 모임에 가입된 회원 정보 [방장제외](아아디, 이름, 닉네임, 가입일, 회원
																		// 권한)

		return "/club/manageMember";
	}

	/**
	 * 해당 모임의 회원 강제 탈퇴
	 * 
	 * @author 창환
	 */
	@PostMapping("/{domain}/kickMember.do")
	public String kickMember(@PathVariable("domain") String domain, @RequestParam String memberId,
			KickMember kickMember) {

//		log.debug("domain = {}", domain);
//		log.debug("memberId = {}", memberId);
		int clubId = clubService.clubIdFindByDomain(domain); // clubId 찾아오기

		kickMember.setClubId(clubId);
		kickMember.setMemberId(memberId);

		int result = clubService.kickMember(kickMember); // club_member 테이블에서 해당 회원 삭제

		return "redirect:/club/" + domain + "/manageMember.do";
	}

	@GetMapping("/{domain}/findBoardType.do")
	public ResponseEntity<?> boardList(@RequestParam(required = false, defaultValue = "0") int boardType,
			@PathVariable("domain") String domain, @RequestParam(defaultValue = "1") int page) {

		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();

		int _type = (boardType != 0) ? boardType : 0;

		ClubBoard clubBoard = ClubBoard.builder().clubId(clubId).type(_type).build();

		Map<String, Object> params = Map.of("page", page, "limit", LIMIT);

		List<ClubBoard> boards = clubService.boardList(clubBoard, params);
		
		int boardSize = clubService.boardSize(clubBoard);
		log.debug("boardSize={}",boardSize);
		
		Map<String, Object> boardInfo = Map.ofEntries(
				Map.entry("boardSize", boardSize),
				Map.entry("boards", boards)
		);
		
		return ResponseEntity.status(HttpStatus.OK).body(boardInfo);
	}

	@GetMapping("/{domain}/boardDetail.do")
	public String cluboardDetail(@PathVariable("domain") String domain, @RequestParam int no, Model model) {
		ClubBoard clubBoard = clubBoardGet(domain, no);

		List<ClubBoardAttachment> attachments = findAttachments(no);

		log.debug("attachments={}", attachments);
		model.addAttribute("clubBoard", clubBoard);
		model.addAttribute("attachments", attachments);

		return "/club/clubBoardDetail";
	}

	private List<ClubBoardAttachment> findAttachments(int no) {
		List<ClubBoardAttachment> attachments = new ArrayList<>();
		attachments = clubService.findAttachments(no);
		return attachments;
	}

	@PostMapping("/{domain}/likeCheck.do")
	public ResponseEntity<?> likeCheck(@RequestParam int boardId, @RequestParam boolean like,
			@PathVariable("domain") String domain) {

		ClubBoard board = clubService.findByBoardId(boardId);
		log.debug("board ={}", board);
		log.debug("boardId ={}", boardId);
		int likeCount = board.getLikeCount();
		int result;
		if (like) {
			likeCount = likeCount + 1;
			board.setLikeCount(likeCount);
			result = clubService.updateBoard(board);
		} else {
			likeCount = likeCount - 1;
			board.setLikeCount(likeCount);
			result = clubService.updateBoard(board);
		}

		return ResponseEntity.status(HttpStatus.OK).body(board);
	}

	@GetMapping("/{domain}/boardUpdate.do")
	public String boardUpdate(@PathVariable("domain") String domain, @RequestParam int no, Model model) {
		ClubBoard clubBoard = clubBoardGet(domain, no);

		List<ClubBoardAttachment> attachments = findAttachments(no);

		model.addAttribute("attachments", attachments);
		model.addAttribute("clubBoard", clubBoard);
		model.addAttribute("domain", domain);

		return "/club/clubBoardUpdate";
	}

	@PostMapping("/{domain}/boardUpdate.do")
	public String boardUpdate(@PathVariable("domain") String domain, @RequestParam int no, @RequestParam String title,
			@RequestParam int type, @RequestParam String content,
			@RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles)
			throws IllegalStateException, IOException {
		ClubBoard _board = clubBoardGet(domain, no);

		_board.setContent(content);
		_board.setTitle(title);
		_board.setType(type);

		List<ClubBoardAttachment> attachments = new ArrayList<>();
		if (!upFiles.isEmpty() && upFiles != null)
			attachments = insertAttachment(upFiles, attachments);

		ClubBoardDetails clubBoard = ClubBoardDetails.builder().attachments(attachments).title(_board.getTitle())
				.content(_board.getContent()).type(_board.getType()).boardId(_board.getBoardId())
				.likeCount(_board.getLikeCount()).status(_board.getStatus()).build();

		int result = clubService.updateBoard(clubBoard);

		log.debug("clubBoard = {}", clubBoard);

		return "redirect:/club/" + domain + "/boardDetail.do?no=" + no;
	}

	/**
	 * 해당 모임의 방장, 부방장은 모임에 가입되어있는 회원의 권한을 변경 가능
	 * 
	 * @author 창환
	 */
	@PostMapping("/{domain}/clubMemberRole.do")
	public String clubMemberRoleUpdate(@PathVariable("domain") String domain, @RequestParam String memberId,
			@RequestParam int clubMemberRole) {

		log.debug("memberId = {}", memberId);
		log.debug("clubMemberRole = {}", clubMemberRole);

		ClubMemberRoleUpdate member = ClubMemberRoleUpdate.builder().memberId(memberId).clubMemberRole(clubMemberRole)
				.build();

		log.debug("member = {}", member);
		int result = clubService.clubMemberRoleUpdate(member);
		log.debug("result = {}", result);

		return "redirect:/club/" + domain + "/manageMember.do";
	}

	@GetMapping("/clubCreate.do")
	public void clubCreate() throws Exception {

	}

	/**
	 * 클럽 비활성화 버튼( 클럽테이블의 status값을 Y -> N으로 변경)
	 * 
	 * @author 준한
	 */
	@GetMapping("/{domain}/clubDisabled.do")
	public String clubDisabled(@PathVariable("domain") String domain) {
		int clubId = clubService.clubIdFindByDomain(domain); // 해당 클럽의 아이디(pk) 가져오기
		int result = clubService.clubDisabled(clubId);
		return "redirect:/";
	}

	@GetMapping("/findAddress.do")
	public ResponseEntity<?> findAddress(String keyword) throws UnsupportedEncodingException {

		if (keyword == null || keyword == "")
			return null;
		String SearchType = "address";

		JsonArray documents = kakaoMapApi(keyword, SearchType);

		Gson gson = new Gson();

		List<String> addressList = new ArrayList<>();
		for (JsonElement document : documents) {
			JsonObject item = document.getAsJsonObject();
			String addressName = item.get("address_name").getAsString();
			addressList.add(addressName);
			System.out.println(item.get("x"));
			System.out.println(item.get("y"));
		}
		return ResponseEntity.status(HttpStatus.OK).body(addressList);
	}

	@PostMapping("/clubCreate.do")
	public String clubCreate(@Valid ClubCreateDto _club, BindingResult bindingResult,
			@AuthenticationPrincipal MemberDetails member, @RequestParam(value = "upFile") MultipartFile upFile)
			throws IllegalStateException, IOException {

		// 1. 파일저장

		String uploadDir = "/club/profile/";
		ClubProfile clubProfile = null;
		if (!upFile.isEmpty()) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename); // 20230807_142828888_123.jpg
			File destFile = new File(uploadDir + renamedFilename); // 부모디렉토리 생략가능. spring.servlet.multipart.location 값을
																	// 사용
			upFile.transferTo(destFile); // 실제파일 저장

			clubProfile = ClubProfile.builder().originalFilename(originalFilename).renamedFilename(renamedFilename)
					.build();
		}

		List<String> tagList = new ArrayList<>();
		for (String tag : _club.getTags().split(",")) {
			tagList.add(tag);
		}

		// 2. db저장
		ClubDetails club = ClubDetails.builder().clubName(_club.getClubName()).activityArea(_club.getActivityArea())
				.category(_club.getCategory()).tagList(tagList).domain(_club.getDomain())
				.introduce(_club.getIntroduce()).enrollQuestion(_club.getEnrollQuestion()).clubProfile(clubProfile)
				.build();

		int result = clubService.insertClub(club);

		return "redirect:/club/clubCreate.do";
	}

	@GetMapping("/{domain}/clubUpdate.do")
	public String clubUpdate(@PathVariable("domain") String domain, Model model) {
		int clubId = clubService.clubIdFindByDomain(domain);
		Club club = clubService.findClubById(clubId);
		ClubProfile clubProfile = clubService.findClubProfileById(clubId);
		List<ClubTag> clubTagList = clubService.findClubTagById(clubId);

		log.debug("club = {}", club);
		log.debug("clubProfile={}", clubProfile);
		log.debug("clubTag = {}", clubTagList);
		model.addAttribute("club", club);
		model.addAttribute("clubProfile", clubProfile);
		model.addAttribute("clubTagList", clubTagList);

		return "club/clubUpdate";
	}

	@PostMapping("/{domain}/clubUpdate.do")
	public String clubUpdate(@PathVariable("domain") String domain, @Valid ClubUpdateDto _club,
			BindingResult bindingResult, @AuthenticationPrincipal MemberDetails member,
			@RequestParam(value = "upFile") MultipartFile upFile) throws IllegalStateException, IOException {
		int clubId = clubService.clubIdFindByDomain(domain);
		// 1. 파일저장

		String uploadDir = "/club/Profile/";
		ClubProfile clubProfile = null;
		if (!upFile.isEmpty()) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename); // 20230807_142828888_123.jpg
			File destFile = new File(uploadDir + renamedFilename); // 부모디렉토리 생략가능. spring.servlet.multipart.location 값을
																	// 사용
			upFile.transferTo(destFile); // 실제파일 저장

			clubProfile = ClubProfile.builder().originalFilename(originalFilename).renamedFilename(renamedFilename)
					.build();
		}

		List<String> tagList = new ArrayList<>();
		for (String tag : _club.getTags().split(",")) {
			tagList.add(tag);
		}

		// 2. db저장
		ClubDetails club = ClubDetails.builder().clubName(_club.getClubName()).activityArea(_club.getActivityArea())
				.category(_club.getCategory()).tagList(tagList).domain(_club.getDomain())
				.introduce(_club.getIntroduce()).enrollQuestion(_club.getEnrollQuestion()).clubProfile(clubProfile)
				.build();
		club.setClubId(clubId);

		System.out.println(club);
		int result = clubService.updateClub(club);

		return "redirect:/";
	}

	public ClubBoard clubBoardGet(String domain, int no) {

		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();
		int boardId = no;
		ClubBoard _clubBoard = ClubBoard.builder().clubId(clubId).boardId(boardId).build();
		ClubBoard clubBoard = clubService.findByBoard(_clubBoard);

		return clubBoard;
	}

	public List<ClubBoardAttachment> insertAttachment(List<MultipartFile> upFiles,
			List<ClubBoardAttachment> attachments) throws IllegalStateException, IOException {

		for (int i = 0; i < upFiles.size(); i++) {
			if (!upFiles.get(i).isEmpty()) {
				String originalFilename = upFiles.get(i).getOriginalFilename();
				String renamedFilename = DagachiUtils.getRenameFilename(originalFilename);
				File destFile = new File(renamedFilename);
				upFiles.get(i).transferTo(destFile);

				ClubBoardAttachment attach = ClubBoardAttachment.builder().originalFilename(originalFilename)
						.renamedFilename(renamedFilename).build();
				log.debug("attach = {}", attach);
				if (!attachments.isEmpty() && i == 0)
					attach.setThumbnail(Status.Y);
				else
					attach.setThumbnail(Status.N);

				attachments.add(attach);
			}
		}

		return attachments;
	}

	@GetMapping("/findAttachments.do")
	public ResponseEntity<?> findAttachments(@RequestParam("domain") String domain, @RequestParam int no) {
		ClubBoard clubBoard = clubBoardGet(domain, no);
		int boardId = clubBoard.getBoardId();
		List<ClubBoardAttachment> attachments = findAttachments(boardId);

		return ResponseEntity.status(HttpStatus.OK).body(attachments);
	}

	@PostMapping("/delAttach.do")
	public ResponseEntity<?> delAttachment(@RequestParam int id) {
		int result = 0;
		List<ClubBoardAttachment> attachments = new ArrayList<>();
		ClubBoardAttachment attach = clubService.findAttachment(id);
		int no = attach.getBoardId();
		result = clubService.delAttachment(id);
		if (attach.getThumbnail() == Status.Y) {
			attachments = findAttachments(no);
			if (!attachments.isEmpty()) {
				attachments.get(0).setThumbnail(Status.Y);
				result = clubService.updateThumbnail(attachments.get(0));
			}
		}

		return ResponseEntity.status(HttpStatus.OK).body(attachments);
	}

	/**
	 * @author 준한 클럽 내 가입되어있는 회원들 조회페이지로 이동
	 */
	@GetMapping("/{domain}/clubMemberList.do")
	public String clubMemberList(@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain);
		Club club = clubService.findClubById(clubId);
		List<ClubMemberAndImage> clubMembers = clubService.findClubMembers(clubId);

		model.addAttribute("clubMembers", clubMembers);
		model.addAttribute("club", club);

		return "/club/clubMemberList";
	}

	@GetMapping("/clubsRecentVisited.do")
	public void clubsRecentVisited() {
	}

	@GetMapping("/{domain}/clubStyleUpdate.do")
	public String clubLayoutUpdate(@PathVariable("domain") String domain, Model model) {
		int clubId = clubService.clubIdFindByDomain(domain);
		ClubLayout layout = clubService.findLayoutById(clubId);

		model.addAttribute("layout", layout);
		model.addAttribute("domain", domain);
		return "club/clubStyleUpdate";
	}

	@PostMapping("/{domain}/clubStyleUpdate.do")
	public String clubLayoutUpdate(@PathVariable("domain") String domain, ClubStyleUpdateDto style) {

		int clubId = clubService.clubIdFindByDomain(domain);
		style.setClubId(clubId);
		int result = clubService.clubStyleUpdate(style);

		return "redirect:/club/" + domain; 
	}
	
	@GetMapping("/{domain}/clubTitleUpdate.do")
	public String clubTitleUpdate(@PathVariable("domain") String domain, Model model) {
		int clubId = clubService.clubIdFindByDomain(domain);
		ClubLayout layout = clubService.findLayoutById(clubId);
		System.out.println(layout);
		model.addAttribute("layout", layout);
		model.addAttribute("domain", domain);
		return "club/clubTitleUpdate";
	}
	
	
	@PostMapping("/{domain}/delBoard.do")
	public ResponseEntity<?> delClubBoard(@RequestParam int boardId) {

		int result = clubService.delClubBoard(boardId);

		String msg = "게시글이 삭제되었습니다.";
		return ResponseEntity.status(HttpStatus.OK).body(msg);
	}

	@GetMapping("/{domain}/searchClubBoard.do")
	public ResponseEntity<?> searchClubBoard(@PathVariable("domain") String domain,
			@RequestParam String searchKeywordVal, @RequestParam String searchTypeVal, @RequestParam int boardTypeVal) {

		Club club = clubService.findByDomain(domain);

		int clubId = club.getClubId();

		Map<String, Object> searchBoardMap = Map.ofEntries(Map.entry("clubId", clubId),
				Map.entry("searchKeyword", searchKeywordVal), Map.entry("searchType", searchTypeVal),
				Map.entry("type", boardTypeVal));

		log.debug("serchBoardMap={}", searchBoardMap);

		List<ClubBoard> boards = clubService.searchBoard(searchBoardMap);
		log.debug("boards={}", boards);

		return ResponseEntity.status(HttpStatus.OK).body(boards);
	}
	
	/**
	 * 이메일인증으로 아이디 찾기
	 * @author 준한
	 */
	@PostMapping("/searchIdModal.do")
	 public ResponseEntity<?> sendVerificationCode(
			 @RequestParam("username") String username, 
             @RequestParam("email") String email,
             JavaMailSender javaMailSender
			 ) {
		 
		 Member member = memberService.findMemberByName(username);
		 Member member2 = memberService.findMemberByEmail(email);
		 
		 log.debug("member ={}",member);
		 log.debug("member2 = {}",member2);
		 
		 if(member != null && member2 != null && member.equals(member2)) {
			 // 입력받은 이름과 이메일이 db에 있는 정보와 일치할 시,
//			 0 이상 1 미만의 랜덤한 double 값
//			 double randomValue = Math.random(); 
//		     String randomValueAsString = Double.toString(randomValue);
			 String title = "다가치 아이디 찾기 인증코드 발송메일";
			 String hi = "hi";
			 SimpleMailMessage message = new SimpleMailMessage();
			 message.setTo(email);
			 message.setSubject(title);
			 message.setText(hi);
			 
			 javaMailSender.send(message);
			 
		 }else {
			 
		 }
		 
		 return ResponseEntity.status(HttpStatus.OK).body(username);
	 }
	 
	 @PostMapping("/clubLike.do")
	 public String clubLike(
			 @RequestParam String memberId,
			 @RequestParam String domain,
			 RedirectAttributes attr
			 ) {
		 log.debug("멤버 아이디 : {}", memberId);
		 log.debug("도메인 : {}", domain);
		 
		 Club club = clubService.findByDomain(domain);
		 int targetId = club.getClubId();
		 Map<String, Object> params = Map.of(
				 "memberId", memberId,
				 "targetId", targetId
				 );
		 log.debug("타겟 아이디 : {},", targetId);
		 
		 int checkDuplicate = clubService.checkDuplicateClubLike(targetId);
		 log.debug("체크 튜플리케이트 : {},", checkDuplicate);
		 
		 if(checkDuplicate == 0) {
			int result = clubService.clubLike(params); 
		 }
		 return "redirect:/club/" + domain;
	 }
	
}
