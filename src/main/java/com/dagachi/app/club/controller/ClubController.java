package com.dagachi.app.club.controller;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.common.DagachiUtils;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/club")
@Slf4j
public class ClubController {
	
	@Autowired
	private ClubService clubService;
	
	@GetMapping("/main.do")
	public void Detail() {
	}
	
	
	@GetMapping("/clubBoardList.do")
	public void boardList() {
	}
	
	@GetMapping("/clubBoardCreate.do")
	public void boardCreate() {
		
	}
	
//	@PostMapping("/clubBoardCreate.do")
//	public String boardCreate1(
//			
//	) {
//		
//		return " ";
//	}
	
	/**
	 * 관리자 회원 목록에서 모임 검색
	 * @author 종환
	 */
	@GetMapping("/clubSearch.do")
	public ResponseEntity<?> clubSearch(@RequestParam String keyword) {
		List<Club> clubs = new ArrayList<>();
		if(keyword == "") {
			clubs = clubService.adminClubList();
		}
		else {
			clubs = clubService.clubSearch(keyword);
		}
		// log.debug("clubs = {}", clubs);
		return ResponseEntity.status(HttpStatus.OK).body(clubs);
	}
	
	@GetMapping("/chatList.do")
	public void chatList() {
		
	}
	
	@GetMapping("/chatRoom.do")
	public void chatRoom() {
		
	}
	
	/**
	 * 메인에서 소모임 전체 조회(카드로 출력)
	 * @author 준한
	 */
	@GetMapping("/clubList.do")
	public ResponseEntity<?> clubList(){
		List<ClubAndImage> clubAndImages = new ArrayList<>();
		clubAndImages = clubService.clubList();
		return ResponseEntity.status(HttpStatus.OK).body(clubAndImages);
	}
	
	
	@GetMapping("/clubCreate.do")
	public void clubCreate() throws Exception {
		
    }
	
	@GetMapping("/findAddress.do")
	public ResponseEntity<?> findAddress(String keyword) throws UnsupportedEncodingException {
		
		if (keyword == null || keyword == "") return null;
		String SearchType = "address";
		
		JsonArray documents = DagachiUtils.kakaoMapApi(keyword, SearchType);

        Gson gson = new Gson();

        List<String> addressList = new ArrayList<>();
        for (JsonElement document : documents) {
            JsonObject item = document.getAsJsonObject();
            String addressName = item.get("address_name").getAsString();
            addressList.add(addressName);
        }
        return ResponseEntity.status(HttpStatus.OK).body(addressList);
	}

    
	
	
}
