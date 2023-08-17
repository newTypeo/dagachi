package com.dagachi.app.club.service;

import java.util.List;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.entity.Club;

public interface ClubService {

	List<Club> clubSearch(String keyword, String column);

	List<Club> adminClubList();

	List<ClubAndImage> clubList();

}
