<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
	
<section id="club-search-sec" class="p-2 club-search">
	<div>검색결과(${totalCount})</div>
	<div>
		<c:if test="${empty clubs}">
			<div>검색결과가 없습니다.</div>
		</c:if>
		<c:if test="${not empty clubs}">
			<c:forEach items="${clubs}" var="club" varStatus="vs">
				<div>
					<img src="${pageContext.request.contextPath}/resources/upload/profile/${club.renamedFilename}" width="150px">
					<span>모임명 : ${club.clubName}</span>
					<span>모임 지역 : ${club.activityArea}</span>
					<span>모임 분류 : ${club.category}</span>
					<span>모임 인원 : ${club.memberCount}/100</span>
					<span>모임 생성일 : ${club.createdAt}</span>
				</div>
			</c:forEach>
		</c:if>
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
// 검색창에 검색내용 남기기
document.querySelector("input[name=inputText]").value = '${inputText}';
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>