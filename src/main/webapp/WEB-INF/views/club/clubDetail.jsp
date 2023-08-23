<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>
             


<section>


	<button 
		class="btn btn-outline-success my-2 my-sm-0" 
		type="button" 
		onclick="location.href = '${pageContext.request.contextPath}/club/${domain}/clubEnroll.do'">
		가입신청하기
	</button>
	
	
		<nav id="club-title" class="">
		<c:if test="${layout.title eq null}">
			<div id="default-title">
				<h2>${domain}</h2>
			</div>
		</c:if>
		
		<c:if test="${layout.title ne null}">
			<img src="${pageContext.request.contextPath}/resources/upload/club/title/${layout.title}">
		</c:if>
	
	</nav>
	
	<nav id="club-button">
		<!-- 방장일 경우에 -->
		<c:if test ="${memberRole eq 3}">
			<button type="button" class="btn btn-success" id="club-update-btn">모임 정보 수정</button>
			<button type="button" class="btn btn-danger" id="clubDisabled">모임 삭제</button>
			<button type="button" class="btn btn-warning" id="club-style-update">모임 스타일 설정</button>
		</c:if>
		<!-- 관리자일 경우에 -->
		<c:if test = "${memberId eq 'admin'}">
			<button type="button" class="btn btn-danger" id="clubDisabled">모임 비활성화</button>
		</c:if>
		
		<a href ="${pageContext.request.contextPath}/club/${domain}/clubMemberList.do">모임내 회원조회</a>
	</nav>
	
	<nav>
		<h3>메뉴 바</h3>
		<a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do">게시판</a>
		<a href="${pageContext.request.contextPath}/club/${domain}/chatRoom.do">채팅</a>
		<a href="${pageContext.request.contextPath}/club/${domain}/manageMember.do">회원관리</a>
	</nav>
	
	<%-- <jsp:include page="/WEB-INF/views/club/clubLayout/clubLayoutType${layout.type}.jsp"></jsp:include> --%>
	<jsp:include page="/WEB-INF/views/club/clubLayout/clubLayoutType0.jsp"></jsp:include>
	
</section>

<script>
// 준한(모임 비활성화)
	const domain = "<%= request.getAttribute("domain") %>"; // 서버 사이드에서 domain 값을 가져와서 설정
    document.querySelector("#clubDisabled").onclick = (e) => {
        const userConfirmation = confirm("정말 비활성화 하시겠습니까?");
        if (userConfirmation) {
            // 도메인 값을 사용하여 컨트롤러로 이동하는 코드를 추가
            window.location.href = "${pageContext.request.contextPath}/club/" + domain + "/clubDisabled.do";
            alert('모임이 성공적으로 비활성화 되었습니다.');
        }
    };
    
document.querySelector("#club-update-btn").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubUpdate.do';
}

document.querySelector("#club-style-update").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubStyleUpdate.do';
}

console.log('${layout}');
document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});
console.log("${layout.font}")
document.body.style.fontFamily = "${layout.font}";
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>