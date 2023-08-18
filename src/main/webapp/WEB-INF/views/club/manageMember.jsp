<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>

<br/><br/><br/><br/>

<div>
	<fieldset>
		<legend>가입신청회원</legend>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>이름</th>
					<th>답변</th>
					<th>승인</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${clubApplies}" var="clubApply" varStatus="vs">
					<tr>
						<td>${vs.count}</td>
						<td>${clubApply.name}</td>
						<td>${clubApply.answer}</td>
						<td><button>가입승인</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</div>

<br/><br/><br/><br/>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>