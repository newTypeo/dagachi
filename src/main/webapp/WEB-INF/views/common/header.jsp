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
<script src="https://kit.fontawesome.com/d7ccac7be9.js" crossorigin="anonymous"></script>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap"
	rel="stylesheet">

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />

<!-- 토큰 -->
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}" />

</head>
<sec:authorize access="isAuthenticated()">
	<script >
		const memberId= "<sec:authentication property="principal.memberId"/>";
		window.roomMaps = new Map();

		window.onload=()=>{
			alarmLoad();
		};
		
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
				<a href="${pageContext.request.contextPath}">
					<img id="main-letter-logo"
						 src="${pageContext.request.contextPath}/resources/images/mainLogo.png"
						 class="p-2"></a>
			
				<a href="${pageContext.request.contextPath}">
					<img id="main-logo"
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
						 <i id="bell" class="fa-solid fa-bell fa-xl bellStyle1"></i> 
							<div  id="alarmBox" class="" ></div>
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

					<div class="dropdown">
						
						<%-- <sec:authorize access="hasRole('ROLE_ADMIN')"> --%>
							<button id="admin-nav-btn"
								class="btn btn-secondary dropdown-toggle" type="button"
								data-toggle="dropdown" aria-expanded="false">회원관리</button>
						<%-- </sec:authorize> --%>
					
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
				<!-- 로그인한 회원에 한해 최초 1회 실행되는 코드(반경 동정보 session에 저장) -->
				<c:if test="${empty zoneSet1 or zoneSet1 eq null}">
					<script>
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
										data : {mainAreaName}
									}); // ajax3
								} // success2
							}); // ajax2
						}// success2
 					}); // ajax1
					</script>
				</c:if>
				
				<script>
				document.querySelector("#bell").addEventListener("click",(e)=>{
					const receiver= memberId;
					const bell=e.target;
					const token= document.memberLogoutFrm._csrf.value;
					bell.classList.remove("fa-beat");
					
					const alarmBox=document.querySelector("#alarmBox");
					const computedStyle = window.getComputedStyle(alarmBox);
					const displayPropertyValue = computedStyle.getPropertyValue("display");
					
					if (displayPropertyValue === "none"){
						  alarmBox.style.display = "inline";
		
						$.ajax({
							url:"${pageContext.request.contextPath}/notification/checkedAlarm.do",
							method :"POST",
							data:{receiver},
							headers: {
								"X-CSRF-TOKEN": token
							},
							success(){}
						});
						
					}
					else 
						  alarmBox.style.display = "none";
					
					
					 
				});
				
				
				const alarmLoad=()=>{
					const receiver= memberId;
					$.ajax({
						url:"${pageContext.request.contextPath}/notification/findAlarms.do",
						data:{receiver},
						success(alarms){
					
							if(alarms.length>0){
								alarms.forEach((alarm)=>{
									const {id,receiver,sender,type,createdAt,content}=alarm;
									
									const alarmWrap=document.querySelector("#alarmBox");
									if(type==="CHATNOTICE"){
										const divId=`#\${content.replace(/\s/g, "_")}`;
										const spanId=`#\${content.replace(/\s/g, "-")}`;
										
										const chatRoomCheck=document.querySelector(divId);
										if(chatRoomCheck === null){
											roomMaps.set(content, 1);
											const alarmDiv=document.createElement('div');
											alarmDiv.setAttribute('id', content.replace(/\s/g, "_"));
											alarmDiv.className = 'list-group';
											alarmDiv.innerHTML=`
												 <a href="#" class="list-group-item list-group-item-action list-group-item-light">
													\${content} :새로운 메세지가 도착하였습니다 
													<span id="\${content.replace(/\s/g, "-")}" class="badge badge-primary">
														\${roomMaps.get(content)}
													</span>
												</a>
											`;
											alarmWrap.appendChild(alarmDiv);
										}else{
											roomMaps.set(content, (roomMaps.get(content)+ 1));
											
											document.querySelector(spanId).innerText=`\${roomMaps.get(content)}`;
										}
									
									}else{
						
								 	 	const noticeAlarm=document.createElement('div');
								 	 	noticeAlarm.className = 'list-group';
								 	 	noticeAlarm.innerHTML=`
												 <a href="#" class="list-group-item list-group-item-action list-group-item-light">
													\${content} 
												</a>
											`;
										alarmWrap.appendChild(noticeAlarm);
									}
								
								});
								
								document.querySelector("#bell").classList.add("fa-beat");
							}
						
						}
						
					});
				}; 
				
				</script>

			</sec:authorize>

		</header>