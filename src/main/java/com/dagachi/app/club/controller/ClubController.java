package com.dagachi.app.club.controller;

import static com.dagachi.app.common.DagachiUtils.getAreaNamesByDistance;
import static com.dagachi.app.common.DagachiUtils.kakaoMapApi;

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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StopWatch;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dagachi.app.Pagination;
import com.dagachi.app.chat.service.ChatService;
import com.dagachi.app.club.common.Status;
import com.dagachi.app.club.dto.BoardAndImageDto;
import com.dagachi.app.club.dto.BoardCommentDto;
import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubBoardCreateDto;
import com.dagachi.app.club.dto.ClubCreateDto;
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
import com.dagachi.app.club.dto.ClubTitleUpdateDto;
import com.dagachi.app.club.dto.ClubUpdateDto;
import com.dagachi.app.club.dto.GalleryAndImageDto;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.KickMember;
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
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.common.DagachiUtils;
import com.dagachi.app.member.entity.ActivityArea;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.service.MemberService;
import com.dagachi.app.notification.service.NotificationService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/club")
@SessionAttributes({ "inputText", "zoneSetList", "zoneSet1", "zoneSet2", "zoneSet3", 
						"zoneSet4", "zoneSet5", "zoneSet6","clubAdminMsg", "clubName", "layout" })
public class ClubController {

	@Autowired
	private HttpSession httpSession;
	
	@Autowired
	NotificationService notificationService;

	private final JavaMailSender javaMailSender;

	static final int LIMIT = 10;

	static final Map<Integer, Double> ANGLEPATTERN // km(key)별로 360도를 나눌 각도(value)
			= Map.of(1, 45.0, 2, 30.0, 3, 22.5, 4, 18.0, 5, 15.0, 6, 11.25, 7, 9.0); // , 8, 7.5, 9, 6.0, 10, 5.0

	@Autowired
	private MemberService memberService;

	@Autowired
	private ClubService clubService;
	
	@Autowired
	private ChatService chatService;

	@Autowired
	public ClubController(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	@GetMapping("/getClubName.do")
	@ResponseBody
	public ResponseEntity<?> getClubname(@AuthenticationPrincipal MemberDetails member) {
		List<Club> clubs = clubService.findClubsByMemberId(member.getMemberId());

		return ResponseEntity.status(HttpStatus.OK).body(clubs);
	}

	/**
	 * 모임 가입 신청
	 * @author 나영
	 */
	@GetMapping("/{domain}/clubEnroll.do")
	public String ClubEnroll(@PathVariable("domain") String domain, RedirectAttributes redirectAttr, Model model,
			@AuthenticationPrincipal MemberDetails member) {
		int clubId = clubService.clubIdFindByDomain(domain);
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

	/**
	 * 모임 가입 신청
	 * @author 나영
	 */
	@PostMapping("/{domain}/clubEnroll.do")
	public String ClubEnroll(@Valid ClubEnrollDto enroll, Model model, @PathVariable("domain") String domain,
			@AuthenticationPrincipal MemberDetails member, RedirectAttributes redirectAttr) {
		enroll.setMemberId(member.getMemberId());
		int result = clubService.ClubEnroll(enroll);
		
		//가입신청시 방장에게 알람
		Club club =clubService.findByDomain(domain);
		JoinClubMember master=clubService.hostFindByClubId(club.getClubId());
		result= notificationService.membershipRequest(club,member,master);
		
		redirectAttr.addFlashAttribute("msg", "💡가입 신청 완료.💡");
		return "redirect:/club/" + domain;
	}

	/**
	 * 게시판 조회
	 * 
	 * @author 상윤
	 */
	@GetMapping("/{domain}/clubBoardList.do")
	public String boardList(@PathVariable("domain") String domain, @RequestParam(required = false) int no,
			Model model) {
		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();
		String clubName = club.getClubName();
		
		ClubLayout layout = clubService.findLayoutById(clubId);
		
		model.addAttribute("layout", layout);
		model.addAttribute("clubName", clubName);
		model.addAttribute("domain", domain);
		model.addAttribute("no", no);
		return "/club/clubBoardList";
	}

	/**
	 * 게시글 작성 페이지 반환
	 * 
	 * @author 상윤
	 */
	@GetMapping("/{domain}/clubBoardCreate.do")
	public String boardCreate(@PathVariable("domain") String domain, Model model) {
		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();
		String clubName = club.getClubName();
		
		ClubLayout layout = clubService.findLayoutById(clubId);
		
		model.addAttribute("layout", layout);
		model.addAttribute("clubName", clubName);
		model.addAttribute("domain", domain);
		return "/club/clubBoardCreate";
	}

	/**
	 * 모임내 게시글 작성
	 * 
	 * @author 상윤, 종환
	 */
	@PostMapping("/{domain}/boardCreate.do")
	public String boardCreate(@Valid ClubBoardCreateDto _board, @PathVariable("domain") String domain,
			@AuthenticationPrincipal MemberDetails member, Model model,
			@RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles)
			throws IllegalStateException, IOException {
		List<ClubBoardAttachment> attachments = new ArrayList<>();
		if (!upFiles.isEmpty())
			attachments = insertAttachment(upFiles, attachments);
		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();
		
		String clubName = club.getClubName();
		ClubLayout layout = clubService.findLayoutById(clubId);
		
		model.addAttribute(layout);
		model.addAttribute(clubName);
		
		
		String memberId = member.getMemberId();
		ClubBoardDetails clubBoard = ClubBoardDetails.builder().clubId(clubId).writer(memberId).type(_board.getType())
				.attachments(attachments).content(_board.getContent()).title(_board.getTitle()).build();
		int result = clubService.postBoard(clubBoard);
		return "redirect:/club/" + domain + "/clubBoardList.do?no=0";
	}

	/**
	 * 게시글 작성 시 첨부파일이 있는 경우 저장
	 * 
	 * @author 상윤
	 */
	public List<ClubBoardAttachment> insertAttachment(List<MultipartFile> upFiles,
			List<ClubBoardAttachment> attachments) throws IllegalStateException, IOException {

		for (int i = 0; i < upFiles.size(); i++) {
			if (!upFiles.get(i).isEmpty()) {
				String originalFilename = upFiles.get(i).getOriginalFilename();
				String renamedFilename = DagachiUtils.getRenameFilename(originalFilename);
				File destFile = new File("/club/board/" + renamedFilename);
				upFiles.get(i).transferTo(destFile); // 실제 파일 저장

				ClubBoardAttachment attach = ClubBoardAttachment.builder().originalFilename(originalFilename)
						.renamedFilename(renamedFilename).build();
				System.out.println("before첨부파일" + i + "   "+ attach);
				if (i == 0) {
					attach.setThumbnail(Status.Y);
				} else {
					attach.setThumbnail(Status.N);
				}
				System.out.println("첨부파일" + i + "   "+ attach);
				
				attachments.add(attach);
			}
		}
		return attachments;
	}

	/**
	 * 메인화면에서 모임 검색 (페이지바 처리 & getPagebar재활용위해 url에 replace처리)
	 * @author 종환
	 */
	@GetMapping("/clubSearch.do")
	public void clubSearch(@RequestParam String inputText, @RequestParam(defaultValue = "1") int page,
			HttpServletRequest request, Model model) {

		String getCount = "getCount";

		Map<String, Object> params = new HashMap<>();

		params.put("page", page);
		params.put("limit", LIMIT / 2); // 5개
		params.put("inputText", inputText);

		// 해당 페이지에 보여질 검색결과
		List<ClubSearchDto> clubs = clubService.clubSearch(params);
		model.addAttribute("clubs", clubs);

		// 페이징바에 필요한 검색결과 총 갯수
		params.put("getCount", getCount);
		int totalCount = clubService.clubSearch(params).size();

		// 페이징바 처리
		String url = request.getRequestURI();
		url += "#&inputText=" + inputText;
		String pageBar = Pagination.getPagebar(page, LIMIT / 2, totalCount, url);
		pageBar = pageBar.replaceAll("\\?", "&");
		pageBar = pageBar.replaceAll("#&", "\\?");

		model.addAttribute("pagebar", pageBar);
		model.addAttribute("inputText", inputText);
		model.addAttribute("totalCount", totalCount);
	}

	/**
	 * 메인에서 모임 검색 후 필터 추가 검색
	 * 
	 * @author 종환
	 */
	@GetMapping("/searchClubWithFilter.do")
	public String searchClubWithFilter(Model model, HttpSession session, HttpServletRequest request,
			@RequestParam(defaultValue = "") String zone, @RequestParam(defaultValue = "") String region, @RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "1") int page) {
		String area = region + " " + zone;
		String getCount = "getCount";
		String inputText = (String) session.getAttribute("inputText");

		Map<String, Object> params = new HashMap<>();
		params.put("area", area);
		params.put("page", page);
		params.put("limit", LIMIT / 2);
		params.put("category", category);
		params.put("inputText", inputText);

		List<ClubSearchDto> clubs = clubService.searchClubWithFilter(params);

		params.put("getCount", getCount);
		int totalCount = clubService.searchClubWithFilter(params).size();
		// log.debug("totalCount, clubs = {}{}", totalCount, clubs);
		String url = request.getRequestURI();
		url += "#&inputText=" + inputText + "&region=" + region + "&zone=" + zone + "&category=" + category;
		String pageBar = Pagination.getPagebar(page, LIMIT / 2, totalCount, url);
		pageBar = pageBar.replaceAll("\\?", "&");
		pageBar = pageBar.replaceAll("#&", "\\?");

		model.addAttribute("zone", zone);
		model.addAttribute("clubs", clubs);
		model.addAttribute("region", region);
		model.addAttribute("pagebar", pageBar);
		model.addAttribute("category", category);
		model.addAttribute("inputText", inputText);
		model.addAttribute("totalCount", totalCount);

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
	 * @author 종환
	 */
	@PostMapping("/{domain}/manageApply.do")
	public String permitApply(@PathVariable("domain") String domain, ClubManageApplyDto clubManageApplyDto) {
		
		Club club = clubService.findByDomain(domain);
		JoinClubMember master = clubService.hostFindByClubId(club.getClubId());
		
		if (clubManageApplyDto.isPermit()) {
			clubService.permitApply(clubManageApplyDto); // 가입 승인
			//가입 승인 거절 알람 - 상윤
			int permitApply = notificationService.permitApply(club,clubManageApplyDto.getMemberId(),master);
		}
		else {
			clubService.refuseApply(clubManageApplyDto); // 가입 거절
			int permitApply = notificationService.refuseApply(club,clubManageApplyDto.getMemberId(),master);
		}
		
		return "redirect:/club/" + domain + "/manageMember.do";
	}

	/**
	 * 로그인한 회원의 활동지역 Model에 저장하고 페이지 이동
	 * @author 종환
	 */
	@GetMapping("/clubSearchSurrounded.do")
	public void clubSearchSurrounded(@AuthenticationPrincipal MemberDetails member, Model model) {
		ActivityArea activityArea = memberService.findActivityAreaById(member.getMemberId());
		String mainAreaId = activityArea.getMainAreaId();
		model.addAttribute("mainAreaId", mainAreaId);
	}

	/**
	 * 활동지역 중심 주변모임 검색 (session에 저장되어있는 정보 사용)
	 * @author 종환
	 */
	@GetMapping("/clubSearchByDistance.do")
	public ResponseEntity<?> clubSearchByDistance(HttpSession session, @RequestParam int distance,
			@RequestParam String category, // 사용자가 선택한 분류
			@RequestParam String mainAreaName, // "서울특별시 **구 **동"
			@AuthenticationPrincipal MemberDetails member) throws UnsupportedEncodingException {

		// 주변의 모든 법정동리스트로 모임 조회 후 리턴
		Set<String> zoneSet = (Set<String>) session.getAttribute("zoneSet" + distance);
		Map<String, Object> params = new HashMap<>();
		params.put("zoneSet", zoneSet);

		if (!"".equals(category))
			params.put("category", category); // 사용자가 카테고리를 선택했을 때만 params에 추가
		List<ClubSearchDto> clubs = clubService.findClubByDistance(params);
//		log.debug("ClubSearchDto = {}", clubs);

		return ResponseEntity.status(HttpStatus.OK).body(clubs);
	}

	/**
	 * 최초로그인시 비동기로 회원의 주활동지역코드 구하는 코드 (주변모임 추천용)
	 * @author 종환
	 */
	@ResponseBody
	@GetMapping("getMainAreaId.do")
	public Map<String, Object> getMainAreaId(@AuthenticationPrincipal MemberDetails member) {
		Map<String, Object> response = new HashMap<>();
		ActivityArea activityArea = memberService.findActivityAreaById(member.getMemberId());
		String mainAreaId = activityArea.getMainAreaId();
		response.put("mainAreaId", mainAreaId);
		return response;
	}

	/**
	 * 최초 로그인 시 km 별로 반경에 있는 법정동명 session에 저장
	 * @author 종환
	 */
	@ResponseBody
	@GetMapping("/setZoneInSession.do")
	public void setZoneInSession(@RequestParam String mainAreaName, Model model) throws UnsupportedEncodingException {

		JsonArray documents = kakaoMapApi(mainAreaName, "address"); // api요청 결과를 json배열로 반환하는 method
		JsonElement document = documents.getAsJsonArray().get(0);
		JsonObject item = document.getAsJsonObject();
		double x = item.get("x").getAsDouble();
		double y = item.get("y").getAsDouble();

		StopWatch sw = new StopWatch();
		sw.start();

		// 싸인 코사인으로 계산하는 메소드
		for (int i = 1; i <= 6; i++) {
			Set<String> zoneSet = getAreaNamesByDistance(x, y, i, ANGLEPATTERN); // 검색할 km기반으로 주변 동이름이 들어있는 set 반환
			model.addAttribute("zoneSet" + i, zoneSet);
			log.debug("zoneSet{}= {}", i, zoneSet);
		}
		sw.stop();

		log.debug("법정동 api 요청시간 = {}초", sw.getTotalTimeSeconds());
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

		ClubNameAndCountDto clubInfo = clubService.findClubInfoById(clubId);

		List<GalleryAndImageDto> galleries = clubService.findgalleryById(clubId);
		List<ClubScheduleAndMemberDto> schedules = clubService.findScheduleById(clubId);
		List<BoardAndImageDto> boardAndImages = clubService.findBoardAndImageById(clubId);
		String memberId = member.getMemberId();
		for (BoardAndImageDto board : boardAndImages) {
			board.setNickname(chatService.getNicknameById(board.getWriter()));
		}
		for (ClubScheduleAndMemberDto schedule : schedules) {
			schedule.setNickname(chatService.getNicknameById(schedule.getWriter()));
		}

		// 최근 본 모임 전체 조회 (현우)
		List<ClubRecentVisited> recentVisitClubs = clubService.findAllrecentVisitClubs();
		
		Map<String, Object> params = Map.of(
				 "memberId", memberId,
				 "clubId", clubId
				 );
		
		int checkDuplicate = clubService.checkDuplicateClubId(clubId);
		int checkDuplicated = clubService.checkDuplicateClubIdAndId(params);
//		log.debug("recentVisitClubs = {}", recentVisitClubs);

		// 최근 본 모임 클릭 시 중복검사 후 db에 삽입
		if (checkDuplicated == 0) {
			int result = clubService.insertClubRecentVisitd(memberId, clubId);
		}

		ClubMemberRole clubMemberRole = ClubMemberRole.builder().clubId(clubId).loginMemberId(memberId).build();

		// 로그인한 회원 아이디로 해당 모임의 권한 가져오기
		int memberRole = clubService.memberRoleFindByMemberId(clubMemberRole);
		model.addAttribute("domain", domain);
		model.addAttribute("layout", layout);
		model.addAttribute("memberId", memberId);
		model.addAttribute("clubInfo", clubInfo);
		model.addAttribute("galleries", galleries);
		model.addAttribute("schedules", schedules);
		model.addAttribute("memberRole", memberRole);
		model.addAttribute("boardAndImages", boardAndImages);

		return "club/clubDetail";
	}

	/**
	 * 로그인이 안되어 있을시 메인에서 소모임 전체 조회(카드로 출력)
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
	 * 
	 * @author 창환
	 */
	@PostMapping("/{domain}/clubReport.do")
	public ResponseEntity<?> clubReport(@PathVariable("domain") String domain, @Valid ClubReportDto clubReportDto) {

		int clubId = clubService.clubIdFindByDomain(domain);
		clubReportDto.setClubId(clubId);

		int result = clubService.insertClubReport(clubReportDto);
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

			for (int i = 0; i < 5; i++)
				clubAndImages.add(_clubAndImages.get(i));
		}
		// 조회된 결과가 5개 미만인 경우
		else {
			for (ClubAndImage one : _clubAndImages)
				clubAndImages.add(one);
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
		List<ClubMember> clubMembers = clubService.clubMemberByFindAllByClubId(clubId); // clubId로 club_member 조회(방장 제외)

		List<JoinClubMember> joinClubMembersInfo = clubService.clubMemberInfoByFindByMemberId(clubMembers, clubId); // 해당
																													// 모임에
																													// 가입된
																													// 회원
																													// 정보(이름,
																													// 닉네임,
																													// 가입일)
		JoinClubMember host = clubService.hostFindByClubId(clubId);

		String loginMemberId = member.getMemberId(); // 로그인 한 회원 아이디
		ClubMemberRole clubMemberRole = ClubMemberRole.builder().clubId(clubId).loginMemberId(loginMemberId).build();
		// 로그인한 회원 아이디로 해당 모임의 권한 가져오기
		int memberRole = clubService.memberRoleFindByMemberId(clubMemberRole);

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

		int clubId = clubService.clubIdFindByDomain(domain); // clubId 찾아오기

		kickMember.setClubId(clubId);
		kickMember.setMemberId(memberId);

		int result = clubService.kickMember(kickMember); // club_member 테이블에서 해당 회원 삭제

		return "redirect:/club/" + domain + "/manageMember.do";
	}

	/**
	 * 비동기 10개씩 조회하는 핸들러
	 * 
	 * @author 상윤
	 */
	@GetMapping("/{domain}/findBoardType.do")
	public ResponseEntity<?> boardList(@RequestParam(required = false, defaultValue = "0") int boardType,
			@PathVariable("domain") String domain, @RequestParam(defaultValue = "1") int page, Model model) {

		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();
		String clubName = club.getClubName();
		
		ClubLayout layout = clubService.findLayoutById(clubId);
		
		model.addAttribute("layout", layout);
		model.addAttribute("clubName", clubName);

		int _type = (boardType != 0) ? boardType : 0;

		ClubBoard clubBoard = ClubBoard.builder().clubId(clubId).type(_type).build();

		Map<String, Object> params = Map.of("page", page, "limit", LIMIT);

		List<ClubBoard> boards = clubService.boardList(clubBoard, params);

		int boardSize = clubService.boardSize(clubBoard);

		Map<String, Object> boardInfo = Map.ofEntries(Map.entry("boardSize", boardSize), Map.entry("boards", boards));

		return ResponseEntity.status(HttpStatus.OK).body(boardInfo);
	}

	/**
	 * 게시글 조회
	 * 
	 * @author 상윤, 종환
	 */
	@GetMapping("/{domain}/boardDetail.do")
	public String cluboardDetail(@RequestParam int no, Model model, @PathVariable("domain") String domain,
			@AuthenticationPrincipal MemberDetails member) {

		Club club = clubService.findByDomain(domain);
		ClubLayout layout = clubService.findLayoutById(club.getClubId());
		System.out.println(domain);
		ClubBoard clubBoard = clubBoardGet(domain, no);

		Map<String, Object> params = Map.of("type", 2, "memberId", member.getMemberId(), "targetId",
				clubBoard.getBoardId());
		String nickname = memberService.findMemberById(member.getMemberId()).getNickname();
		Boolean liked = clubService.checkBoardLiked(params) != 0;

		List<ClubBoardAttachment> attachments = clubService.findAttachments(no);

		List<BoardComment> _comments = clubService.findComments(no);
		List<BoardCommentDto> comments = new ArrayList<>();
		// List<MemberProfile> clubProfiles =
		// memberService.findMemberProfileByClubId(clubBoard.getClubId());

		if (!_comments.isEmpty()) {
			for (BoardComment comment : _comments) {
				BoardCommentDto commentDto = buildCommentDto(comment);
				comments.add(commentDto);
			}
		}
		int clubId = clubService.clubIdFindByDomain(domain);
		ClubMemberRole clubMemberRoleDto = new ClubMemberRole(clubId, member.getMemberId());
		int ClubMemberRole = clubService.memberRoleFindByMemberId(clubMemberRoleDto);

		model.addAttribute("liked", liked);
		model.addAttribute("layout", layout);
		model.addAttribute("clubName", club.getClubName());
		model.addAttribute("comments", comments);
		model.addAttribute("nickname", nickname);
		model.addAttribute("clubBoard", clubBoard);
		model.addAttribute("attachments", attachments);
		model.addAttribute("ClubMemberRole", ClubMemberRole);

		return "/club/clubBoardDetail";
	}

	/**
	 * 댓글 객체에서 dto+profile 객체만드는 메소드
	 * 
	 * @author 상윤
	 * @param boardId
	 */
	public BoardCommentDto buildCommentDto(BoardComment comment) {
		Member member = memberService.findMemberById(comment.getWriter());
		String nickname = member.getNickname();

		BoardCommentDto commentDto = BoardCommentDto.builder().nickname(nickname).writer(comment.getWriter())
				.status(comment.getStatus()).boardId(comment.getBoardId()).content(comment.getContent())
				.createdAt(comment.getCreatedAt()).commentId(comment.getCommentId()).commentRef(comment.getCommentRef())
				.commentLevel(comment.getCommentId())
				.profile(memberService.findMemberProfile(comment.getWriter()).getRenamedFilename()).build();

		return commentDto;
	}

	/**
	 * 게시글 댓글 작성
	 * 
	 * @author 상윤
	 */
	@PostMapping("/{domain}/createComment.do")
	public ResponseEntity<?> createComment(@RequestParam int boardId, @RequestParam String content,
			@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member) {

		String memberId = member.getMemberId();
		ClubBoard clubBoard = clubBoardGet(domain, boardId);

		BoardComment _comment = BoardComment.builder().writer(memberId).content(content).boardId(boardId).build();

		int result = clubService.boardCommentCreate(_comment);

		BoardComment comment = clubService.findBoardComment(_comment.getCommentId());

		BoardCommentDto commentDto = buildCommentDto(comment);

		return ResponseEntity.status(HttpStatus.OK).body(commentDto);
	}

	/**
	 * 게시글 좋아요
	 * 
	 * @author 상윤, 종환
	 */
	@PostMapping("/{domain}/likeCheck.do")
	public ResponseEntity<?> likeCheck(@RequestParam int boardId, @RequestParam boolean like,
			@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member) {

		ClubBoard board = clubService.findByBoardId(boardId);
		String memberId = member.getMemberId();
		int likeCount = board.getLikeCount();

		Map<String, Object> params = Map.of("type", 2, "like", like, "board", board, "targetId", boardId, "memberId",
				memberId);
//		log.debug("params = {}", params);

		int result = 0;
		if (like) {
			likeCount = likeCount + 1;
			board.setLikeCount(likeCount);
			result = clubService.likeBoard(params);
		} else {
			likeCount = likeCount - 1;
			board.setLikeCount(likeCount);
			result = clubService.likeBoard(params);
		}

		board = clubService.findByBoardId(boardId);

		return ResponseEntity.status(HttpStatus.OK).body(board);
	}

	/**
	 * 게시글 수정 jsp 전송
	 * 
	 * @author 상윤
	 */
	@GetMapping("/{domain}/boardUpdate.do")
	public String boardUpdate(@PathVariable("domain") String domain, @RequestParam int no, Model model) {
		ClubBoard clubBoard = clubBoardGet(domain, no);

		List<ClubBoardAttachment> attachments = clubService.findAttachments(no);

		model.addAttribute("attachments", attachments);
		model.addAttribute("clubBoard", clubBoard);
		model.addAttribute("domain", domain);

		return "/club/clubBoardUpdate";
	}

	/**
	 * 게시글 수정 POST
	 * 
	 * @author 상윤
	 */
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
				.status(_board.getStatus()).content(_board.getContent()).likeCount(_board.getLikeCount())
				.type(_board.getType()).boardId(_board.getBoardId()).build();

		int result = clubService.updateBoard(clubBoard);

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

		ClubMemberRoleUpdate member = ClubMemberRoleUpdate.builder().memberId(memberId).clubMemberRole(clubMemberRole)
				.build();

		int result = clubService.clubMemberRoleUpdate(member);

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

	/**
	 * 
	 * @author ?
	 */
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
		}
		return ResponseEntity.status(HttpStatus.OK).body(addressList);
	}

	/**
	 * 소모임 생성
	 * @author 동찬
	 */
	@PostMapping("/clubCreate.do")
	public String clubCreate(
			@Valid ClubCreateDto _club, 
			@AuthenticationPrincipal MemberDetails member, 
			@RequestParam(value = "upFile") MultipartFile upFile) throws IllegalStateException, IOException {
		// 1. 파일저장
		String uploadDir = "/club/profile/";
		ClubProfile clubProfile = null;
		if (!upFile.isEmpty()) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename); // 20230807_142828888_123.jpg
			File destFile = new File(uploadDir + renamedFilename); // 부모디렉토리 생략가능. spring.servlet.multipart.location 값을
																   // 사용
			upFile.transferTo(destFile); // 실제파일 저장
			clubProfile = ClubProfile.builder()
									 .originalFilename(originalFilename)
									 .renamedFilename(renamedFilename).build();
		}

		List<String> tagList = new ArrayList<>();
		for (String tag : _club.getTags().split(",")) {
			tagList.add(tag);
		}

		// 2. db저장
		ClubDetails club = ClubDetails.builder()
									  .tagList(tagList)
									  .clubProfile(clubProfile)
									  .domain(_club.getDomain())
									  .clubName(_club.getClubName())
									  .category(_club.getCategory())
									  .introduce(_club.getIntroduce())
									  .enrollQuestion(_club.getEnrollQuestion())
									  .activityArea(_club.getActivityArea()).build();

		int result = clubService.insertClub(club, member.getMemberId());
		
		return "redirect:/club/" + _club.getDomain();
	}

	/**
	 * @author 준한
	 */
	@GetMapping("/{domain}/clubUpdate.do")
	public String clubUpdate(@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain);
		Club club = clubService.findClubById(clubId);
		ClubProfile clubProfile = clubService.findClubProfileById(clubId);
		List<ClubTag> clubTagList = clubService.findClubTagById(clubId);

		String memberId = member.getMemberId();
		ClubMemberRole clubMemberRole = ClubMemberRole.builder().clubId(clubId).loginMemberId(memberId).build();

		// 로그인한 회원 아이디로 해당 모임의 권한 가져오기
		int memberRole = clubService.memberRoleFindByMemberId(clubMemberRole);

		model.addAttribute("club", club);
		model.addAttribute("memberRole", memberRole);
		model.addAttribute("clubProfile", clubProfile);
		model.addAttribute("clubTagList", clubTagList);

		return "club/clubUpdate";
	}

	/**
	 * @author 준한
	 */
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

			clubProfile = ClubProfile.builder().originalFilename(originalFilename)
												.renamedFilename(renamedFilename)
												 .build();
		}

		List<String> tagList = new ArrayList<>();

		for (String tag : _club.getTags().split(","))
			tagList.add(tag);

		// 2. db저장
		ClubDetails club = ClubDetails.builder().clubName(_club.getClubName()).activityArea(_club.getActivityArea())
				.category(_club.getCategory()).tagList(tagList).domain(_club.getDomain())
				.introduce(_club.getIntroduce()).enrollQuestion(_club.getEnrollQuestion()).clubProfile(clubProfile)
				.build();
		club.setClubId(clubId);

		int result = clubService.updateClub(club);

		return "redirect:/";
	}

	/**
	 * 도메인이랑 게시글 번호로 ClubBoard객체 반환하는 메소드
	 * 
	 * @author 상윤
	 */
	public ClubBoard clubBoardGet(String domain, int no) {

		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();
		int boardId = no;
		ClubBoard _clubBoard = ClubBoard.builder().clubId(clubId).boardId(boardId).build();
		ClubBoard clubBoard = clubService.findByBoard(_clubBoard);

		return clubBoard;
	}

	/**
	 * @author 상윤
	 */
	@GetMapping("/findAttachments.do")
	public ResponseEntity<?> findAttachments(@RequestParam("domain") String domain, @RequestParam int no) {
		ClubBoard clubBoard = clubBoardGet(domain, no);
		int boardId = clubBoard.getBoardId();
		List<ClubBoardAttachment> attachments = clubService.findAttachments(boardId);

		return ResponseEntity.status(HttpStatus.OK).body(attachments);
	}

	/**
	 * 첨부파일 삭제
	 * 
	 * @author 상윤
	 */
	@PostMapping("/delAttach.do")
	public ResponseEntity<?> delAttachment(@RequestParam int id) {
		int result = 0;
		List<ClubBoardAttachment> attachments = new ArrayList<>();
		ClubBoardAttachment attach = clubService.findAttachment(id);
		int no = attach.getBoardId();
		result = clubService.delAttachment(id);
		
		if (attach.getThumbnail() == Status.Y) {
			attachments = clubService.findAttachments(no);
			
			if (!attachments.isEmpty()) {
				attachments.get(0).setThumbnail(Status.Y);
				result = clubService.updateThumbnail(attachments.get(0));
			}
			
		}

		return ResponseEntity.status(HttpStatus.OK).body(attachments);
	}

	/**
	 * 클럽 내 가입되어있는 회원들 조회페이지로 이동
	 * 
	 * @author 준한
	 */
	@GetMapping("/{domain}/clubMemberList.do")
	public String clubMemberList(@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain);
		Club club = clubService.findClubById(clubId);
		
		String clubName = club.getClubName();
		ClubLayout layout = clubService.findLayoutById(clubId);
		
		
		List<ClubMemberAndImage> clubMembers = clubService.findClubMembers(clubId);

		model.addAttribute("club", club);
		model.addAttribute("layout", layout);
		model.addAttribute("clubName", clubName);
		model.addAttribute("clubMembers", clubMembers);

		return "/club/clubMemberList";
	}

	@GetMapping("/clubsRecentVisited.do")
	public void clubsRecentVisited() {
	}

	/**
	 * @author ?
	 */
	@GetMapping("/{domain}/clubStyleUpdate.do")
	public String clubLayoutUpdate(@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain);
		String memberId = member.getMemberId();
		ClubLayout layout = clubService.findLayoutById(clubId);
		ClubMemberRole clubMemberRole = ClubMemberRole.builder().clubId(clubId).loginMemberId(memberId).build();

		// 로그인한 회원 아이디로 해당 모임의 권한 가져오기
		int memberRole = clubService.memberRoleFindByMemberId(clubMemberRole);
		model.addAttribute("memberRole", memberRole);

		model.addAttribute("layout", layout);
		model.addAttribute("domain", domain);
		return "club/clubStyleUpdate";
	}

	/**
	 * @author ?
	 */
	@PostMapping("/{domain}/clubStyleUpdate.do")
	public String clubLayoutUpdate(@PathVariable("domain") String domain, ClubStyleUpdateDto style) {

		int clubId = clubService.clubIdFindByDomain(domain);
		style.setClubId(clubId);
		int result = clubService.clubStyleUpdate(style);

		return "redirect:/club/" + domain;
	}

	/**
	 * @author ?
	 */
	@GetMapping("/{domain}/clubTitleUpdate.do")
	public String clubTitleUpdate(@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain);
		String memberId = member.getMemberId();
		ClubLayout layout = clubService.findLayoutById(clubId);
		ClubMemberRole clubMemberRole = ClubMemberRole.builder().clubId(clubId).loginMemberId(memberId).build();

		// 로그인한 회원 아이디로 해당 모임의 권한 가져오기
		int memberRole = clubService.memberRoleFindByMemberId(clubMemberRole);
		model.addAttribute("memberRole", memberRole);
		model.addAttribute("layout", layout);
		model.addAttribute("domain", domain);
		return "club/clubTitleUpdate";
	}

	/**
	 * @author 준한
	 */
	@PostMapping("/{domain}/clubTitleUpdate.do")
	public String clubTitleUpdate(@PathVariable("domain") String domain,
			@RequestParam(value = "upFile") MultipartFile fileTitle,
			@RequestParam(value = "upFile2") MultipartFile fileMain, @RequestParam String mainContent,
			ClubTitleUpdateDto clubTitleUpdateDto) throws IllegalStateException, IOException {
		int clubId = clubService.clubIdFindByDomain(domain);
		String uploadDirTitle = "/club/title/";
		String uploadDirMain = "/club/main/";
		ClubLayout clubLayout = null;
		if (!fileTitle.isEmpty()) {
			String originalFilename = fileTitle.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename);
			File destFile = new File(uploadDirTitle + renamedFilename);

			fileTitle.transferTo(destFile);

			clubLayout = clubLayout.builder().clubId(clubId).title(renamedFilename).build();

			int result = clubService.updateClubTitleImage(clubLayout);
		}
		if (!fileMain.isEmpty()) {
			String originalFilename = fileTitle.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename);
			File destFile = new File(uploadDirMain + renamedFilename);

			fileMain.transferTo(destFile);

			clubLayout = clubLayout.builder().clubId(clubId).mainImage(renamedFilename).build();

			int result = clubService.updateClubMainImage(clubLayout);
		}
		clubLayout = clubLayout.builder().clubId(clubId).mainContent(mainContent).build();
		int result = clubService.updateClubMainContent(clubLayout);
		return "redirect:/club/" + domain;
	}

	/**
	 * 게시글 삭제
	 * @author 상윤
	 */
	@PostMapping("/{domain}/delBoard.do")
	public ResponseEntity<?> delClubBoard(@RequestParam int boardId) {

		int result = clubService.delClubBoard(boardId);

		String msg = "게시글이 삭제되었습니다.";
		return ResponseEntity.status(HttpStatus.OK).body(msg);
	}

	/**
	 * 게시판 조회
	 * @author 상윤
	 */
	@GetMapping("/{domain}/searchClubBoard.do")
	public ResponseEntity<?> searchClubBoard(@PathVariable("domain") String domain,
			@RequestParam String searchKeywordVal, @RequestParam String searchTypeVal, @RequestParam int boardTypeVal,
			@RequestParam(defaultValue = "1") int page) {

		Club club = clubService.findByDomain(domain);

		int clubId = club.getClubId();

		Map<String, Object> searchBoardMap = Map.ofEntries(Map.entry("clubId", clubId),
				Map.entry("searchKeyword", searchKeywordVal), Map.entry("searchType", searchTypeVal),
				Map.entry("type", boardTypeVal));

		Map<String, Object> params = Map.of("page", page, "limit", LIMIT);

		List<ClubBoard> boards = clubService.searchBoards(searchBoardMap, params);

		List<ClubBoard> board = clubService.searchBoard(searchBoardMap);

		int boardSize = board.size();
		Map<String, Object> data = Map.ofEntries(Map.entry("boards", boards), Map.entry("boardSize", boardSize));
		return ResponseEntity.status(HttpStatus.OK).body(data);

	}

	/**
	 * @author 현우 모임 찜 목록
	 */
	@PostMapping("/clubLike.do")
	public String clubLike(@RequestParam String memberId, @RequestParam String domain, RedirectAttributes attr) {

		Club club = clubService.findByDomain(domain);
		int targetId = club.getClubId();
		Map<String, Object> params = Map.of("memberId", memberId, "targetId", targetId);

		int checkDuplicate = clubService.checkDuplicateClubLike(targetId);

		if (checkDuplicate == 0) {
			int result = clubService.clubLike(params);
		}
		return "redirect:/club/" + domain;
	}

	@PostMapping("/deleteClubLike.do")
	public String deleteClubLike(@RequestParam String memberId, @RequestParam String domain) {
		Club club = clubService.findByDomain(domain);
		int targetId = club.getClubId();

		Map<String, Object> params = Map.of("memberId", memberId, "targetId", targetId);

		int result = clubService.cancelClubLike(params);

		return "redirect:/club/" + domain;

	}

	/**
	 * 찜 목록에 모임이 있는지 확인 후 리턴
	 * @author 현우
	 */
	@GetMapping("/clubLikeCheck.do")
	public ResponseEntity<?> clubLikeCheck(@RequestParam String domain) {

		Club club = clubService.findByDomain(domain);
		int targetId = club.getClubId();

		int checkDuplicate = clubService.checkDuplicateClubLike(targetId);

		boolean clubLikeCheck = checkDuplicate != 0 ? true : false;

		return ResponseEntity.status(HttpStatus.OK).body(clubLikeCheck);
	}

	/**
	 * 갤러리 들어가기
	 * @author 준한
	 */
	@GetMapping("{domain}/clubGallery.do")
	public String clubGallery(@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails loginMember,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain);
		ClubLayout layout = clubService.findLayoutById(clubId);
		
		Club club = clubService.findByDomain(domain);
		String clubName =club.getClubName();
		
		List<ClubGalleryAndImage> clubGalleryAndImages = clubService.clubGalleryAndImageFindByClubId(clubId);
		log.debug("clubGalleryAndImages = {}", clubGalleryAndImages);

		model.addAttribute("clubGalleryAndImages", clubGalleryAndImages);
		model.addAttribute("clubName", clubName);

		return "/club/clubGallery";
	}

	/**
	 * 갤러리 상세보기
	 * @author 준한
	 */
	@GetMapping("/{domain}/{galleryId}")
	public String clubGalleryDetail(@PathVariable("galleryId") int id, @PathVariable("domain") String domain,
			@AuthenticationPrincipal MemberDetails loginMember, Model model) {

		List<GalleryAndImageDto> galleryAndImages = clubService.findGalleryAndImageByGalleryId(id);
		
		Club club = clubService.findByDomain(domain);
		ClubLayout layout = clubService.findLayoutById(club.getClubId());

		String writer = galleryAndImages.get(0).getMemberId();
		
		model.addAttribute("id", id);
		model.addAttribute("domain", domain);
		model.addAttribute("layout", layout);
		model.addAttribute("writer", writer); // 갤러리 게시글 작성자
		model.addAttribute("loginMember", loginMember); // 로그인 객체
		model.addAttribute("clubName", club.getClubName());
		model.addAttribute("galleryAndImages", galleryAndImages); // 갤러리 첨부파일 배열

		return "/club/clubGalleryDetail";
	}

	/**
	 * 갤러리 삭제
	 * @author 준한
	 */
	@GetMapping("/{domain}/{id}/clubGalleryDelete.do")
	public String clubGalleryDelete(@AuthenticationPrincipal MemberDetails loginMember, Model model,
			@PathVariable("id") int id, @PathVariable("domain") String domain) {
		
		int result = clubService.clubGalleryDelete(id);

		return "redirect:/club/" + domain + "/clubGallery.do";
	}

	/**
	 * 
	 * @author ?
	 */
	@GetMapping("/{domain}/clubGalleryInsert.do")
	public String clubGalleryInsert(@AuthenticationPrincipal MemberDetails loginMember, Model model,
			@PathVariable("domain") String domain) {
		int clubId = clubService.clubIdFindByDomain(domain);

		model.addAttribute("clubId", clubId);
		model.addAttribute("domain", domain);
		model.addAttribute("loginMember", loginMember);

		return "club/clubGalleryInsert";
	}

	@PostMapping("{domain}/clubGalleryInsert.do")
	public String clubGalleryCreate(@AuthenticationPrincipal MemberDetails loginMember,
			@PathVariable("domain") String domain, @RequestParam(value = "upFile") List<MultipartFile> upFiles)
			throws IllegalStateException, IOException {

		String uploadDir = "/club/gallery/";
		List<ClubGalleryAttachment> attachments = new ArrayList<>();
		if (!upFiles.isEmpty()) {
			attachments = insertAttachments(upFiles, attachments);
			int clubId = clubService.clubIdFindByDomain(domain);
			ClubGalleryDetails clubGallery = ClubGalleryDetails.builder().clubId(clubId)
					.memberId(loginMember.getMemberId()).attachments(attachments).build();

			int result = clubService.postGallery(clubGallery);

		}

		return "redirect:/club/" + domain;
	}

	public List<ClubGalleryAttachment> insertAttachments(List<MultipartFile> upFiles,
			List<ClubGalleryAttachment> attachments) throws IllegalStateException, IOException {
		for (int i = 0; i < upFiles.size(); i++) {
			if (!upFiles.get(i).isEmpty()) {
				String originalFilename = upFiles.get(i).getOriginalFilename();
				String renamedFilename = DagachiUtils.getRenameFilename(originalFilename);
				File destFile = new File("/club/gallery/" + renamedFilename);
				upFiles.get(i).transferTo(destFile); // 실제 파일 저장

				ClubGalleryAttachment attach = ClubGalleryAttachment.builder().originalFilename(originalFilename)
						.renamedFilename(renamedFilename).build();
				if (i == 0)
					attach.setThumbnail(Status.Y);
				else
					attach.setThumbnail(Status.N);

				attachments.add(attach);
			}
		}
		return attachments;
	}

	@GetMapping("{domain}/clubManage.do")
	public String clubManage(@PathVariable("domain") String domain, @AuthenticationPrincipal MemberDetails member,
			Model model) {
		return "/club/clubManage";
	}

	@GetMapping("/{domain}/memberClubDetail.do")
	public String memberClubDetail(@PathVariable("domain") String domain, Model model) {

		model.addAttribute("domain", domain);
		return "/club/memberClubDetail";
	}

	@PostMapping("/{domain}/clubMemberDelete.do")
	public String clubMemberDelete(@PathVariable("domain") String domain,
			@AuthenticationPrincipal MemberDetails loginMember, Model model) {

		String memberId = loginMember.getMemberId();
		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();

		Map<String, Object> params = Map.of("memberId", memberId, "clubId", clubId);
		ClubMember clubMember = clubService.findClubMemberRoleByClubId(params);
		int clubMemberRole = clubMember.getClubMemberRole();

		if (clubMemberRole == 3) {
			String clubAdminMsg = "방장은 모임에서 탈퇴할 수 없습니다.";
			model.addAttribute("clubAdminMsg", clubAdminMsg);

			// 해당 세션을 삭제
			httpSession.removeAttribute(clubAdminMsg);

			return "redirect:/club/" + domain + "/memberClubDetail.do";

		}
		int result = clubService.clubMemberDelete(params);

		return "redirect:/club/" + domain;
	}
}
