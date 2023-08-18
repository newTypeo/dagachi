package com.dagachi.app.club.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.service.ClubService;

@SpringBootTest
class ClubControllerTest {

	@Autowired
	private ClubService clubService;
	@Test
	void test() {
		assertThat(clubService).isNotNull();
	}

	
	@DisplayName("소모임 한개찾기")
	@ParameterizedTest
	@ValueSource(strings = {"sportsclub.com","artisticcreations.com"})
	void findByDomain(String domain) {
		assertThat(domain).isNotNull();
		
		Club club= clubService.findByDomain(domain);
		
		assertThat(club).isNotNull();
		assertThat(club.getDomain()).isEqualTo(domain);
		
	}
	
	@DisplayName("보드 타입 조회")
	@ParameterizedTest
	@ValueSource(longs = {1,2,3,4} )
	void boardList(Long type) {
		
		String domain="sportsclub.com";
		Club club= clubService.findByDomain(domain);
		int clubId=club.getClubId();
		
		int _type = (type != null) ? type.intValue() : 0;
		
		ClubBoard clubBoard=ClubBoard.builder()
				.clubId(clubId)
				.type(_type)
				.build();
				
		
		List<ClubBoard> boards= clubService.boardList(clubBoard);
		
		assertThat(boards).isNotNull();
		assertThat(boards).allSatisfy((board)->{
			assertThat(board.getBoardId()).isNotEqualTo(0);
			assertThat(board.getClubId()).isNotNull();
			assertThat(board.getType()).isNotNull();
			assertThat(board.getWriter()).isNotNull();
		});
		
	}
	

	@DisplayName("보드 아이디 조회")
	@ParameterizedTest
	@ValueSource(longs = {1,2,3,4})
	void boardDetail(Long _boardId) {
		
		String domain="sportsclub.com";
		Club club= clubService.findByDomain(domain);
		int clubId=club.getClubId();
		
		int boardId = (_boardId != null) ? _boardId.intValue() : 0;
		
		ClubBoard _clubBoard=ClubBoard.builder()
				.clubId(clubId)
				.boardId(boardId)
				.build();
		
		
		ClubBoard clubBoard=clubService.findByBoard(_clubBoard);
		
		assertThat(clubBoard).isNotNull();
		
		
	}
	
	
}
