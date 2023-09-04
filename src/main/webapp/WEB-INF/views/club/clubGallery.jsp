<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp">
	<jsp:param value="게시글" name="title" />
</jsp:include>
<style>
.insertGallery-div{
	position : absolute;
	margin-left :1230px;

}
#club-detail-gallery{
	display: flex;
    width: 1320px;
    margin: 30px;
    flex-wrap: wrap;
}



#gallery-photo {
    height: 295px;
    width: 295px;
}

#gallery-photo-div{
	height: 295px;
    width: 295px;
    margin: 10px;
}
#like-count{
	
	margin-top : 10px;
	position: absolute;
 	z-index: 2; /* 두 번째 요소는 더 위에 위치 */
}
	

}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>
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
	
	<div class= insertGallery-div>
	<button onclick = "insertGallery()">사진 올리기</button>
	</div>
	<div id = "club-detail-gallery">
		<c:forEach items="${clubGalleryAndImages}" var="clubGalleryAndImage" >
				<a href="${pageContext.request.contextPath}/club/${domain}/${clubGalleryAndImage.galleryId}">
				<div id="gallery-photo-div">
					<div id="like-count">
						<h3 style="display:inline">💕${clubGalleryAndImage.likeCount}<h3>
					</div>
					<img src="${pageContext.request.contextPath}/resources/upload/club/gallery/${clubGalleryAndImage.renamedFilename}" class="rounded mx-auto d-block" alt="..." id="gallery-photo">
				</div>
				</a>
		</c:forEach>
	</div>
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


const insertGallery = () => {
	window.location.href = "${pageContext.request.contextPath}/club/${domain}/clubGalleryInsert.do"
};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>