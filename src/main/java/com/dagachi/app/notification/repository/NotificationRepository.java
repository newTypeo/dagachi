package com.dagachi.app.notification.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.dagachi.app.notification.entity.Alarm;


@Mapper
public interface NotificationRepository {

	@Insert("insert into alarm (id, receiver, sender, content, type) values(seq_alarm_id.nextval,#{receiver},#{sender},#{content},#{type})")
	int insertChatAlarm(Alarm alarm);

	@Select("select * from alarm where receiver = #{recevier} and is_read = 'N'")
	List<Alarm> findAlarms(String receiver);
	
	@Update("update alarm set is_read ='Y' where receiver =#{receiver}")
	int checkedAlarm(String receiver);


}
