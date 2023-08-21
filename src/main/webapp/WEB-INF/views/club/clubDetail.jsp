<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>
<section>
	<nav id="club-title" class="">
		
		<c:if test="${layout.title eq null}">
			<div id="default-title">
				<h2>${domain}</h2>
			</div>
		</c:if>
		
		<c:if test="${layout.title ne null}">
			<img src="${pageContext.request.contextPath}/resources/upload/clubTitle/${layout.title}">
		</c:if>
	
	</nav>
	
	<nav>
		<button id="clubDisabled">모임 비활성화</button>
		<button id="club-update-btn">모임 수정</button>
	</nav>
	
	<nav>
		<h3>메뉴 바</h3>
		<a href="${pageContext.request.contextPath}/club/&${domain}/clubBoardList.do">게시판</a>
		<a href="${pageContext.request.contextPath}/club/&${domain}/chatRoom.do">채팅</a>
		<a href="${pageContext.request.contextPath}/club/&${domain}/manageMember.do">회원관리</a>
	</nav>
	
	<article id="club-page-article">
		<div id="club-main-container">
			<div id="club-main-image-container">
				<img src="${pageContext.request.contextPath}/resources/upload/clubMain/${layout.mainImage}">
			</div>
			<div id="club-main-content-container">
				<p style="color: ${layout.fontColor}">${layout.mainContent}</p>
			</div>
		</div>
		
		<div id="club-notice-container">
			<p style="color: ${layout.pointColor}">공지</p>
		</div>
		
		<div id="club-gallery-container">
			<span>갤러리</span>
		</div>
		
		<div id="club-board-container">
			<span>게시판</span>
		</div>
		
		<div id="club-schedule-container">
			<span>일정</span>
		</div>
	</article>
</section>

<script>
// 준한(모임 비활성화)
	const domain = "<%= request.getAttribute("domain") %>"; // 서버 사이드에서 domain 값을 가져와서 설정
    document.querySelector("#clubDisabled").onclick = (e) => {
        const userConfirmation = confirm("정말 비활성화 하시겠습니까?");
        if (userConfirmation) {
            // 도메인 값을 사용하여 컨트롤러로 이동하는 코드를 추가
            window.location.href = "${pageContext.request.contextPath}/club/&" + domain + "/clubDisabled.do";
            alert('모임이 성공적으로 비활성화 되었습니다.');
        }
    };
    
document.querySelector("#club-update-btn").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/&'+domain+'/clubUpdate.do';
}

console.log('${layout}');
document.body.style.background = '${layout.backgroundColor}';
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>