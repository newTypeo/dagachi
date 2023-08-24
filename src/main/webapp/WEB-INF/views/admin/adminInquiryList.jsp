<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="admin-report-inquiry-list-sec" class="p-2 report-inquiry-list">
	<h1>문의 목록 페이지</h1>

	<div id="report-inquiry-list-wrapper">
		<div id="search-container">
			<div id="searchBar-wrap">
			
				<select class="custom-select custom-select-lg mb-3" id="dType">
					<option value="0" selected>전체보기</option>
					<option value="1">회원 정보 문의</option>
					<option value="2">소모임 관련 문의</option>
					<option value="3">결제 문의</option>
					<option value="4">신고 문의</option>
				</select>
			
				<label for="searchType">검색타입 :</label> 
				<select id="searchType">
					<option id="searchOption" value="reportInquiryIdSearch">ID</option>
					<option id="searchOption" value="reportInquiryTitleSearch">제목</option>
					<option id="searchOption" value="reportInquiryContentSearch">내용</option>
				</select>
				
				<div id="search-name" class="search-type" style="display: inline-block">
					<input type="text" id="reportInquiryIdSearch" placeholder="ID를을 입력하세요" name="name">
					<button onclick="reportSearchInquiry(this);" name="member_id">검색</button>
				</div>
				<div id="search-id" class="search-type" style="display: none">
					<input type="text" id="reportInquiryTitleSearch" placeholder="제목을 입력하세요" name="member_id">
					<button onclick="reportSearchInquiry(this);" name="title">검색</button>
				</div>
				<div id="search-address" class="search-type" style="display: none">
					<input type="text" id="reportInquiryContentSearch" placeholder="내용을 입력하세요" name="address">
					<button onclick="reportSearchInquiry(this);" name="content">검색</button>
				</div>
					<label for="answerType">답변 여부 :</label>
					<input type="radio" id="answerType" name="answerType" value="answer"> 답변
					<input type="radio" id="answerType" name="answerType" value="noAnswer"> 비답변

				<form name="searchReportInquiryFrm"
					action="${pageContext.request.contextPath}/admin/adminReportInquiryList.do">
					<input type="hidden" name="keyword" id="keywordHidden"> <input
						type="hidden" name="column" id="columnHidden">
				</form>

				<table id="reportInquiryListTable">
					<thead>
						<tr>
							<th>카테고리</th>
							<th>ID</th>
							<th>제목</th>
							<th>답변여부</th>
							<th>게시일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty inquiry}">
							<tr>
								<td colspan="7">조회된 문의가 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${not empty inquiry}">
							<c:forEach items="${inquiry}" var="inquiry" varStatus="vs">
								<tr>
									<td>${inquiry.type}</td>
									<td>${inquiry.memberId}</td>
									<td>${inquiry.title}</td>
									<td>
										<button>답변하기</button>
									</td>
									<%-- <td>${member.birthday}</td> --%>
									<td><fmt:parseDate value="${inquiry.createdAt}"
											var="createdAt" pattern="yyyy-MM-dd"></fmt:parseDate> <fmt:formatDate
											value="${createdAt}" pattern="yy/MM/dd" /></td>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
<%-- 	<div id="pagebar-wrapper" class="text-center">
		<c:if test="${empty pagebar}">
			<span></span>
		</c:if>
		<c:if test="${not empty pagebar}">
			<span>${pagebar}</span>
		</c:if>
	</div> --%>
	
</section>
<script>
//검색유형 선택 시 display 설정
document.querySelector("#searchType").onchange = (e) => {
	document.querySelectorAll(".search-type").forEach((input) => {
		input.style.display = 'none';
	});
	
	/* const inputId = $("#searchType option:selected").val(); */
	const inputId = $("#searchType").val();
	
	console.log(document.querySelector(`#\${inputId}`));
	const selectedInput = document.querySelector(`#\${inputId}`);
	selectedInput.parentElement.style.display = 'inline-block';
};

//검색유형 별 검색시 동기로  탈퇴회원 조회
const reportSearchInquiry = (btnTag) => {
	console.log(btnTag);
	const column = btnTag.name;
	document.querySelector("#keywordHidden").value = keyword;
	document.querySelector("#columnHidden").value = column;
	document.searchReportMemberFrm.submit();
};

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>