<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


<section id="admin-club-list-sec" class="p-2 club-list">
	
	<h1>모임목록 페이지</h1>
	<div id="club-list-wrapper">
		<div id="search-container">
	        <label for="searchType">검색타입 :</label> 
	        <select id="searchType">
	            <option id="searchOption" value="clubNameSearch">모임명</option>      
	            <option id="searchOption" value="clubAreaSearch">지역</option>      
	            <option id="searchOption" value="clubCategorySearch">카테고리</option>           
	        </select>
		
				<div id="search-name" class="search-type" style="display : inline-block">
					<input type="text" id="clubNameSearch" placeholder="모임명을 입력하세요" name="club_name">
		        </div>
				<div id="search-area" class="search-type" style="display : none">
					<input type="text" id="clubAreaSearch" placeholder="지역을 입력하세요" name="activity_area">
		        </div>
				<div id="search-category" class="search-type" style="display : none">
					<input type="text" id="clubCategorySearch" placeholder="카테고리를 입력하세요" name="category">
		        </div>
				
			<table id="clubListTable">
				<thead>
					<tr>
						<th>번호</th>
						<th>모임명</th>
						<th>지역</th>
						<th>분류</th>
						<th>신고</th>
						<th>도메인</th>
						<th>생성일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${empty clubs}">
					<tr>
						<td colspan="7">조회된 모임이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty clubs}">
					<c:forEach items="${clubs}" var="club" varStatus="vs">
						<tr>
							<td>${club.clubId}</td>
							<td>${club.clubName}</td>
							<td>${club.activityArea}</td>
							<td>${club.category}</td>
							<td>${club.reportCount}</td>
							<td>${club.domain}</td>
							<td>
								<fmt:parseDate value="${club.createdAt}" var="createdAt"  pattern="yyyy-MM-dd'T'HH:mm:ss"></fmt:parseDate>
								<fmt:formatDate value="${createdAt}" pattern="yy/MM/dd" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
</section>
<script>
// 검색유형 선택 시 display 설정
document.querySelector("#searchType").onchange = (e) => {
	document.querySelectorAll(".search-type").forEach((input) => {
		input.style.display = 'none';
	});
	
	const inputId = $("#searchType option:selected").val();
	console.log(document.querySelector(`#\${inputId}`));
	const selectedInput = document.querySelector(`#\${inputId}`);
	selectedInput.parentElement.style.display = 'inline-block';
};

// 검색유형 별 검색시 비동기로 모임 조회
document.querySelectorAll(".search-type").forEach((input) => {
	input.onkeyup = (e) => {
		const keyword = e.target.value;
		const column = e.target.name;
		// console.log("keyword, column=", keyword, column);
		$.ajax({
			url : "${pageContext.request.contextPath}/club/adminClubSearch.do",
			data : {keyword, column},
			dataType : "json", 
			success(clubs){
				const tbody = document.querySelector("#clubListTable tbody");
				tbody.innerHTML = '';
				let html = '';
				if(clubs.length == 0) {
					html += `<tr><td colspan='7'>조회된 결과가 없습니다.</td></tr>`;
				}
				else {
					clubs.forEach((club) => {
						// 월 일 10 미만 시 0 붙여주는 함수
						const f = (n) => {return n < 10 ? '0' + n : n};
						const date = new Date(`\${club.createdAt}`);
						// year 뒷 두글자만 사용하기
						const year = String(date.getFullYear()).substring(2);
						const month = date.getMonth() + 1;
						const day = date.getDate();
						console.log("month, day", month,day)
						html += `
						<tr>
							<td>\${club.clubId}</td>
							<td>\${club.clubName}</td>
							<td>\${club.activityArea}</td>
							<td>\${club.category}</td>
							<td>\${club.reportCount}</td>
							<td>\${club.domain}</td>
							<td>
							    \${year}/\${f(month)}/\${f(day)}
							</td>
						</td>
						</tr>
						`;
					});
				} // else
				tbody.innerHTML = html;
			} // success
		}); // ajax
	}; // onkeyup  
});	// forEach
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>