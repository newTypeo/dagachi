<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<title>다가치</title>


<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
</head>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="class2">
<div class="with-flex">
<figure class="snip0045 red">
	<figcaption>
		<h2>
			<span>${member.name}</span>
		</h2>
		<p>닉네임 : ${member.nickname}</p>
		<p>성별 : ${member.gender eq 'M' ? '남' : '여'}</p>
		<p>이메일 :  ${member.email}</p>
		<p>MBTI : ${member.mbti}</p>
		<div class="icons">
			<button onclick="payment();">모임 생성 1회권 결제</button>
			<c:if test="${member.memberId eq loginMember.memberId}">
				<!-- 로그인한 객체가 보고있는 객체가 같을 때 -->
				<button onclick="updateMember()">회원 정보 수정</button>
				<button type="button" onclick="withdrawalMember();">회원탈퇴</button>
				<form:form 
					name="memberDeleteFrm"
					action="${pageContext.request.contextPath}/member/memberDelete.do"
					method="post">
				</form:form>
			</c:if>
		</div>
	</figcaption>
	<img
		src="${pageContext.request.contextPath}/resources/upload/member/profile/${memberProfile.renamedFilename}"
		alt="sample7" style="width: 260px; height: 280px;" />
	<div class="position">My Profile</div>
</figure>
 <div class="container2">
	 <c:if test="${member.memberId eq loginMember.memberId}">
	       <div class="row justify-content-center2">
	           <div class="col-md-8-2">
	               <div class="profile-card2">
	                   <div class="liked-members-title">
	                       <h2>나를 좋아한 회원</h2>
	                   </div>
	                   
	                   <div class="liked-members-list">
	                       <ul>
	                       	<c:forEach items="${likeMe}" var="like" varStatus="vs">
	                           <li><a href="${pageContext.request.contextPath}/member/${like.likeSender}">❤️ ${like.likeSender}</a></li>
	                         </c:forEach>
	                       </ul>
	                   </div>
	               </div>
	           </div>
	       </div>
	   </c:if>
	   	<c:if test="${member.memberId ne loginMember.memberId}">
			<!-- 로그인한 객체가 보고있는 객체가 다를 때 -->
			<button type="button" class="btn btn-outline-danger"
			onclick="memberLike()">좋아요</button>
		</c:if>
   </div>
</div>

<c:if test="${member.memberId ne loginMember.memberId}">
	<!-- 로그인한 객체가 보고있는 객체가 다를 때 -->
	<button type="button" class="btn btn-outline-danger"
		onclick="memberLike()">좋아요</button>
</c:if>

<form:form name="memberLikeFrm" method="POST"
	action="${pageContext.request.contextPath}/member/memberLike.do">
	<input type="hidden" id="memberId" name="memberId"
		value="${member.memberId}" />
</form:form>

	<c:if test="${member.memberId eq loginMember.memberId}">
		<!-- 로그인한 객체가 보고있는 객체가 같을 때 -->
		<h1>최근 본 모임</h1>
		<c:if test="${empty clubAndImages}">
			<h1>최근 조회하신 모임이 없습니다.</h1>
		</c:if>

		<c:if test="${not empty clubAndImages}">
			<div class="posts2">
				<c:forEach items="${clubAndImages}" var="clubAndImage"
					varStatus="vs">
					<a class="card" style="width: 18rem;"
						href="${pageContext.request.contextPath}/club/${clubAndImage.domain}">
						<img
						src="${pageContext.request.contextPath}/resources/upload/club/profile/${clubAndImage.renamedFilename}"
						class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">${clubAndImage.clubName}</h5>
						</div>
						<ul class="list-group list-group-flush">
							<li class="list-group-item">${clubAndImage.introduce}</li>
							<li class="list-group-item">${clubAndImage.category}</li>
						</ul>
					</a>
				</c:forEach>
			</div>
		</c:if>
	</c:if>

	<h1>가입 되어있는 모임</h1>
	<c:if test="${empty joinClub}">
		<h1>최근 조회하신 모임이 없습니다.</h1>
	</c:if>

	<c:if test="${not empty joinClub}">
		<div class="posts2">
			<c:forEach items="${joinClub}" var="joinClub" varStatus="vs">
				<a class="card" style="width: 18rem;"
					href="${pageContext.request.contextPath}/club/${joinClub.domain}">
					<img
					src="${pageContext.request.contextPath}/resources/upload/club/profile/${joinClub.renamedFilename}"
					class="card-img-top" alt="...">
					<div class="card-body">
						<h5 class="card-title">${joinClub.clubName}</h5>
					</div>
					<ul class="list-group list-group-flush">
						<li class="list-group-item">${joinClub.introduce}</li>
						<li class="list-group-item">${joinClub.category}</li>
					</ul>
				</a>
			</c:forEach>
		</div>
	</c:if>

	<h1>찜 되어있는 모임</h1>
	<c:if test="${empty clubLikeAndImages}">
		<h1>찜하신 모임이 없습니다.</h1>
	</c:if>

	<c:if test="${not empty clubLikeAndImages}">
		<div class="posts2">
			<c:forEach items="${clubLikeAndImages}" var="clubLikeAndImage"
				varStatus="vs">
				<a class="card" style="width: 18rem;"
					href="${pageContext.request.contextPath}/club/${clubLikeAndImage.domain}">
					<img
					src="${pageContext.request.contextPath}/resources/upload/club/profile/${clubLikeAndImage.renamedFilename}"
					class="card-img-top" alt="...">
					<div class="card-body">
						<h5 class="card-title">${clubLikeAndImage.clubName}</h5>
					</div>
					<ul class="list-group list-group-flush">
						<li class="list-group-item">${clubLikeAndImage.introduce}</li>
						<li class="list-group-item">${clubLikeAndImage.category}</li>
					</ul>
				</a>
			</c:forEach>
		</div>
	</c:if>
</section>
<br />
<br />
<br />
<h1>작성한 글</h1>
<br />
<br />
<br />
<h1>작성한 댓글</h1>
<br />
<br />
<br />

<script>
/* 화면의 width, height 값 구하기 (창환)*/
const windowWidth = window.screen.width;
const windowHeight = window.screen.height;

/* popup 가운데 맞추기 (창환) */
const popupWidth = 500;
const popupHeight = 700;

const popupX = (windowWidth/2) - (popupWidth/2);
const popupY = (windowHeight/2) - (popupHeight/2);



const withdrawalMember = () => {
	if(confirm('정말로 탈퇴하시겠습니까?')){
		document.memberDeleteFrm.submit();
	}
};


const payment = () => {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		url: "${pageContext.request.contextPath}/payment/ready",
		method : "post",
		beforeSend(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(response) {
			console.log(response);
			const url = response.next_redirect_pc_url;
			window.open(url, "_blank", 'status=no, width=500, height=700' + 
						', left=' + popupX + ', top=' + popupY);
		}
	});
};


const memberLike = () => {
	//console.log("잘 되는감?");
	const memberLikeFrm = document.memberLikeFrm;
	console.log(memberLikeFrm);
	memberLikeFrm.submit();
}

const updateMember = () => {
	window.location.href = "${pageContext.request.contextPath}/member/memberUpdate.do" 
};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>