<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>

<nav id="club-banner" class="bg-primary">
	<h2>title : 소모임 별 배너
		<button id="clubDisabled">모임 비활성화</button>
		<button>모임 수정</button>
	</h2>
	
	
	
</nav>

<nav>
	<h3>메뉴 바</h3>
	<a href="${pageContext.request.contextPath}/club/&${domain}/clubBoardList.do">게시판</a>
	<a href="${pageContext.request.contextPath}/club/&${domain}/chatRoom.do">채팅</a>
	<a href="${pageContext.request.contextPath}/club/&${domain}/manageMember.do">회원관리</a>
</nav>

<section id="club-page-sec" class="p-2 bg-danger">
	<h1>메인 페이지</h1>
	
	
</section>
<script>
// 준한(모임 비활성화)
document.querySelector("#clubDisabled").onclick = (e) => {
    // 경고창을 띄웁니다.
    const userConfirmation = confirm("정말 비활성화 하시겠습니까?");
    
    // 확인 버튼을 눌렀을 경우에만 컨트롤러로 이동시킵니다.
    if (userConfirmation) {
        // 여기에 컨트롤러로 이동하는 코드를 추가하세요.
        // 예를 들어, 페이지 리디렉션을 사용할 수 있습니다.
        window.location.href = "${pageContext.request.contextPath}/club/clubDisabled.do";
    }
};
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>