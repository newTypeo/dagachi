<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


<section id="main-page-sec" class="p-2 club-list">
	<h1>모임목록 페이지</h1>
	
	<div id="club-list-wrapper">
		<div id="search-container">
	        <label for="searchType">검색타입 :</label> 
	        <select id="searchType">
	            <option value="clubName" >모임명</option>      
	            <option value="area" >지역</option>      
	            <option value="category" >분류</option>           
	        </select>
		
				<div id="search-name" class="search-type">
					<input type="text" id="clubSearch" placeholder="모임을 입력하세요" name="clubName">
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
// 비동기 모임 검색
document.querySelector("#clubSearch").onkeyup = (e) => {
	const keyword = e.target.value;
	$.ajax({
		url : "${pageContext.request.contextPath}/club/clubSearch.do",
		data : {keyword},
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
					html += `
					<tr>
						<td>\${club.clubId}</td>
						<td>\${club.clubName}</td>
						<td>\${club.activityArea}</td>
						<td>\${club.category}</td>
						<td>\${club.reportCount}</td>
						<td>\${club.domain}</td>
					</tr>
					`;
				});
			}
			
			tbody.innerHTML = html;
		}
	});
	
	
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>