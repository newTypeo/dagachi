<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layoutType0.css"/>

	
<article id="club-page-article">
	<div id="club-myInfo-container">
	
	</div>
	
	<div id="club-main-container">
		<div id="club-main-image-container">
			<img src="${pageContext.request.contextPath}/resources/upload/club/main/${layout.mainImage}">
		</div>
		<div id="club-main-content-container">
			<p class="fontColors">${layout.mainContent}</p>
		</div>
	</div>
	
	<div id="club-notice-container" class="preview-container">
		<div class="container-header" style="border-color: ${layout.pointColor}">
			<span class="fontColors">공지사항</span>
			<a class="pointColors" href="/">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main container-main-long">
			<c:forEach items="${boardAndImages}" var="board">
				<c:if test="${board.type eq 4}">
					<div>
						<span class="badge badge-danger">공지</span>
						<a class="fontColors">${board.title}</a>
						<span>
							<fmt:parseDate value="${board.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
	    					<fmt:formatDate value="${createdAt}" pattern="yy.MM.dd HH:mm"/>
						</span>
						<span>❤${board.likeCount < 100 ? board.likeCount : '99+'}</span>
						<a href="/" class="fontColors">
							${board.writer}
						</a>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	<div id="club-gallery-container" class="preview-container">
		<div class="container-header" style="border-color: ${layout.pointColor}">
			<span class="fontColors">갤러리</span>
			<a class="pointColors" href="/">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main">
			<c:forEach items="${galleries}" var="gallery" >
				<div>
					<a href="/">
						<img src="${pageContext.request.contextPath}/resources/upload/club/gallery/${gallery.renamedFilename}" class="img-thumbnail">
					</a>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<div id="club-board-container" class="preview-container">
		<div class="container-header" style="border-color: ${layout.pointColor}">
			<span class="fontColors">자유게시판</span>
			<a class="pointColors" href="/">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main container-main-short">
			<c:forEach items="${boardAndImages}" var="board">
				<c:if test="${board.type eq 1}">
					<div>
						<span class="pointColors">·</span>
						<a class="fontColors">${board.title}</a>
						<span>
							<fmt:parseDate value="${board.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
	    					<fmt:formatDate value="${createdAt}" pattern="MM.dd HH:mm"/>
						</span>
						<span>❤${board.likeCount < 100 ? board.likeCount : '99+'}</span>
						<a href="/" class="fontColors">
							${board.writer}
						</a>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	<div id="club-greetings-container" class="preview-container">
		<div class="container-header" style="border-color: ${layout.pointColor}">
			<span class="fontColors">가입인사</span>
			<a class="pointColors" href="/">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main container-main-short">
			<c:forEach items="${boardAndImages}" var="board">
				<c:if test="${board.type eq 3}">
					<div>
						<span class="pointColors">·</span>
						<a class="fontColors">${board.title}</a>
						<span>
							<fmt:parseDate value="${board.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
	    					<fmt:formatDate value="${createdAt}" pattern="MM.dd HH:mm"/>
						</span>
						<span>❤${board.likeCount < 100 ? board.likeCount : '99+'}</span>
						<a href="/" class="fontColors">
							${board.writer}
						</a>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	<div id="club-reivew-container" class="preview-container">
		<div class="container-header" style="border-color: ${layout.pointColor}">
			<span class="fontColors">정모후기</span>
			<a class="pointColors" href="/">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main container-main-short">
			<c:forEach items="${boardAndImages}" var="board">
				<c:if test="${board.type eq 2}">
					<div>
						<span class="pointColors">·</span>
						<a class="fontColors">${board.title}</a>
						<span>
							<fmt:parseDate value="${board.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
	    					<fmt:formatDate value="${createdAt}" pattern="MM.dd HH:mm"/>
						</span>
						<span>❤${board.likeCount < 100 ? board.likeCount : '99+'}</span>
						<a href="/" class="fontColors">
							${board.writer}
						</a>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	<div id="club-schedule-container" class="preview-container">
		<div class="container-header" style="border-color: ${layout.pointColor}">
			<span class="fontColors">일정</span>
			<a class="pointColors" href="/">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main-schedule">
			<c:forEach items="${schedules}" var="schedule">
				<div>
					<span class="pointColors">·</span>
					<a class="fontColors">${schedule.title}</a>
					<span>👩🏻‍🤝‍🧑🏻${schedule.memberCount}/${schedule.capacity}</span>
					<span>
						<fmt:parseDate value="${schedule.startDate}" pattern="yyyy-MM-dd'T'HH:mm" var="startDate"/>
    					<fmt:formatDate value="${startDate}" pattern="MM.dd HH:mm"/>
    					~
    					<fmt:parseDate value="${schedule.endDate}" pattern="yyyy-MM-dd'T'HH:mm" var="endDate"/>
    					<fmt:formatDate value="${endDate}" pattern="MM.dd HH:mm"/>
					</span>
				</div>
			</c:forEach>
		</div>
	</div>
</article>
