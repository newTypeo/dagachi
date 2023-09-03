package com.dagachi.app.verifyRecaptcha;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;



public class NaverOpenApiExample {
    public static void main(String[] args) {
        try {
            // 요청 URL 설정
            String apiUrl = "https://openapi.naver.com/v1/captcha/nkey?code=0";

            // 클라이언트 ID와 클라이언트 시크릿 설정
            String clientId = "jEvGfzL_xq";
            String clientSecret = "0wG5pueTc9c2POZTKsqD";

            // HttpClient 생성
            HttpClient httpClient = HttpClients.createDefault();

            // HTTP GET 요청 생성
            HttpGet httpGet = new HttpGet(apiUrl);

            // HTTP 요청 헤더 설정
            httpGet.addHeader("X-Naver-Client-Id", clientId);
            httpGet.addHeader("X-Naver-Client-Secret", clientSecret);

            // HTTP 요청 실행
            HttpResponse response = httpClient.execute(httpGet);

            // 응답 데이터 읽기
            String responseBody = EntityUtils.toString(response.getEntity());

            // JSON 파싱
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(responseBody);

            // JSON 결과 출력
            String key = jsonNode.get("key").asText();
            System.out.println("Key: " + key);
        } catch (Exception e) {
            // 예외 처리
            e.printStackTrace();
        }
    }
}