package com.dagachi.app.club.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.dagachi.app.club.entity.Club;


@Mapper
public interface ClubRepository {

	@Select("select * from club where club_name like '%' || #{keyword} || '%'")
	List<Club> clubSearch(String keyword);

	@Select("select * from club where status = 'Y' order by club_id desc")
	List<Club> adminClubList();

	
	
	
}
