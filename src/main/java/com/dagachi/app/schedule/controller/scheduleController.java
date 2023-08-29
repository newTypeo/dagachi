package com.dagachi.app.schedule.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.schedule.service.scheduleService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/schedule")
public class scheduleController {

	@Autowired
	private ClubService clubService;
	
	@Autowired
	private scheduleService scheduleService;
	
	@GetMapping("/{domain}/getSchedules.do")
	@ResponseBody
	public ResponseEntity<?> getSchedule(@PathVariable("domain") String domain) {
		int clubId = clubService.clubIdFindByDomain(domain);
		
		List<ClubSchedule> clubSchedules = scheduleService.findSchedulesByClubId(clubId);
		System.out.println(clubSchedules);
		
		
		return ResponseEntity.status(HttpStatus.OK).body(clubSchedules);
	}
}
