<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp">
	<jsp:param value="게시글" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>
<style>
	.figure-div{
		display: flex;
	  justify-content: center; /* 가로 방향 가운데 정렬 */
	  align-items: center; /* 세로 방향 가운데 정렬 */
	}
	
	.btn-div{
	margin-left :1630px;
	margin-top : 100px;
	}
</style>
<section>
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
	
	<nav id="club-nav-bar" style="border-color: ${layout.pointColor}">
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
	
	<c:forEach items="${galleryAndImages}" var="image" varStatus="vs">
		<div class="figure-div">
		<figure class="figure">
		  <img src="${pageContext.request.contextPath}/resources/upload/club/gallery/${image.renamedFilename}" class="figure-img img-fluid rounded" alt="...">
		</figure>
		</div>
		</c:forEach>
		
		<div class="btn-div">
	 	 <h1>❤${image.likeCount}</h1>
		<button>수정</button>
		
	
	<c:if test="${writer == loginMember.memberId}"> <!-- 첨부파일 작성자와 로그인 객체가 같을 때 -->
		<button onclick = "deleteGallery()">삭제</button>
	</c:if>
	</div>
</section>

<script>
document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";

const deleteGallery = () => {
	window.location.href = "${pageContext.request.contextPath}/club/${domain}/${id}/clubGalleryDelete.do"
};
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>