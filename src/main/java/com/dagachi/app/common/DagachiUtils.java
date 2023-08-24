package com.dagachi.app.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class DagachiUtils {
	
	/**
	 * 카카오지도
	 * @author ssusss
	 */
	public static JsonArray kakaoMapApi(String keyword, String searchType) throws UnsupportedEncodingException {
		String apiKey = "0b08c9c74b754bc22377c45ec5ce2736";
		String query = keyword; // 검색할 행정동 정보
		
//		System.out.println("query" + query);
	    String encodedQuery = URLEncoder.encode(query, "UTF-8");
//	    System.out.println("encodedQuery" + encodedQuery);
	    String url = "https://dapi.kakao.com/v2/local/search/" 
	    		+ searchType + ".json?query=" + encodedQuery;

	    if("coord2regioncode".equals(searchType)) {
	    	url = url.replace("search", "geo");
	    }
//	    System.out.println("searchType" + searchType);
//	    System.out.println("url" + url);
	    JsonObject data = null;
	    JsonArray documents;
		try {
			data = fetchJsonData(url, apiKey);
		} catch (Exception e) {
			// TODO Auto-generated catch block
		}
		documents = data.getAsJsonArray("documents");
		
		return documents;
	}
 	
	

	/**
	 * 카카도 지도
	 * @author ssusss
	 */
	public static JsonObject fetchJsonData(String url, String apiKey) throws Exception {
        URL requestUrl = new URL(url);
        HttpURLConnection connection = (HttpURLConnection) requestUrl.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization", "KakaoAK " + apiKey);
        int responseCode = connection.getResponseCode();

        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        return new Gson().fromJson(response.toString(), JsonObject.class);
	}
	
	
	/**
	 * yyyyMMdd_HHmmssSSS_123.png
	 * 
	 * @param originalFilename
	 * @return
	 */
	public static String getRenameFilename(String originalFilename) {
		// 확장자 
		String ext = "";
		int dotIndex = originalFilename.lastIndexOf(".");
		if(dotIndex > -1)
			ext = originalFilename.substring(dotIndex); // .jpg
		
		// 형식객체
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000"); 
		return sdf.format(new Date()) + df.format(Math.random() * 1000) + ext;
	}
	
	
	public static Set<String> getAreaNamesByDistance(double x, double y, int distance, Map<Integer, Double> anglePattern) 
			throws UnsupportedEncodingException {
		Set<String> zoneSet = new HashSet<>();
		// 내부for문 반복 횟수
		// anglePattern과 distance를 통해 반복문 생성
		
		// i는 km, j는 km마다 반복할 수(360/n)
		for (int i = 1; i <= distance; i++) {
			double angle = anglePattern.get(i);
			int repeatCnt = (int) (360 / angle);
			
			for (int j = 0; j < repeatCnt; j++) {
				// sin, cos 계산
				double _x = x + (i * 0.009) * (Math.cos(angle * j) == 0 ? 1 : Math.cos(angle * j));
				double _y = y + (i * 0.009) * (Math.sin(angle * j) == 0 ? 1 : Math.sin(angle * j));
				
				// 위에서 구한 좌표로 api에 요청하여 법정동명 구하기
				String xAndY = "x=" + _x + "&y=" + _y;
				
				RestTemplate restTemplate = new RestTemplate(); // 타서버로의 요청객체
		        // 요청 header, 사용자입력값
		        HttpHeaders httpHeaders = new HttpHeaders();
		        httpHeaders.add(HttpHeaders.AUTHORIZATION, "KakaoAK " + "0b08c9c74b754bc22377c45ec5ce2736");
		        HttpEntity<HttpHeaders> httpEntity = new HttpEntity<>(httpHeaders);
		        
		        String uri = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?" + xAndY;
		        ResponseEntity<?> responseEntity = 
                restTemplate.exchange(URI.create(uri), HttpMethod.GET, httpEntity, Map.class);

		        Map<String, Object> responseBody = (Map<String, Object>) responseEntity.getBody(); // API 응답 본문
		        ObjectMapper objectMapper = new ObjectMapper();
		        try {
		            // JSON 응답을 Jackson의 JsonNode로 파싱
		            JsonNode responseJson = objectMapper.valueToTree(responseBody);

		            // documents 배열의 첫 번째 객체를 가져옴
		            JsonNode firstDocument = responseJson.path("documents").get(0);

		            // region_3depth_name 값을 가져옴
		            String state = firstDocument.path("region_1depth_name").asText(); // 시|군|구
		            if(!"서울특별시".equals(state)) {
		            	continue;
		            }
		            String zone = firstDocument.path("region_3depth_name").asText(); // 동
		            // 위에서 구한 법정동 명을 set에 삽입(중복허용x)
		            zoneSet.add(zone);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        
			}
		}
		return zoneSet;
	}
	
}
