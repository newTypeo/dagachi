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

<h1>${club.clubName} 의 회원 List</h1>
<section id="main-page-sec" class="p-2 bg-info">

	<c:if test ="${empty members}">
		<h1>회원이 없습니다.</h1>
	</c:if>

	<section id = "class">
		<div class ="posts" style="display : flex">
			<c:if test ="${not empty members}">
				<c:forEach items="${members}" var="member" varStatus="vs">
					<a class="card" style="width: 18rem; margin:19px;" href = "나중에">
					  <img src="..." class="card-img-top" alt="...">
					  <div class="card-body">
					    <h5 class="card-title">${member.nickname}</h5>
					  </div>
					  <ul class="list-group list-group-flush">
					    <li class="list-group-item">${member.name}</li>
					    <li class="list-group-item">${member.gender}</li>
					    <li class="list-group-item">${member.mbti}</li>
					  </ul>
					</a>
				</c:forEach>
			</div>
		</section>
	</c:if>
</section>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>