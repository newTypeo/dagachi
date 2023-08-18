package com.dagachi.app;

public class Pagination {
	
	/**
	 * page 처리 메소드 (공통사용 가능)
	 * @author 현우
	 */
	public static String getPagebar(int page, int limit, int totalContent, String url) {
		StringBuilder pagebar = new StringBuilder(); // 문자열 더하기 연산에 최적화
		
		int totalPage = (int) Math.ceil((double) totalContent / limit);
		url += "?page=";
		int pagebarSize = 5;	
		int pageStart = (page - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		int pageNo = pageStart;
		
		// 1. 이전
		if (pageNo == 1) {
			// 이전 버튼 비활성화
		} 
		else {
			pagebar.append(String.format("<a href='%s%d'>이전</a>", url, pageNo - 1));
			pagebar.append("\n");
		}
		
		// 2. 숫자
		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == page) {
				// 현재페이지인 경우
				pagebar.append(String.format("<span class='page'>%d</span>",pageNo));
				pagebar.append("\n");
			}
			else {
				pagebar.append(String.format("<a href='%s%d'>%d</a>",url, pageNo, pageNo));
				pagebar.append("\n");
			}
			pageNo++;
		}
		
		// 3. 다음
		if (pageNo > totalPage) {
			// 마지막페이지가 이미 노출된 경우
		}
		else {
			pagebar.append(String.format("<a href='%s%d'>다음</a>", url, pageNo));
		}
		
		return pagebar.toString();
	}

}
