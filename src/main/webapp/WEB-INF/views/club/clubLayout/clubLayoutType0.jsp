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
			<button type="button" class="btn btn-danger" id="clubLike" onclick="clubLike('${domain}', '${pageContext.request.contextPath}')">❤️</button>
			<h5>🚩${clubInfo.clubName}</h5>
			<span class="fontColors">since 
				<fmt:parseDate value="${clubInfo.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
	    		<fmt:formatDate value="${createdAt}" pattern="yyyy.MM.dd"/>
			</span>
			<c:if test="${memberRole ne 10}">
				<span><a href="${pageContext.request.contextPath}/club/${domain}/clubMemberList.do">😀멤버 : ${clubInfo.memberCount}</a></span>
			</c:if>
			<c:if test="${memberRole eq 10}">
				<span>😀멤버 : ${clubInfo.memberCount}</span>
			</c:if>
		</div>
		<div id="club-myInfo-container" style="border-color: ${layout.pointColor}">
			<c:if test="${memberRole ne 10}">
				<div class="myProfile1" style="border-color: ${layout.pointColor}">
					<img alt="" src="${pageContext.request.contextPath}/resources/upload/member/profile/<sec:authentication property="principal.memberProfile.renamedFilename"/>">
				</div>
				<div class="myProfile2">
					<p><strong><sec:authentication property="principal.nickname"/></strong></p>
					<c:if test ="${memberRole eq 3}">
						<p><strong>🥇방장</strong></p>
						<a href="${pageContext.request.contextPath}/club/${domain}/clubUpdate.do">모임 관리</a>
					</c:if>
					<c:if test ="${memberRole eq 2}">
						<p><strong>🥇부방장</strong></p>
						<a href="${pageContext.request.contextPath}/club/${domain}/clubUpdate.do">모임 관리</a>
					</c:if>
					<c:if test ="${memberRole eq 1}">
						<p><strong>🥇임원</strong></p>
						<a href="${pageContext.request.contextPath}/club/${domain}/clubUpdate.do">모임 관리</a>
					</c:if>
					<c:if test ="${memberRole eq 0}">
						<p><strong>🎀일반회원</strong></p>
					</c:if>
				</div>
				<div class="myProfile3">
					<button id="boardCreateBtn" class="btn" 
						style="background-color: ${layout.fontColor}">글쓰기
					</button>
					<button id="scheduleCreateBtn" class="btn" 
						style="background-color: ${layout.fontColor}">일정생성
					</button>
				</div>
			</c:if>
			<c:if test="${memberRole eq 10}">
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
		<div id="club-total-container" class="fontColors" style="border-color: ${layout.pointColor}">
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
				<input name="" style="background-color: ${layout.backgroundColor}; border-color: ${layout.pointColor};"/>
				<button style="border-color: ${layout.pointColor};">검색</button>
			</form>
		</div>
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
			<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">
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
			<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">
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
			<div class="container-header" style="border-color: ${layout.pointColor}">
				<span class="fontColors">가입인사</span>
				<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">
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
	</div>
	
	<div id="club-reivew-container" class="preview-container">
		<div class="container-header" style="border-color: ${layout.pointColor}">
			<span class="fontColors">정모후기</span>
			<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">
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
	
	<div id="club-schedule-container" class="preview-container">
		<div class="container-header" style="border-color: ${layout.pointColor}">
			<span class="fontColors">일정</span>
			<a class="pointColors" href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">
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
    					<fmt:formatDate value="${startDate}" pattern="MM.dd"/>
    					~
    					<fmt:parseDate value="${schedule.endDate}" pattern="yyyy-MM-dd'T'HH:mm" var="endDate"/>
    					<fmt:formatDate value="${endDate}" pattern="MM.dd"/>
					</span>
					<a href="/" class="fontColors">
						${schedule.writer}
					</a>
				</div>
			</c:forEach>
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

	<c:if test="${memberRole ne 10 and memberRole lt 3}">
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


//모임 좋아요 (현우)
function clubLike(domain, contextPath) {
    // 찜 목록에 해당 클럽이 있는 지 확인.
    $.ajax({
        url: contextPath + "/club/clubLikeCheck.do",
        data: { domain },
        success(responseData) {
            if (responseData) {
                if (confirm("찜하신 모임을 취소하시겠습니까?")) {
                    document.deleteClubLikeFrm.submit();
                    alert("성공적으로 모임 찜을 취소했습니다.");
                }

            } else {

                if (confirm("모임을 찜 하시겠습니까?")) {
                    var clubLikeFrm = document.forms["clubLikeFrm"];
                    if (clubLikeFrm) {
                        clubLikeFrm.submit();
                        alert("성공적으로 모임 찜을 완료했습니다.");
                    } else {
                        console.log("Form not found");
                    }
                }

            }

        }
    });
	
	
}

</script>

<c:if test="${memberRole ne 10}">
	<script>
		scheduleCreateBtn.addEventListener('click', () => {
			location.href = "${pageContext.request.contextPath}/club/${domain}/scheduleCreate.do";
		});	
		
		boardCreateBtn.addEventListener('click', () => {
			location.href = "${pageContext.request.contextPath}/club/${domain}/clubBoardCreate.do";
		});	
	</script> 
</c:if>

