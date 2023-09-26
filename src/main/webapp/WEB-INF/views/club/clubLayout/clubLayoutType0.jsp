<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layoutType0.css"/>

<article id="club-page-article">
	<div id="club-util-box">
		<div id="club-info-container">
			<button type="button" class="btn btn-danger" id="clubLike" onclick="clubLike()">❤️</button>
			<h5>🚩${clubDetail.clubName}</h5>
			<span class="fontColors">since 
				<fmt:parseDate value="${clubDetail.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
	    		<fmt:formatDate value="${createdAt}" pattern="yyyy.MM.dd"/>
			</span>
			<c:if test="${clubDetail.memberRole ne 10}">
				<span><a href="${pageContext.request.contextPath}/club/${domain}/clubMemberList.do">😀멤버 : ${clubDetail.memberCount}</a></span>
			</c:if>
			<c:if test="${clubDetail.memberRole eq 10}">
				<span>😀멤버 : ${clubDetail.memberCount}</span>
			</c:if>
		</div>
		<div id="club-myInfo-container" style="border-color: ${clubDetail.pointColor}">
			<c:if test="${clubDetail.memberRole ne 10}">
				<div class="myProfile1" style="border-color: ${clubDetail.pointColor}">
					<img alt="" src="${pageContext.request.contextPath}/resources/upload/member/profile/<sec:authentication property="principal.memberProfile.renamedFilename"/>">
				</div>
				<div class="myProfile2">
					<p><strong><sec:authentication property="principal.nickname"/></strong></p>
					<c:if test ="${clubDetail.memberRole eq 3}">
						<p><strong>🥇방장</strong></p>
						<a href="${pageContext.request.contextPath}/club/${domain}/clubUpdate.do">모임 관리</a>
					</c:if>
					<c:if test ="${clubDetail.memberRole eq 2}">
						<p><strong>🥇부방장</strong></p>
						<a href="${clubDetail.pageContext.request.contextPath}/club/${domain}/clubUpdate.do">모임 관리</a>
					</c:if>
					<c:if test ="${clubDetail.memberRole eq 1}">
						<p><strong>🥇임원</strong></p>
						<a href="${pageContext.request.contextPath}/club/${domain}/clubUpdate.do">모임 관리</a>
					</c:if>
					<c:if test ="${clubDetail.memberRole eq 0}">
						<p><strong>🎀일반회원</strong></p>
					</c:if>
				</div>
				<div class="myProfile3">
					<button id="boardCreateBtn" class="btn" style="background-color: ${clubDetail.fontColor}">글쓰기</button>
					<button id="scheduleCreateBtn" class="btn" style="background-color: ${clubDetail.fontColor}">일정생성</button>
				</div>
			</c:if>
			<c:if test="${clubDetail.memberRole eq 10}">
				<div>
					<button 
						class="btn btn-outline-success my-2 my-sm-0" 
						type="button" 
						onclick="location.href = '${pageContext.request.contextPath}/club/${domain}/clubEnroll.do'">
						가입신청하기
					</button>	
				</div>
			</c:if>
			
			
		</div>
		<div id="club-total-container" class="fontColors" style="border-color: ${clubDetail.pointColor}">
			<div>
				<a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=0">📄전체글보기</a>
			</div>
			<div>
				<a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">📢공지사항</a>
				<a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">🐳자유게시판</a>
				<a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">✋가입인사</a>
				<a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">🎉정모후기</a>
			</div>
			<div>
				<a href="${pageContext.request.contextPath}/club/${domain}/clubGallery.do">📷갤러리</a>
			</div>
			<div>
				<a href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">📅일정</a>
			</div>
		</div>
		<div id="club-search-container1">
			<form action="">
				<input name="" style="background-color: ${clubDetail.backgroundColor}; border-color: ${clubDetail.pointColor};"/>
				<button style="border-color: ${clubDetail.pointColor};">검색</button>
			</form>
		</div>
	</div>
	
	<div id="club-main-container">
		<div id="club-main-image-container">
			<img src="${pageContext.request.contextPath}/resources/upload/club/main/${clubDetail.mainImage}">
		</div>
		<div id="club-main-content-container">
			<p class="fontColors">${clubDetail.mainContent}</p>
		</div>
	</div>
	
	<div id="club-notice-container" class="preview-container">
		<div class="container-header" style="border-color: ${clubDetail.pointColor}">
			<span class="fontColors">공지사항</span>
			<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main container-main-long boardType4">
			
		</div>
	</div>
	
	<div id="club-board-container" class="preview-container">
		<div class="container-header" style="border-color: ${clubDetail.pointColor}">
			<span class="fontColors">자유게시판</span>
			<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main container-main-short boardType1">
		
		</div>
	</div>
	
	<div>
		<div id="club-gallery-container" class="preview-container">
			<div class="container-header" style="border-color: ${clubDetail.pointColor}">
				<span class="fontColors">갤러리</span>
				<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubGallery.do">
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
			<div class="container-header" style="border-color: ${clubDetail.pointColor}">
				<span class="fontColors">가입인사</span>
				<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">
					더보기<i class="fa-solid fa-angle-right"></i>
				</a>
			</div>
			<div class="container-main container-main-short boardType3">
				
			</div>
		</div>
	</div>
	
	<div id="club-reivew-container" class="preview-container">
		<div class="container-header" style="border-color: ${clubDetail.pointColor}">
			<span class="fontColors">정모후기</span>
			<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main container-main-short boardType2">
			
		</div>
	</div>
	
	<div id="club-schedule-container" class="preview-container">
		<div class="container-header" style="border-color: ${clubDetail.pointColor}">
			<span class="fontColors">일정</span>
			<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">
				더보기<i class="fa-solid fa-angle-right"></i>
			</a>
		</div>
		<div class="container-main-schedule scheduleType">
				
		</div>
	</div>
</article>

<form:form
		name="clubLikeFrm"
		action="${pageContext.request.contextPath}/club/clubLike.do"
		method="POST">
			<input type="hidden" id="memberId" name="memberId" value="${memberId}">
			<input type="hidden" id="domain" name="domain" value="${domain}">
</form:form>

<form:form
		name="deleteClubLikeFrm"
		action="${pageContext.request.contextPath}/club/deleteClubLike.do"
		method="POST">
			<input type="hidden" id="memberId" name="memberId" value="${memberId}">
			<input type="hidden" id="domain" name="domain" value="${domain}">
</form:form>

<nav style="display: flex; flex-direction: row-reverse;">

	<c:if test="${clubDetail.memberRole ne 10 and clubDetail.memberRole lt 3}">
		<button type="button" onclick="clubMemberDelete();" class="btn btn-danger">😿모임탈퇴</button>
	</c:if>
	<form:form 
		name="clubMemberDeleteFrm"
		action="${pageContext.request.contextPath}/club/${domain}/clubMemberDelete.do"
		method = "post">
	</form:form>
	<c:if test="${not empty clubAdminMsg}">
		<script>
			alert('${clubAdminMsg}');
			<%session.removeAttribute("clubAdminMsg");%>
		</script>
	</c:if>
	&nbsp;
	<button type="button" class="btn btn-danger" id="clubReport">🚨모임 신고하기</button>
</nav>

<script>
const clubMemberDelete = () => {
	if(confirm("모임을 정말 탈퇴하시겠습니까?")) {
		document.clubMemberDeleteFrm.submit();
	}
}

//창환(모임 신고)
document.querySelector("#clubReport").onclick = () => {
	console.log('Type0');
	$("#reportModal")
	.modal()
	.on('shown.bs.modal', () => {
	});
};

// 창환(모임 신고)
const clubReportSubmit = () => {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	const domain = document.querySelector('#domain').value;
	const reporter = document.querySelector('#reporter').value;
	const reason = document.querySelector('#reason').value;
	
	if(reason == null || reason == '') {
		alert('신고 내용을 입력해주세요');
		return;
	}
	
	$.ajax({
		url : '${pageContext.request.contextPath}/club/${domain}/clubReport.do',
		method : "post",
		data : { domain, reporter, reason },
		beforeSend(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	
	document.querySelector('#reason').value = ''; // 신고사유 초기화
};



document.addEventListener('DOMContentLoaded', function() {
	clubBoardLoadFtn(1, 14);
	clubBoardLoadFtn(2, 9);
	clubBoardLoadFtn(3, 6);
	clubBoardLoadFtn(4, 5);
	clubScheduleLoadFtn();
});

const clubBoardLoadFtn = (type, length) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/club/${domain}/clubBoardLoad.do",
		data : {type: parseInt(type), length: parseInt(length)},
		success(responseData) {
			const targetDiv = document.querySelector(".boardType" + type);
			targetDiv.innerHTML = "";
			if (type == 4) {
				responseData.forEach((board) => {
					const {boardId, title, createdAt, likeCount, nickname} = board;
					var _likeCount = 0;
					if (likeCount < 100) {
						_likeCount = likeCount;
					} else {
						_likeCount = 99;
					}
					var _createdAt = createdAt.substring(0,10).replaceAll("-", ".");
					targetDiv.innerHTML += `
						<div>
							<span class="badge badge-danger">공지</span>
							<a class="fontColors" href="${pageContext.request.contextPath}/club/sportsclub/boardDetail.do?no=\${boardId}">\${title}</a>
							<span>\${_createdAt}</span>
							<span>❤\${_likeCount}</span>
							<a href="/" class="fontColors">
								\${nickname}
							</a>
						</div>
					`;
				});
			} else {
				responseData.forEach((board) => {
					const {boardId, title, createdAt, likeCount, nickname} = board;
					var _likeCount = 0;
					if (likeCount < 100) {
						_likeCount = likeCount;
					} else {
						_likeCount = 99;
					}
					var _createdAt = createdAt.substring(0,10).replaceAll("-", ".");
					targetDiv.innerHTML += `
						<div>
							<span class="pointColors">·</span>
							<a class="fontColors" href="${pageContext.request.contextPath}/club/sportsclub/boardDetail.do?no=\${boardId}">\${title}</a>
							<span>\${_createdAt}</span>
							<span>❤\${_likeCount}</span>
							<a href="/" class="fontColors">
								\${nickname}
							</a>
						</div>
					`;
				});
			}
		}
	});
}

const clubScheduleLoadFtn = () => {
	$.ajax({
		url: '${pageContext.request.contextPath}/club/${domain}/getSchedules.do',
		success(schedules) {
			const targetDiv = document.querySelector(".scheduleType");
			targetDiv.innerHTML = "";
			console.log(schedules);
			schedules.forEach((schedule) => {
				const {title, memberCount, capacity, startDate, endDate, nickname} = schedule;
				var _startDate = startDate.substring(0,10).replaceAll("-", ".");
				var _endDate = endDate.substring(0,10).replaceAll("-", ".");
				targetDiv.innerHTML += `
					<div>
						<span class="pointColors">·</span>
						<a class="fontColors">\${title}</a>
						<span>👩🏻‍🤝‍🧑🏻\${memberCount}/\${capacity}</span>
						<span>
							\${_startDate}~\${_endDate}
						</span>
						<a href="/" class="fontColors">
							\${nickname}
						</a>
					</div>
				`;
			});
		}
	});
}


const clubLike = () => {
	//모임 좋아요 (현우)
		// 찜 목록에 해당클럽이 있는 지 확인.
		const domain = "${domain}";
		$.ajax({
			url : "${pageContext.request.contextPath}/club/clubLikeCheck.do",
			data : {domain},
			success(responseData) {
				console.log(responseData);
				if (responseData) {
					if(confirm("찜하신 모임을 취소하시겠습니까?")) {
						document.deleteClubLikeFrm.submit();
						alert("성공적으로 모임 찜을 취소했습니다.");
					}
					
				} else {
					
					if(confirm("모임을 찜 하시겠습니까?")) {
				    	document.clubLikeFrm.submit();
						alert("성공적으로 모임 찜을 완료했습니다.");
					} 
				}
				
			}
					
		});
	}

</script>

<c:if test="${clubDetail.memberRole ne 10}">
	<script>
		scheduleCreateBtn.addEventListener('click', () => {
			location.href = "${pageContext.request.contextPath}/club/${domain}/scheduleCreate.do";
		});	
		
		boardCreateBtn.addEventListener('click', () => {
			location.href = "${pageContext.request.contextPath}/club/${domain}/clubBoardCreate.do";
		});	
	</script> 
</c:if>

