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
						<td>
							<button value="${clubApply.memberId}" onclick="permitApply();">승인</button>
							<button value="${clubApply.memberId}" onclick="refuseApply();">거절</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</div>

<br/><br/><br/><br/>
<script>
const permitApply = () => {
	
};
const refuseApply = () => {
	
};
</script>

<div>
	<fieldset>
		<legend>모임 회원</legend>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>회원이름</th>
					<th>가입일</th>
					<th>추방</th>
					<th>직위</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${joinClubMembersInfo}" var="clubMember" varStatus="vs">
					<tr>
						<td>${vs.count}</td>
						<td>${clubMember.name}</td>
						<td>${clubMember.enrollAt}</td>
						<td>
							<button>추방</button>
							
						</td>
						<td>
							<select id="searchType" class="" title="${clubMember.memberId}">
					            <option value="0" 
					            	${clubMember.clubMemberRole eq 0 ? 'selected' : ''}>회원</option>
					            <option value="3" 
					            	${clubMember.clubMemberRole eq 3 ? 'selected' : ''}>부방장</option>
	        				</select>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</div>

<script>
document.querySelectorAll('#searchType').forEach((select) => {
	select.onchange = (e) => {
		console.log(e.target.value);
		console.log(e.target.title);
	};
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>