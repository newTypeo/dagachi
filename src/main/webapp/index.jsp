<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


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
	<section id="class">
	   <div class="posts">
	   	 <a class="card" href="${pageContext.request.contextPath}/club/clubDetail.do" }>
             첫번째 샘플
          </a>
          <a class="card" href="/dagachi/news/newsDetail?no=\${newsNo}">
             두번째 샘플
          </a>
          <a class="card" href="/dagachi/news/newsDetail?no=\${newsNo}">
             세번째 샘플
          </a>
	   </div>
	   
   	<div id='btn-more-container'>
   </div>
</section>
	
	
	
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>