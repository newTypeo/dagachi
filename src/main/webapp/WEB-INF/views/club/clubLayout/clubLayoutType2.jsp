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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layoutType2.css"/>

	
<article id="club-page-article">
	<div id="club-util-box">
		<div id="club-myInfo-container"></div>
		<div id="club-total-container" class="fontColors" style="border-color: ${layout.pointColor}">
			<div>
				<a>📄전체글보기</a>
			</div>
			<div>
				<a>📢공지사항</a>
				<a>🐳자유게시판</a>
				<a>✋가입인사</a>
				<a>🎉정모후기</a>
			</div>
			<div>
				<a>📷갤러리</a>
			</div>
			<div>
				<a>📅일정</a>
			</div>
		</div>
		<div id="club-search-container1">
			<form action="">
				<input name="" style="background-color: ${layout.backgroundColor}; border-color: ${layout.pointColor};"/>
				<button style="border-color: ${layout.pointColor};">검색</button>
			</form>
		</div>
	</div>
	
	<div id="club-main-container">
		<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<div id="club-schedule-container" class="preview-container">
						<div class="container-header" style="border-color: ${layout.pointColor}">
							<span class="fontColors">일정</span>
							<a class="pointColors" href="/">
								더보기<i class="fa-solid fa-angle-right"></i>
							</a>
						</div>
						<div class="container-main-schedule">
							캘린더
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<div id="club-main-image-container">
						<img
							src="${pageContext.request.contextPath}/resources/upload/club/main/${layout.mainImage}">
					</div>
					<div id="club-main-content-container">
						<p class="fontColors">${layout.mainContent}</p>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-target="#carouselExampleControls" data-slide="prev">
				<span aria-hidden="true"><i class="fa-solid fa-angle-left fa-2xl pointColors"></i></span>
				<span class="sr-only">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-target="#carouselExampleControls" data-slide="next">
				<span aria-hidden="true"><i class="fa-solid fa-angle-right fa-2xl pointColors"></i></span>
				<span class="sr-only">Next</span>
			</button>
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
						<a class="fontColors" href="${pageContext.request.contextPath}/club/sportsclub/boardDetail.do?no=${board.boardId}">${board.title}</a>
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
						<a class="fontColors" href="${pageContext.request.contextPath}/club/sportsclub/boardDetail.do?no=${board.boardId}">${board.title}</a>
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
	
	<div>
		<div id="club-gallery-container" class="preview-container">
			<div class="container-header" style="border-color: ${layout.pointColor}">
				<span class="fontColors">갤러리</span>
				<a class="pointColors" href="/">
					더보기<i class="fa-solid fa-angle-right"></i>
				</a>
			</div>
			<div class="container-main-gallery">
				<c:forEach items="${galleries}" var="gallery" >
					<div>
						<a href="/">
							<img src="${pageContext.request.contextPath}/resources/upload/club/gallery/${gallery.renamedFilename}" class="img-thumbnail">
						</a>
					</div>
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
							<a class="fontColors" href="${pageContext.request.contextPath}/club/sportsclub/boardDetail.do?no=${board.boardId}">${board.title}</a>
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
							<a class="fontColors" href="${pageContext.request.contextPath}/club/sportsclub/boardDetail.do?no=${board.boardId}">${board.title}</a>
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
	</div>
	
	
	
	
</article>

<script>
$('.carousel').carousel({
	interval: false
})
</script>
