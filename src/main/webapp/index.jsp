<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/chatBtn.jsp"></jsp:include>



<nav id="main-banner" class="bg-warning">
	<h1>배너</h1>
</nav>
<nav>
	<a href="${pageContext.request.contextPath}/admin/adminMemberList.do">회원조회(관리자)</a>
	<a href="${pageContext.request.contextPath}/admin/adminClubList.do">모임목록(관리자)</a>
</nav>
<nav id="main-category" class="bg-success">
	<h3>카테고리</h3>
	<div>
		<a href="${pageContext.request.contextPath}/category/game">게임</a>
		<a href="${pageContext.request.contextPath}/category/trip">여행</a>
		<a href="${pageContext.request.contextPath}/category/sports">운동</a>
		<a href="${pageContext.request.contextPath}/category/guitar">기타등등 나중에 추가해</a>
	</div>
</nav>

<section id="main-page-sec" class="p-2 bg-info">
	<h1>메인 페이지</h1>

	
	<section id="class">
	   <div class="posts">
	   
	   </div>
	   
	</section>
	
</section>
<script>



$.ajax({
	url : "${pageContext.request.contextPath}/club/clubList.do",
	success(clubs){
		const container = document.querySelector(".posts");
		
		clubs.forEach((clubAndImage)=>{
			const{clubName, category, status, reportCount, introduce, domain, renamedFilename, memberCount} = clubAndImage;
			
			container.innerHTML += `
				<div class="card" style="width: 18rem;" href="${pageContext.request.contextPath}/club/&\${domain}">
				  <img src="${pageContext.request.contextPath}/resources/upload/profile/\${renamedFilename}" class="card-img-top" alt="...">
				  <div class="card-body">
				    <h5 class="card-title">\${clubName}</h5>
				    <p class="card-text">\${introduce}</p>
				  </div>
				  <ul class="list-group list-group-flush">
				    <li class="list-group-item">\${category}</li>
				    <li class="list-group-item">인원수 : \${memberCount}</li>
				  </ul>
				</div>
			`;
		})
		
	}
});



</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>