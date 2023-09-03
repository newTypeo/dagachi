package com.dagachi.app.notification.service;

import java.util.List;

import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.notification.entity.Alarm;

public interface NotificationService {

	int sendChatalarm(ChatLog chatlog);

	List<Alarm> findAlarms(String receiver);

	int checkedAlarm(String receiver);

	int membershipRequest(Club club, MemberDetails member, JoinClubMember master);

	int permitApply(Club club, String memberId, JoinClubMember master);

	int refuseApply(Club club, String memberId, JoinClubMember master);
 
	
	
}
