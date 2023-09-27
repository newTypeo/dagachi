package com.dagachi.app.schedule.controller;

import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dagachi.app.club.dto.ClubScheduleAndMemberDto;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.club.entity.ClubScheduleEnrollMember;
import com.dagachi.app.club.entity.ClubSchedulePlace;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.common.DagachiUtils;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.schedule.dto.ScheduleCreateDto;
import com.dagachi.app.schedule.dto.ScheduleDetailsDto;
import com.dagachi.app.schedule.entity.ClubSchedulePlaceDetail;
import com.dagachi.app.schedule.service.ScheduleService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/club/{domain}")
public class ScheduleController {

	@Autowired
	private ClubService clubService;
	
	@Autowired
	private ScheduleService scheduleService;
	
	@GetMapping("/getSchedules.do")
	@ResponseBody
	public ResponseEntity<?> getSchedule(@PathVariable("domain") String domain) {
		List<ClubScheduleAndMemberDto> clubSchedules = scheduleService.findSchedulesByDomain(domain);
		System.out.println(clubSchedules);
		return ResponseEntity.status(HttpStatus.OK).body(clubSchedules);
	}
	
	@GetMapping("/scheduleDetail.do")
	public String scheduleDetail(
			@PathVariable("domain") String domain, 
			@RequestParam int no,
			@AuthenticationPrincipal MemberDetails member,
			Model model) throws UnsupportedEncodingException {
		
		ScheduleDetailsDto schedule = scheduleService.findscheduleById(no);
		Club club = clubService.findByDomain(domain);
		ClubLayout layout = clubService.findLayoutById(club.getClubId());
		Map<String, Object> mIdAndcId = Map.of(
				"memberId", schedule.getWriter(), 
				"clubId", club.getClubId());
		ClubMember clubMember = scheduleService.getWriterInfo(mIdAndcId);
		
		for (ClubSchedulePlaceDetail place : schedule.getPlaces()) {
			double[] coordinate = DagachiUtils.getPlaceCoordinate(place.getAddress());
			place.setXCo(coordinate[0]);
			place.setYCo(coordinate[1]);
		}
		
		double[] myHome = DagachiUtils.getPlaceCoordinate(member.getAddress());
		
		boolean isEnrolled = false;
		for (ClubScheduleEnrollMember enrollMember : schedule.getEnrollMembers()) {
			if (enrollMember.getMemberId().equals(member.getMemberId())) {;
				isEnrolled = true;
			}
		}
		
		mIdAndcId = Map.of("myId", member.getMemberId(), "clubId", club.getClubId());
		int myRole = scheduleService.getMyRole(mIdAndcId);
		
		// 하나로 묶기
		model.addAttribute("myRole", myRole);
		model.addAttribute("myAddress", member.getAddress());
		model.addAttribute("myHome", myHome);
		model.addAttribute("isEnrolled", isEnrolled);
		model.addAttribute("clubName", club.getClubName());
		model.addAttribute("layout", layout);
		model.addAttribute("clubMember", clubMember);
		
		model.addAttribute("schedule", schedule);
		
		return "club/schedule/scheduleDetail";
	}
	
	@PostMapping("/scheduleEnroll.do")
	public String scheduleEnroll(
			@PathVariable("domain") String domain, 
			@RequestParam int no,
			RedirectAttributes redirectAttr,
			@AuthenticationPrincipal MemberDetails member) {
		int clubId = clubService.clubIdFindByDomain(domain);
		
		ClubScheduleEnrollMember memberInfo = ClubScheduleEnrollMember.builder()
				.clubId(clubId)
				.memberId(member.getMemberId())
				.scheduleId(no).build();

		int result = scheduleService.insertEnrollMember(memberInfo);
		redirectAttr.addFlashAttribute("msg", "😀성공적으로 일정에 신청되었습니다.");
		
		return "redirect:/club/{domain}/scheduleDetail.do?no=" + no;
	};
	
	@PostMapping("/scheduleEnrollCancle.do")
	public String scheduleEnrollCancle(
			@PathVariable("domain") String domain, 
			@RequestParam int no,
			RedirectAttributes redirectAttr,
			@AuthenticationPrincipal MemberDetails member) {
		int clubId = clubService.clubIdFindByDomain(domain);
		
		ClubScheduleEnrollMember memberInfo = ClubScheduleEnrollMember.builder()
				.clubId(clubId)
				.memberId(member.getMemberId())
				.scheduleId(no).build();

		int result = scheduleService.deleteEnrollMember(memberInfo);
		redirectAttr.addFlashAttribute("msg", "😥참여를 취소하였습니다.");
		
		return "redirect:/club/"+domain+"/scheduleDetail.do?no=" + no;
	};
	
	@GetMapping("/clubSchedule.do")
	public String clubSchedule(@PathVariable("domain") String domain, Model model) {
		
		Club club = clubService.findByDomain(domain);
		ClubLayout layout = clubService.findLayoutById(club.getClubId());
		
		
		model.addAttribute("clubName", club.getClubName());
		model.addAttribute("layout", layout);
		return "/club/schedule/scheduleList";
	}
	
	@GetMapping("/scheduleCreate.do")
	public String clubScheduleCreate(@PathVariable("domain") String domain, Model model) {
		Club club = clubService.findByDomain(domain);
		ClubLayout layout = clubService.findLayoutById(club.getClubId());
		
		
		model.addAttribute("clubName", club.getClubName());
		model.addAttribute("layout", layout);
		return "/club/schedule/scheduleCreate";
	}
	
	@PostMapping("/scheduleCreate.do")
	public String insertClubSchedule(
			@PathVariable("domain") String domain,
			@AuthenticationPrincipal MemberDetails member,
			ScheduleCreateDto scheduleCreateDto,
			@RequestParam String placesArr,
			@RequestParam String placesStartTimeArr
			) {
		Club club = clubService.findByDomain(domain);
		int clubId = club.getClubId();
		ClubLayout layout = clubService.findLayoutById(clubId);
		scheduleCreateDto.setClubId(clubId);
		scheduleCreateDto.setWriter(member.getMemberId());
		
		String[] placesArr_ = placesArr.split(",");
		String[] placesStartTimeArr_ = placesStartTimeArr.split(",");
		int leng = placesArr_.length;
		int loop = leng / 4;
		List<ClubSchedulePlace> places = new ArrayList<>();
		for (int i = 0; i < loop; i++) {
			ClubSchedulePlace place = 
				new ClubSchedulePlace(0, 0, 
					placesArr_[loop + i], 
					placesArr_[2*loop + i],
					placesArr_[3*loop + i],
					Integer.parseInt(placesArr_[i]), 
					stringToLDTime(placesStartTimeArr_[i])
			);
			places.add(place);
		};
		scheduleCreateDto.setPlaces(places);
		
		int result = scheduleService.insertSchedule(scheduleCreateDto);
		
		
		return "redirect:/club/"+domain+"/clubSchedule.do";
	}
	
	public LocalDateTime stringToLDTime(String dateTimeStr) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime localDateTime = LocalDateTime.parse(dateTimeStr, formatter);
		return localDateTime;
	}
	
	@PostMapping("/scheduleRemove.do")
	public String scheduleRemove (
		@PathVariable("domain") String domain,
		@RequestParam int no,
		RedirectAttributes redirectAttr
		) {
		
		int result = scheduleService.updateScheduleStatus(no);
		
		redirectAttr.addFlashAttribute("msg", "일정을 취소했습니다.");
		
		return "redirect:/club/"+domain+"/clubSchedule.do";
	}
}
