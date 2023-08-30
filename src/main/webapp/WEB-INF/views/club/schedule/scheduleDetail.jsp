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
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>