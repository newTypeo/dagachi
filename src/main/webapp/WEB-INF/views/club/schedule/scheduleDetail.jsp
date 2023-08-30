<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>

<section id="club-board-sec" class="">

	<nav id="club-title" class="">
		<c:if test="${layout.title eq null}">
			<div id="default-title">
				<h2>${domain}</h2>
			</div>
		</c:if>
		
		<c:if test="${layout.title ne null}">
			<img src="${pageContext.request.contextPath}/resources/upload/club/title/${layout.title}">
		</c:if>
	</nav>
	
	<nav id="club-nav-bar" style="border-color: ${layout.pointColor}">
		<h5><a href="${pageContext.request.contextPath}/club/${domain}">🚩${clubName}</a></h5>
		<div class="fontColors">
			<ul>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">📢공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">🐳자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">✋가입인사</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">🎉정모후기</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubGallery.do">📷갤러리</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">📅일정</a></li>
			</ul>
		</div>
	</nav>

	<div id="schedule-content-container">
		<h3>${schedule.title}</h3>	
		<div>
			<figure>
				<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${schedule.renamedFilename}">
			</figure>
			<div>
				<strong><a>${schedule.nickname}</a> | 
					<c:if test="${clubMember.clubMemberRole eq 3}">
					🥇방장
					</c:if>
					<c:if test="${clubMember.clubMemberRole eq 2}">
					🥇부방장
					</c:if>
					<c:if test="${clubMember.clubMemberRole eq 1}">
					🥇임원
					</c:if>
					<c:if test="${clubMember.clubMemberRole eq 0}">
					🎀일반회원
					</c:if>
				</strong><br>
				<span>
					<fmt:parseDate value="${schedule.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
	    			<fmt:formatDate value="${createdAt}" pattern="yyyy.MM.dd HH:mm"/>
				</span>
			</div>
		</div>
		<div id="schedule-content-container2">
			<div id="scc2-left">
			
			</div>
			<div id="scc2-right">
			</div>
		</div>
	</div>

	
	
</section>

<div>${schedule}</div>

<script>

document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";



const REST_API_KEY = '0b08c9c74b754bc22377c45ec5ce2736';
const url = 'https://apis-navi.kakaomobility.com/v1/directions?origin=127.11015314141542,37.39472714688412&destination=127.10824367964793,37.401937080111644';
fetch(url, {
	method: "GET",
	headers: {
		"Authorization": 'KakaoAK ' + REST_API_KEY
	}
})
.then(response => response.json())
.then(data => {
	// 여기서 data를 활용하여 원하는 동작을 수행하세요
	console.log(data);
})
.catch(error => {
	// 오류 처리
	console.error("Error:", error);
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>