<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="admin-report-member-list-sec" class="p-2 report-member-list">
	<h1>신고 회원목록 페이지</h1>

	<div id="report-member-list-wrapper">
		<div id="search-container">
			<div id="searchBar-wrap">
				<label for="searchType">검색타입 :</label> 
				<select id="searchType">
					<option id="searchOption" value="reportMemberNameSearch">이름</option>
					<option id="searchOption" value="reportMemberIdSearch">ID</option>
					<option id="searchOption" value="reportMemberAddressSearch">주소</option>
				</select>

				<div id="search-name" class="search-type" style="display: inline-block">
					<input type="text" id="reportMemberNameSearch" placeholder="이름을 입력하세요" name="name">
					<button onclick="reportSearchMember(this);" name="name">검색</button>
				</div>
				<div id="search-id" class="search-type" style="display: none">
					<input type="text" id="reportMemberIdSearch" placeholder="ID을 입력하세요" name="member_id">
					<button onclick="reportSearchMember(this);" name="member_id">검색</button>
				</div>
				<div id="search-address" class="search-type" style="display: none">
					<input type="text" id="reportMemberAddressSearch" placeholder="주소를 입력하세요" name="address">
					<button onclick="reportSearchMember(this);" name="address">검색</button>
				</div>

				<form name="searchReportMemberFrm"
					action="${pageContext.request.contextPath}/admin/adminReportMemberList.do">
					<input type="hidden" name="keyword" id="keywordHidden"> <input
						type="hidden" name="column" id="columnHidden">
				</form>

				<table id="reportMemberListTable">
					<thead>
						<tr>
							<th>ID</th>
							<th>이름</th>
							<th>닉네임</th>
							<th>연락처</th>
							<th>주소</th>
							<th>성별</th>
							<th>신고누적횟수</th>
							<th>생년월일</th>
							<th>가입일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty members}">
							<tr>
								<td colspan="7">조회된 회원이 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${not empty members}">
							<c:forEach items="${members}" var="member" varStatus="vs">
								<tr>
									<td>${member.memberId}</td>
									<td>${member.name}</td>
									<td>${member.nickname}</td>
									<td>${member.phoneNo}</td>
									<td>${member.address}</td>
									<td>${member.gender}</td>
									<td>${member.reportCount}</td>
									<%-- <td>${member.birthday}</td> --%>
									<td><fmt:parseDate value="${member.birthday}"
											var="birthday" pattern="yyyy-MM-dd"></fmt:parseDate> <fmt:formatDate
											value="${birthday}" pattern="yy/MM/dd" /></td>
									<td><fmt:parseDate value="${member.enrollDate}"
											var="enrollDate" pattern="yyyy-MM-dd"></fmt:parseDate> <fmt:formatDate
											value="${enrollDate}" pattern="yy/MM/dd" /></td>
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
//검색유형 선택 시 display 설정
document.querySelector("#searchType").onchange = (e) => {
	document.querySelectorAll(".search-type").forEach((input) => {
		input.style.display = 'none';
	});
	
	const inputId = $("#searchType option:selected").val();
	console.log(document.querySelector(`#\${inputId}`));
	const selectedInput = document.querySelector(`#\${inputId}`);
	selectedInput.parentElement.style.display = 'inline-block';
};

//검색유형 별 검색시 동기로 탈퇴회원 조회
const reportSearchMember = (btnTag) => {
	console.log(btnTag);
	const keyword = btnTag.previousElementSibling.value;
	const column = btnTag.name;
	document.querySelector("#keywordHidden").value = keyword;
	document.querySelector("#columnHidden").value = column;
	document.searchReportMemberFrm.submit();
};

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>