package com.dagachi.app.chat.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.dagachi.app.chat.dto.ChatDetail;
import com.dagachi.app.chat.dto.ChatListDetail;
import com.dagachi.app.chat.dto.ClubInfo;
import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.chat.entity.ChatLogDetail;
import com.dagachi.app.ws.dto.Payload;


@Mapper
public interface ChatRepository {

	@Select("select * from (select * from chat_log where club_id=#{clubId} order by id desc) where rownum = 1")
	ChatLogDetail findByRecentChat(int clubId);

	@Select("select * from chat_log where club_id=#{no} order by id")
	List<ChatLogDetail> clubChat(int no);
	
	@Insert("insert into chat_log values(seq_chat_log_id.nextval,#{clubId},#{writer},#{content},default )")
	int sendClubChat(ChatLog chatlog);

	@Select("select nickname from member where member_id = #{writer}")
	String getNicknameById(String writer);
	
	ChatListDetail findByRecentChatDetail(int clubId);

	ClubInfo findByClubInfo(int clubId);

	List<ChatDetail> findClubChat(int no);


}
