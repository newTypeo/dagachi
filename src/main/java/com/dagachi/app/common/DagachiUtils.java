package com.dagachi.app.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class DagachiUtils {
	
	public static JsonArray kakaoMapApi(String keyword, String SearchType) throws UnsupportedEncodingException {
		String apiKey = "0b08c9c74b754bc22377c45ec5ce2736";
		String query = keyword; // 검색할 행정동 정보

	    String encodedQuery = URLEncoder.encode(query, "UTF-8");
	    String url = "https://dapi.kakao.com/v2/local/search/" 
	    		+ SearchType + ".json?query=" + encodedQuery;

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
}
