<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>
<section>
	<h1>클럽관리</h1>
	<c:if test ="${memberRole eq 3}">
		<button type="button" class="btn btn-success" id="club-update-btn">모임 정보 수정</button>
		<button type="button" class="btn btn-warning" id="club-style-update">모임 스타일 설정</button>
		<button type="button" class="btn btn-info" id="club-title-update">모임 타이틀 설정</button>
		<button type="button" class="btn btn-danger" id="clubDisabled">모임 해산</button>
	</c:if>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

