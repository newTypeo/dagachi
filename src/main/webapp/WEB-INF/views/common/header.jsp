<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<style>
#alarmBox{
            visibility: hidden;
}
</style>
<head>
<meta charset="UTF-8">
<title>다가치</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">

<!-- 아이콘 링크 -->
<script src="https://kit.fontawesome.com/d7ccac7be9.js"
	crossorigin="anonymous"></script>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap"
	rel="stylesheet">

<!-- 사용자작성 css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css" />

<!-- 토큰 -->
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}" />

</head>
<sec:authorize access="isAuthenticated()">
	<script >
		const memberId= "<sec:authentication property="principal.memberId"/>";
		window.roomMaps = new Map();
	</script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"
		integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"
		integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
</sec:authorize>

<body>
	<sec:authorize access="isAuthenticated()">
		<form:form name="memberLogoutFrm"
			action="${pageContext.request.contextPath}/member/memberLogout.do"
			method="POST"></form:form>
	</sec:authorize>

	<div id="container">

		<header>
			<div id="main-logo-container">
				<a href="${pageContext.request.contextPath}"> <img
					id="main-logo"
					src="${pageContext.request.contextPath}/resources/images/004.png"
					class="p-2"></a>
			</div>
			<sec:authorize access="isAnonymous()">
				<div id="header-nav-container">
					<a href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
					<span>|</span> <a
						href="${pageContext.request.contextPath}/member/memberCreate.do">회원가입</a>
				</div>
			</sec:authorize>

			<sec:authorize access="isAuthenticated()">
				<div id="header-nav-container">
						 <i class="fa-solid fa-bell fa-beat"></i> 
						 <i id="bell" class="fa-solid fa-bell"></i> 
							<div  id="alarmBox" class="" > 
							</div>
					<span>
						 	<a title="<sec:authentication property="authorities"/>"
							href="${pageContext.request.contextPath}/member/<sec:authentication property="principal.memberId"/>">
								<sec:authentication property="principal.nickname" />
						</a>님
					</span> <span>|</span> <a
						href="${pageContext.request.contextPath}/member/memberAdminInquiryList.do">문의하기</a>
					<span>|</span> <a type="button"
						onclick="document.memberLogoutFrm.submit();">로그아웃</a>
				</div>

				<c:if test="${memberId eq 'admin'}">
					<div class="dropdown">
						<button id="admin-nav-btn"
							class="btn btn-secondary dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="false">회원관리</button>
						<div class="dropdown-menu">
							<button class="dropdown-item" type="button">
								<a href="${pageContext.request.contextPath}/admin/adminMemberList.do?keyword=&column=">회원조회</a>
							</button>
							<button class="dropdown-item" type="button">
								<a href="${pageContext.request.contextPath}/admin/adminQuitMemberList.do?keyword=&column=">탈퇴회원조회</a>
							</button>
							<button class="dropdown-item" type="button">
								<a href="${pageContext.request.contextPath}/admin/adminReportMemberList.do?keyword=&column=">신고회원조회</a>
							</button>
							<button class="dropdown-item" type="button">
								<a href="${pageContext.request.contextPath}/admin/adminClubList.do?keyword=&column=">모임목록</a>
							</button>
							<button class="dropdown-item" type="button">
								<a href="${pageContext.request.contextPath}/admin/adminUpdateBanner.do">배너변경</a>
							</button>
							<button class="dropdown-item" type="button">
								<a href="${pageContext.request.contextPath}/admin/adminInquiryList.do?">문의목록/답변(관리자)</a>
							</button>
	
						</div>
					</div>
				</c:if>
				<!-- 로그인한 회원에 한해 최초 1회 실행되는 코드(반경 동정보 session에 저장) -->
				<c:if test="${empty zoneSet1 or zoneSet1 eq null}">
					<script>
				console.log("최초 로그인 시에만 찍혀야하는 로그(종환)");
				$.ajax({ // 로그인한 회원의 주활동지역 코드 세션에 저장
					url : "${pageContext.request.contextPath}/club/getMainAreaId.do",
					success({mainAreaId}) {
						
						$.ajax({
							url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=" + mainAreaId,
							data : {is_ignore_zero : true},
							success({regcodes}) {
								// 서울특별시 **구 **동 (회원의 주활동지역)
								const mainAreaName = regcodes[0].name; 
								$.ajax({
									url : "${pageContext.request.contextPath}/club/setZoneInSession.do",
									data : {mainAreaName},
									success() {
										console.log("session에 동네 저장 완료!(종환)");
									}
								}); // ajax3
							} // success2
						}); // ajax2
					}// success2
				}); // ajax1
				
				</script>
				</c:if>
				
				<script>
				
			/* 	document.querySelector("#bell").addEventListener("click",(e)=>{
					console.log(e.target);
					const bell=e.target;
					bell.classList.remove("fa-beat");
					
					const alarmToggle=document.querySelector("#alarmBox");
					
					 if (alarmBox.style.visibility === "hidden") {
						 alarmBox.style.visibility = "visible";
					console.log(alarmBox);
						 console.log("visible");
					 }else{
						 alarmBox.style.visibility = "hidden";
						 console.log("hidden");
					console.log(alarmBox);
					 }
				});
				
				
				const alarmLoad=()=>{
					
				}; */
				
				</script>

			</sec:authorize>

		</header>