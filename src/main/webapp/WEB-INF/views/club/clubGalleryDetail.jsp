<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글" name="title" />
</jsp:include>
<c:forEach items="${galleryAndImages}" var="image" varStatus="vs">
	<figure class="figure">
	  <img src="${pageContext.request.contextPath}/resources/upload/club/gallery/${image.renamedFilename}" class="figure-img img-fluid rounded" alt="...">
	</figure>
  <h1>❤${image.likeCount}</h1>
</c:forEach>
<button>수정</button>

<c:if test="${writer == loginMember.memberId}"> <!-- 첨부파일 작성자와 로그인 객체가 같을 때 -->
	<button onclick = "deleteGallery()">삭제</button>
</c:if>

<script>
const deleteGallery = () => {
	window.location.href = "${pageContext.request.contextPath}/club/${domain}/${id}/clubGalleryDelete.do"
};
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>