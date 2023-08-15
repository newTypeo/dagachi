package com.dagachi.app.club.service;

import java.util.List;

import com.dagachi.app.club.entity.Club;

public interface ClubService {

	List<Club> clubSearch(String keyword);

	List<Club> adminClubList();

}
