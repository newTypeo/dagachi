package com.dagachi.app.notification.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.dagachi.app.notification.entity.Alarm;
import com.dagachi.app.ws.dto.Payload;


@Mapper
public interface NotificationRepository {

	@Insert("insert into alarm (id, receiver, sender, content, type) values(seq_alarm_id.nextval,#{receiver},#{sender},#{content},#{type})")
	int insertChatAlarm(Alarm alarm);


}
