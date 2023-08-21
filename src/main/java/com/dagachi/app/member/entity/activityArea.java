package com.dagachi.app.member.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data // 활동 지역
public class activityArea {
	
	private String memberId; // 멤버아이디
	private String main_area_id; //주 활동지역
	private String sub1_area_id; //서브지역
	private String sub2_area_id; //서브지역
	

}
