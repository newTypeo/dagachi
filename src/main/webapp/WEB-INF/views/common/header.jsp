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
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel" style="text-align: center; display: block; margin: 0 auto;">아이디 / 비밀번호 찾기</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      	<button type="button" class="btn btn-primary" style="text-align: center; display: block; margin: 0 auto;">아이디 찾기</button>
		      	<br/>
		        <button type="button" class="btn btn-success" style="text-align: center; display: block; margin: 0 auto;">비밀번호 찾기</button>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<sec:authorize access="isAnonymous()">
			<div id="header-nav-container">
				<a href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
				<span>|</span>
				<a href="${pageContext.request.contextPath}/member/memberCreate.do">회원가입</a>
				<span>|</span>
				<a href="#" class="open-modal-link">아이디/비밀번호찾기</a>
			</div>
		</sec:authorize>
			 
			 
		<sec:authorize access="isAuthenticated()">
			    <span>
			    <a title="<sec:authentication property="authorities"/>"><sec:authentication property="principal.username"/></a>님, 안녕하삼</span>
			    &nbsp;
			    <button type="button"onclick="document.memberLogoutFrm.submit();">로그아웃</button>
			    <button type="button"onclick="withdrawalMember();">회원탈퇴</button>
			    <form:form name="memberDeleteFrm" action="${pageContext.request.contextPath}/member/memberDelete.do" method="post"></form:form>
		</sec:authorize>
				<a href="${pageContext.request.contextPath}/member/memberAdminInquiryList.do">문의하기</a>
				
				<div class="modal" tabindex="-1">
				
		
		

	</header>
	
	<jsp:include page="/WEB-INF/views/common/navBar.jsp"></jsp:include>

<script>
const withdrawalMember = () => {
	if(confirm('정말로 탈퇴하시겠습니까?')){
		document.memberDeleteFrm.submit();
	}
};
</script>
<script>
  // 문서가 로드되면 실행될 스크립트
  document.addEventListener('DOMContentLoaded', function() {
    // 버튼 요소를 가져옵니다.
    var modalButton = document.querySelector('.btn-primary');
    // 모달 요소를 가져옵니다.
    var modal = new bootstrap.Modal(document.getElementById('exampleModal'));
    // 버튼을 클릭했을 때 모달을 열도록 이벤트 리스너를 추가합니다.
    modalButton.addEventListener('click', function() {
      modal.show(); // 모달을 표시합니다.
    });
  });
</script>
<script>
document.addEventListener('DOMContentLoaded', function() {
	  var modal = new bootstrap.Modal(document.getElementById('exampleModal'));
	  // a 태그를 가져옵니다.
	  var modalTriggerLink = document.querySelector('.open-modal-link');
	  // a 태그를 클릭했을 때 모달을 열도록 이벤트 리스너를 추가합니다.
	  modalTriggerLink.addEventListener('click', function(event) {
	    event.preventDefault(); // 링크의 기본 동작을 막습니다.
	    modal.show(); // 모달을 표시합니다.
	  });
	  // 모달 내부의 Close 버튼을 가져옵니다.
	  var closeButton = document.querySelector('.btn-secondary[data-bs-dismiss="modal"]');
	  // Close 버튼을 클릭했을 때 모달을 닫도록 이벤트 리스너를 추가합니다.
	  closeButton.addEventListener('click', function() {
	    modal.hide(); // 모달을 숨깁니다.
	  });
	});


</script>