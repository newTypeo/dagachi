<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css"/>


<section id="admin-club-list-sec" class="p-2 club-list sectionList">
	
	<h1>모임목록</h1>
	<div id="club-list-wrapper">
		<div id="search-container">
			<div id="searchBar-wrap">
		        <label for="searchType">검색타입 :</label> 
		        <select id="searchType">
		            <option id="searchOption" value="clubNameSearch">모임명</option>      
		            <option id="searchOption" value="clubAreaSearch">지역</option>      
		            <option id="searchOption" value="clubCategorySearch">카테고리</option>           
		        </select>
			
				<div id="search-name" class="search-type" style="display : inline-block">
					<input type="text" id="clubNameSearch" placeholder="모임명을 입력하세요">
					<button onclick="searchClub(this);" name="club_name">검색</button>
		        </div>
				<div id="search-area" class="search-type" style="display : none">
					<input type="text" id="clubAreaSearch" placeholder="지역을 입력하세요" >
					<button onclick="searchClub(this);" name="activity_area">검색</button>
		        </div>
				<div id="search-category" class="search-type" style="display : none">
					<input type="text" id="clubCategorySearch" placeholder="카테고리를 입력하세요">
					<button onclick="searchClub(this);" name="category">검색</button>
		        </div>
			
				<form 
					name="searchClubFrm"
					action="${pageContext.request.contextPath}/admin/adminClubList.do">
					<input type="hidden" name="keyword" id="keywordHidden">
					<input type="hidden" name="column" id="columnHidden">
				</form>
				
			
				<table id="clubListTable"
				class="listTable">
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
									<fmt:parseDate value="${club.createdAt}" var="createdAt"  pattern="yyyy-MM-dd'T'HH:mm"></fmt:parseDate>
									<fmt:formatDate value="${createdAt}" pattern="yy/MM/dd" />
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div id="pagebar-wrapper" class="text-center">	
		<c:if test="${empty pagebar}">
				<span></span>
		</c:if>
		<c:if test="${not empty pagebar}">
				<span>${pagebar}</span>
		</c:if>
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

const searchClub = (btnTag) => {
	const keyword = btnTag.previousElementSibling.value;
	const column = btnTag.name;
	// console.log("keyword, column", keyword, column);
	document.querySelector("#keywordHidden").value = keyword;
	document.querySelector("#columnHidden").value = column;
	document.searchClubFrm.submit();
};


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>