<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/chatBtn.jsp"></jsp:include>



<nav id="main-banner" class="bg-warning">
	<h1>배너</h1>
</nav>
<nav>
	<a href="${pageContext.request.contextPath}/admin/adminMemberList.do?keyword=&column=">회원조회(관리자)</a>
	<a href="${pageContext.request.contextPath}/admin/adminQuitMemberList.do?keyword=&column=">탈퇴회원조회(관리자)</a>
	<a href="${pageContext.request.contextPath}/admin/adminReportMemberList.do?keyword=&column=">신고회원조회(관리자)</a>
	<a href="${pageContext.request.contextPath}/admin/adminClubList.do?keyword=&column=">모임목록(관리자)</a>
</nav>

<section id="main-page-sec" class="p-2 bg-info">
	<h1>메인 페이지</h1>

	
	
	    <sec:authorize access="isAnonymous()">
	    <section id="class">
	   		<div class="posts">
	   			<script>
		   		// card의 div태그 a태그로 교체함 - 동찬
		   			$.ajax({
	
		   				url : "${pageContext.request.contextPath}/club/clubList.do",
		   				success(clubs){
		   					const container = document.querySelector(".posts");
		   					
		   					clubs.forEach((clubAndImage)=>{
		   						const { clubName, category, status, reportCount, introduce, domain, renamedFilename, memberCount } = clubAndImage;
		   						if (status !== false) {
		   							
		   							container.innerHTML += `
		   								<a class="card" style="width: 18rem;" href="${pageContext.request.contextPath}/club/&\${domain}">
		   								  <img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${renamedFilename}" class="card-img-top" alt="...">
		   								  <div class="card-body">
		   								    <h5 class="card-title">\${clubName}</h5>
		   								    <p class="card-text">\${introduce}</p>
		   								  </div>
		   								  <ul class="list-group list-group-flush">
		   								    <li class="list-group-item">\${category}</li>
		   								    <li class="list-group-item">인원수 : \${memberCount}</li>
		   								  </ul>
		   								</a>
		   							`;
		   						}
		   					});
		   				}
		   			});
	   			</script>
	   		</div>
		</section>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
		<section id="class2">
	   		<div class="posts2">
	   		<script>
	   		$.ajax({
	   			url : "${pageContext.request.contextPath}/club/loginClubList.do",
	   			success(clubs){
	   				const container = document.querySelector(".posts2");
	   				
	   				clubs.forEach((clubAndImage)=>{
	   					const { clubName, category, status, reportCount, introduce, domain, renamedFilename, memberCount } = clubAndImage;
	   					if (status !== false) {
	   						
	   						container.innerHTML += `
	   							<a class="card" style="width: 18rem;" href="${pageContext.request.contextPath}/club/&\${domain}">
	   							<img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${renamedFilename}" class="card-img-top" alt="...">
	   							  <div class="card-body">
	   							    <h5 class="card-title">\${clubName}</h5>
	   							    <p class="card-text">\${introduce}</p>
	   							  </div>
	   							  <ul class="list-group list-group-flush">
	   							    <li class="list-group-item">\${category}</li>
	   							    <li class="list-group-item">인원수 : \${memberCount}</li>
	   							  </ul>
	   							</a>
	   						`;
	   					}
	   				});
	   			}
	   		});
	   		</script>
	   		</div>
		</section>
		</sec:authorize>
	   
	
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>