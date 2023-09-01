<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글" name="title" />
</jsp:include>
<style>
.insertGallery-div{
	position : absolute;
	margin-left :1630px;
	margin-top : 100px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layoutType0.css"/>
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


<script>
const insertGallery = () => {
	window.location.href = "${pageContext.request.contextPath}/club/${domain}/clubGalleryInsert.do"
};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>