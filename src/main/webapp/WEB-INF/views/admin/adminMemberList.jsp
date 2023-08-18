<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


<section id="main-page-sec" class="p-2 member-list">
	<h1>회원목록 페이지</h1>
	
	<div id="member-list-wrapper">
		<div id="search-container">
	        <label for="searchType">검색타입 :</label> 
	        <select id="searchType">
	            <option id="searchOption" value="memberNameSearch">이름</option>      
	            <option id="searchOption" value="memberIdSearch" >ID</option>      
	            <option id="searchOption" value="memberAddressSearch" >주소</option>           
	        </select>
		
				<div id="search-name" class="search-type" style="display : inline-block">
					<input type="text" id="memberNameSearch" placeholder="이름을 입력하세요">
					<button onclick="searchMember(this);" name="name" >검색</button>
		        </div>
		        <div id="search-id" class="search-type" style="display : none">
					<input type="text" id="memberIdSearch" placeholder="ID을 입력하세요">
					<button onclick="searchMember(this);" name="member_id" >검색</button>
		        </div>
				<div id="search-address" class="search-type" style="display : none">
					<input type="text" id="memberAddressSearch" placeholder="주소를 입력하세요" >
					<button onclick="searchMember(this);" name="address" >검색</button>
		        </div>
				
	
			<table id="memberListTable">
				<thead>
					<tr>
						<th>ID</th>
						<th>이름</th>
						<th>닉네임</th>
						<th>연락처</th>
						<th>주소</th>
						<th>성별</th>
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
							<%-- <td>${member.birthday}</td> --%>
							<td>
								<fmt:parseDate value="${member.birthday}" var="birthday"  pattern="yyyy-MM-dd"></fmt:parseDate>
								<fmt:formatDate value="${birthday}" pattern="yy/MM/dd" />
							</td>
							<td>
								<fmt:parseDate value="${member.enrollDate}" var="enrollDate"  pattern="yyyy-MM-dd"></fmt:parseDate>
								<fmt:formatDate value="${enrollDate}" pattern="yy/MM/dd" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
	<div id="pagebar-wrapper">	
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

// 검색유형 별 검색시 동기로 회원 조회
const searchMember = (btnTag) => {
	console.log(btnTag);
	const keyword = btnTag.previousElementSibling.value;
	const column = btnTag.name;
	console.log("keyword, column", keyword, column);
	window.href = "{pageContext.request.contextPath}/admin/memberSearch"
};

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>