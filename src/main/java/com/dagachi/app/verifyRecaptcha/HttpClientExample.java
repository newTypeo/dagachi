package com.dagachi.app.verifyRecaptcha;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpClientExample {
    public static void main(String[] args) {
        try {
            // 요청 URL 설정
            String apiUrl = "https://openapi.naver.com/v1/captcha/nkey?code=0";
            URL url = new URL(apiUrl);

            // HttpURLConnection 객체 생성
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // 요청 메서드 설정 (GET)
            connection.setRequestMethod("GET");

            // 요청 헤더 설정
            connection.setRequestProperty("Host", "openapi.naver.com");
            connection.setRequestProperty("User-Agent", "curl/7.49.1");
            connection.setRequestProperty("Accept", "*/*");
            connection.setRequestProperty("X-Naver-Client-Id", "0wG5pueTc9c2POZTKsqD");
            connection.setRequestProperty("X-Naver-Client-Secret", "jEvGfzL_xq");

            // 응답 코드 확인 (200 OK이면 정상 응답)
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // 응답 데이터 읽기
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuffer response = new StringBuffer();

                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();

                // 응답 출력
                System.out.println("Response: " + response.toString());
            } else {
                // 오류 처리
                System.out.println("HTTP Request Failed with error code: " + responseCode);
            }
        } catch (Exception e) {
            // 예외 처리
            e.printStackTrace();
        }
    }
}