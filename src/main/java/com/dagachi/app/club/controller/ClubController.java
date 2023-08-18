package com.dagachi.app.club.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.Member;

import lombok.Builder.Default;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/club")
@Slf4j
@SessionAttributes
public class ClubController {
	
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
	
//	@PostMapping("/clubBoardCreate.do")
//	public String boardCreate1(
//			
//	) {
//		
//		return " ";
//	}
	
	/**
	 * 관리자 회원 목록에서 모임 검색
	 * @author 종환
	 */
	@GetMapping("/adminClubSearch.do")
	public ResponseEntity<?> adminClubSearch(@RequestParam String keyword, @RequestParam String column) {
		log.debug("keyword = {}", keyword);
		log.debug("column = {}", column);
		List<Club> clubs = new ArrayList<>();
		if(keyword == "") {
			clubs = clubService.adminClubList();
		}
		else {
			clubs = clubService.adminClubSearch(keyword, column);
		}
		// log.debug("clubs = {}", clubs);
		return ResponseEntity.status(HttpStatus.OK).body(clubs);
	}
	
	/**
	 * 메인화면에서 모임 검색
	 * @author 종환
	 */
	@GetMapping("/clubSearch.do")
	public void clubSearch(@RequestParam String inputText) {
		// log.debug("inputText = {}", inputText);
		List<Club> clubs = clubService.clubSearch(inputText);
		log.debug("clubs = {}", clubs);
		// 8/17 여기서 마무리 했음.
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
	 */
	@GetMapping("/&{domain}")
	public String clubDetail(
			@PathVariable("domain") String domain,
			Model model) {
//		log.debug("domain = {}", domain);
		
		model.addAttribute("domain", domain);
		return "club/clubDetail";
	}
	
	/**
	 * 메인에서 소모임 전체 조회(카드로 출력)
	 * @author 준한
	 */
	@GetMapping("/clubList.do")
	public ResponseEntity<?> clubList(){
		List<ClubAndImage> clubAndImages = new ArrayList<>();
		clubAndImages = clubService.clubList();
		return ResponseEntity.status(HttpStatus.OK).body(clubAndImages);
	}
	
	
	@GetMapping("/&{domain}/manageMember.do")
	public void manageMemeber(
			@PathVariable("domain") String domain,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain); // 해당 클럽의 아이디(pk) 가져오기
		List<ClubApply> clubApplies = clubService.clubApplyfindByClubId(clubId); // 해당 소모임에 가입 신청한 회원들 조회해서
		
		log.debug("clubId = {}", clubId);
		log.debug("clubApplies = {}", clubApplies);
		
		List<Member> members = new ArrayList<>(); // 해당 소모임에 신청한 회원들의 
		String memberId = "";
		
		// 조회된 회원 한명당 아이디를 가져와서 회원테이블에서 조회후 members배열에 담음
		for(int i=0; i<clubApplies.size(); i++) {
			memberId = clubApplies.get(i).getMemberId();
//			members
//			members.add();
		}
//		List<Member> members = clubService.findById(id);
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
	
//	@PostMapping("/{domain}/boardUpdate.do")
//	public String boardUpdate(
//			@PathVariable("domain") String domain,
//			@RequestParam int no,
//			@RequestParam String title,
//			@RequestParam int boardType,
//			@RequestParam String content
//			
//	) {
//		ClubBoard board= clubBoardGet(domain, no);
//		
//			board=ClubBoard.builder()
//					.title(title)
//					.type(boardType)
//					.content(content)
//					.build();
//		
//		int result=clubService.updateBoard(board);
//		
//		
//		return "/club/clubBoardDetail";
//	}
	
	
	
	
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
