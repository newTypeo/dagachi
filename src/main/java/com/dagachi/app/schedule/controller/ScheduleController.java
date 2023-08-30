package com.dagachi.app.schedule.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.schedule.dto.ScheduleAndWriterProfileDto;
import com.dagachi.app.schedule.dto.ScheduleDetailsDto;
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
		int clubId = clubService.clubIdFindByDomain(domain);
		
		List<ClubSchedule> clubSchedules = scheduleService.findSchedulesByClubId(clubId);
		
		return ResponseEntity.status(HttpStatus.OK).body(clubSchedules);
	}
	
	@GetMapping("/scheduleDetail.do")
	public String scheduleDetail(
			@PathVariable("domain") String domain, 
			@RequestParam int no,
			@AuthenticationPrincipal MemberDetails member,
			Model model) {
		
		// ScheduleDetailsDto scheduleDetails = scheduleService.findScheduleDetailById(no);
		ScheduleAndWriterProfileDto schedule = scheduleService.findscheduleById(no);
		Club club = clubService.findByDomain(domain);
		ClubLayout layout = clubService.findLayoutById(club.getClubId());
		Map<String, Object> mIdAndcId = Map.of(
				"memberId", schedule.getWriter(), 
				"clubId", club.getClubId());
		ClubMember clubMember = scheduleService.getWriterInfo(mIdAndcId); 
		
		System.out.println(member);
		
		
		model.addAttribute("clubName", club.getClubName());
		model.addAttribute("schedule", schedule);
		model.addAttribute("clubMember", clubMember);
		model.addAttribute("layout", layout);
		
		return "club/schedule/scheduleDetail";
	}
}
