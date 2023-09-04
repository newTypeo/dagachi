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


<section id="main-page-sec" class="p-2">
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

	<nav id="club-nav-bar" style="border-color: ${layout.pointColor}; width: 1320px;">
		<h5><a href="${pageContext.request.contextPath}/club/${domain}">🚩${clubName}</a></h5>
		<div class="fontColors">
			<ul>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">📢공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">🐳자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">✋가입인사</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">🎉정모후기</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubGallery.do">📷갤러리</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">📅일정</a></li>
			</ul>
		</div>
    </nav>

	<c:if test ="${empty clubMembers}">
		<h1>회원이 없습니다.</h1>
	</c:if>

	<section id = "class">
		<div class ="posts" style="display : flex">
			<c:if test ="${not empty clubMembers}">
				<c:forEach items="${clubMembers}" var="member" varStatus="vs">
				
					<a class="card" style="width: 180px; margin:19px;" href = "${pageContext.request.contextPath}/member/${member.memberId}">
					  <img src="${pageContext.request.contextPath}/resources/upload/member/profile/${member.renamedFilename}" 
					  class="card-img-top" alt="..." style="width:180px; height:180px;">
					  <%-- <div class="card-body">
					    <p class="card-title">${member.nickname}</p>
					  </div>  --%>
					  <ul class="list-group list-group-flush">
					    <li style="list-style: none; margin: 3px auto;">${member.nickname}</li>
					  </ul>
					</a>
				</c:forEach>
			</div>
		</section>
	</c:if>
</section>

<script>
//레이아웃 및 네브바
document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>