<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다가치</title>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

<!-- 아이콘 링크 -->
<script src="https://kit.fontawesome.com/d7ccac7be9.js" crossorigin="anonymous"></script>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet&family=IBM+Plex+Sans+KR&family=Jua&family=Noto+Sans+KR&family=Orbit&display=swap" rel="stylesheet">

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
 
</head>
<body>
<sec:authorize access="isAuthenticated()">
	<form:form 
		name="memberLogoutFrm" 
		action="${pageContext.request.contextPath}/member/memberLogout.do" 
		method="POST"></form:form>
</sec:authorize>

<div id="container">

	<header>
	
	
		<div id="main-logo-container">
			<a href="${pageContext.request.contextPath}">
				<img id="main-logo" src="${pageContext.request.contextPath}/resources/images/004.png" class="p-2">
			</a>
		</div>
		<sec:authorize access="isAnonymous()">
			<div id="header-nav-container">
				<a href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
				<span>|</span>
				<a href="${pageContext.request.contextPath}/member/memberCreate.do">회원가입</a>
				<span>|</span>
				<a href="${pageContext.request.contextPath}/member/memberFind.do">아이디/비밀번호찾기</a>
			</div>
		</sec:authorize>
			 
			 
		<sec:authorize access="isAuthenticated()">
			    <span>
			    <a title="<sec:authentication property="authorities"/>"><sec:authentication property="principal.username"/></a>님, 안녕하삼</span>
			    &nbsp;
			    <button type="button"onclick="document.memberLogoutFrm.submit();">로그아웃</button>
			    <button type="button"onclick="withdrawalMember();">회원탈퇴</button>
			    <form:form name="memberDeleteFrm" action="${pageContext.request.contextPath}/member/memberDelete.do" method="post"></form:form>
			    <a href="${pageContext.request.contextPath}/club/clubsRecentVisited.do">최근 본 모임</a>
		</sec:authorize>
				<a href="${pageContext.request.contextPath}/member/memberAdminInquiryList.do">문의하기</a>
				

	</header>
	
	<jsp:include page="/WEB-INF/views/common/navBar.jsp"></jsp:include>

<script>
const withdrawalMember = () => {
	if(confirm('정말로 탈퇴하시겠습니까?')){
		document.memberDeleteFrm.submit();
	}
};
</script>