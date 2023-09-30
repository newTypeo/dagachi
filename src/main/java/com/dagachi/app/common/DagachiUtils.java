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
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class DagachiUtils {
	
	/**
	 * 카카오지도
	 * @author 동찬
	 */
	public static JsonArray kakaoMapApi(String keyword, String searchType) throws UnsupportedEncodingException {
		String apiKey = "0b08c9c74b754bc22377c45ec5ce2736";
		String query = keyword; // 검색할 행정동 정보
	    String encodedQuery = URLEncoder.encode(query, "UTF-8");
	    String url = "https://dapi.kakao.com/v2/local/search/" 
	    		+ searchType + ".json?query=" + encodedQuery;

	    if("coord2regioncode".equals(searchType)) {
	    	url = url.replace("search", "geo");
	    }
	    JsonObject data = null;
	    JsonArray documents;
		try {
			data = fetchJsonData(url, apiKey);
		} catch (Exception e) {}
		
		documents = data.getAsJsonArray("documents");
		
		return documents;
	}
 	
	

	/**
	 * 카카오 지도
	 * @author 동찬
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
	 * @author ?	
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
	
	
	/**
	 * 사용자가 입력한 km로 주변 반경 법정동명 찾는 알고리즘
	 * @author 종환
	 */
	public static Set<String> getAreaNamesByDistance(double x, double y, int distance, Map<Integer, Double> anglePattern) 
			throws UnsupportedEncodingException {
		Set<String> zoneSet = new HashSet<>();
		// [내부for문 반복 횟수]
		// - anglePattern과 distance를 통해 반복문 생성
		
//		static final Map<Integer, Double> ANGLEPATTERN // km(key)별로 360도를 나눌 각도(value)
//		= Map.of(1, 45.0, 2, 30.0, 3, 22.5, 4, 18.0, 5, 15.0, 6, 11.25, 7, 9.0);
		
		// i는 km, j는 km마다 반복할 수(360/n)
		for (int km = 1; km <= distance; km++) {
			double angle = anglePattern.get(km); // km가 4면 angle = 18이 되고 360 / 18 해서 내부 for문의 반복 수는 20번이 된다.
			int repeatCnt = (int) (360 / angle);
			
			for (int loop = 0; loop < repeatCnt; loop++) {
				// sin, cos 계산 (0.009는 좌표상 대략 1km를 의미)
				double _x = x + (km * 0.009) * (Math.cos(angle * loop) == 0 ? 1 : Math.cos(angle * loop));
				double _y = y + (km * 0.009) * (Math.sin(angle * loop) == 0 ? 1 : Math.sin(angle * loop));
				
				// 위에서 구한 좌표로 api에 요청하여 법정동명 구하기
				String xAndY = "x=" + _x + "&y=" + _y;
				
				RestTemplate restTemplate = new RestTemplate(); // 타서버로의 요청객체
		        // 요청 header, 사용자입력값
		        HttpHeaders httpHeaders = new HttpHeaders();
		        httpHeaders.add(HttpHeaders.AUTHORIZATION, "KakaoAK " + "0b08c9c74b754bc22377c45ec5ce2736");
		        HttpEntity<HttpHeaders> httpEntity = new HttpEntity<>(httpHeaders);
		        
		        			// 계산한 x,y 좌표값으로 법정동 얻기위한 요청 
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
		            if(!"서울특별시".equals(state)) { // 경기도는 pass
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
	
	
	public static double[] getPlaceCoordinate(String address) throws UnsupportedEncodingException {
		JsonArray document = kakaoMapApi(address, "address");
		JsonObject item = document.get(0).getAsJsonObject();
		double xCo = Double.parseDouble(item.get("x").getAsString());
		double yCo = Double.parseDouble(item.get("y").getAsString());
		double[] coordinate = {xCo, yCo};
		return coordinate; 
	}
	
}
