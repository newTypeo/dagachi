package com.dagachi.app.chat.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.ws.dto.Payload;


@Mapper
public interface ChatRepository {

	@Select("select * from (select * from chat_log where club_id=#{clubId} order by id desc) where rownum = 1")
	ChatLog findByRecentChat(int clubId);

	@Select("select * from chat_log where club_id=#{no} order by id")
	List<ChatLog> clubChat(int no);
	
	@Insert("insert into chat_log values(seq_chat_log_id.nextval,#{clubId},#{writer},#{content},default )")
	int sendClubChat(ChatLog chatlog);


}
