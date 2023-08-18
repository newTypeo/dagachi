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
	
	<form id="clubSearchFrm" action="${pageContext.request.contextPath}/club/clubSearch.do">
		<span>
			<input type="text" name="inputText" placeholder="검색할 모임 입력"/>
		</span>
		<button>모임검색</button>
	</form>
	<button>모임생성</button>
	
	
	<section id="class">
	   <div class="posts">
	   
	   </div>
	   
	</section>
	
</section>
<script>

// 메인페이지에 모임카드 전체 출력(준한)
$.ajax({
	url : "${pageContext.request.contextPath}/club/clubList.do",
	success(clubs){
		const container = document.querySelector(".posts");
		
		clubs.forEach((clubAndImage)=>{
			const{clubName, category, status, reportCount, introduce, domain, renamedFilename, memberCount} = clubAndImage;
			
			container.innerHTML += `
				<a class="card" href="${pageContext.request.contextPath}/club/&\${domain}">
	                <div class="card-inner">
	                   <figure class="card-thumbnail">
	                      <img src="${pageContext.request.contextPath}/resources/upload/profile/\${renamedFilename}">
	                   </figure>
	                   <div class="card-body">
	                      <h3 class="card-title">\${clubName}</h3>
	                      <span class="card-introduce">\${introduce}</span>
	                      <h4 class="club-member-cnt">인원수 : \${memberCount}</h4>
	                   </div>
	                </div>
	             </a>
				`;
			})
		}
	});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>