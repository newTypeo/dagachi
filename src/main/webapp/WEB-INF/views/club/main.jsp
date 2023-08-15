<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>

<nav id="club-banner" class="bg-primary">
	<h2>title : 소모임 별 배너</h2>
</nav>

<nav>
	<h3>메뉴 바</h3>
	<a href="${pageContext.request.contextPath}/club/clubBoardList.do">게시판</a>
</nav>

<section id="club-page-sec" class="p-2 bg-danger">
	<h1>메인 페이지</h1>
	
	
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>