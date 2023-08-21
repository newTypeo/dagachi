<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
				<tr>
					<td>1</td>
					<td>${host.name}</td>
					<td>${host.enrollAt}</td>
					<td></td>
					<td>
						<select id="host">
							<option selected disabled>방장</option>
						</select>
					</td>
				</tr>
				<c:forEach items="${joinClubMembersInfo}" var="clubMember" varStatus="vs">
					<!-- 방장일 경우에 -->
					<c:if test="${memberRole eq 3}">
						<tr>
							<td>${vs.count+1}</td>
							<td>${clubMember.name}</td>
							<td>${clubMember.enrollAt}</td>
							<td>
								<button id="kick" value="${clubMember.memberId}">추방</button>
							</td>
							<td>
								<select id="searchType" class="" title="${clubMember.memberId}">
						            <option value="2" 
						            	${clubMember.clubMemberRole eq 2 ? 'selected' : ''}>부방장</option>
						            <option value="1" 
						            	${clubMember.clubMemberRole eq 1 ? 'selected' : ''}>임원</option>
						            <option value="0" 
						            	${clubMember.clubMemberRole eq 0 ? 'selected' : ''}>회원</option>
		        				</select>
							</td>
						</tr>
					</c:if>
					
					<!-- 부방장일 경우에 -->
					<c:if test="${memberRole eq 2}">
						<tr>
							<td>${vs.count+1}</td>
							<td>${clubMember.name}</td>
							<td>${clubMember.enrollAt}</td>
							<c:if test="${clubMember.clubMemberRole eq 3 or clubMember.clubMemberRole eq 2 or
										loginMemberId eq clubMember.memberId}">
								<td>
									<button disabled>추방</button>
								</td>
							</c:if>
							<c:if test="${clubMember.clubMemberRole eq 1 or clubMember.clubMemberRole eq 0}">
								<td>
									<button id="kick" value="${clubMember.memberId}">추방</button>
								</td>
							</c:if>
							<td>
								<select id="searchType" class="" title="${clubMember.memberId}">
									<c:if test="${loginMemberId ne clubMember.memberId}">
										<option value="2" 
							            	${clubMember.clubMemberRole eq 2 ? 'selected' : ''} disabled>부방장</option>
							            <option value="1" 
							            	${clubMember.clubMemberRole eq 1 ? 'selected' : ''}>임원</option>
							            <option value="0" 
							            	${clubMember.clubMemberRole eq 0 ? 'selected' : ''}>회원</option>
						            </c:if>
						            	
						            <!-- 로그인한 회원아이디와 모임에 가입된 회원 아이디가 같을 경우에 -->
						            <c:if test="${loginMemberId eq clubMember.memberId}">
										<option value="2" 
							            	${clubMember.clubMemberRole eq 2 ? 'selected' : ''} disabled>부방장</option>
							            <option value="1" 
							            	${clubMember.clubMemberRole eq 1 ? 'selected' : ''} disabled>임원</option>
							            <option value="0" 
							            	${clubMember.clubMemberRole eq 0 ? 'selected' : ''} disabled>회원</option>
						            </c:if>
		        				</select>
							</td>
						</tr>
					</c:if>
					
					<!-- 임원일 경우에 -->
					<c:if test="${memberRole eq 1}">
						<tr>
							<td>${vs.count+1}</td>
							<td>${clubMember.name}</td>
							<td>${clubMember.enrollAt}</td>
							<c:if test="${clubMember.clubMemberRole ne 0}">
								<td>
									<button disabled>추방</button>
								</td>
							</c:if>
							<c:if test="${clubMember.clubMemberRole eq 0}">
								<td>
									<button id="kick" value="${clubMember.memberId}">추방</button>
								</td>
							</c:if>
							<td>
								<select id="searchType" class="" title="${clubMember.memberId}">
									<option value="2" 
						            	${clubMember.clubMemberRole eq 2 ? 'selected' : ''} disabled>부방장</option>
						            <option value="1" 
						            	${clubMember.clubMemberRole eq 1 ? 'selected' : ''} disabled>임원</option>
						            <option value="0" 
						            	${clubMember.clubMemberRole eq 0 ? 'selected' : ''} disabled>회원</option>
		        				</select>
							</td>
						</tr>
					</c:if>
					
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</div>
<%-- 회원추방시 사용 되는 폼 --%>
<form:form
	name="kickMember"
	action="${pageContext.request.contextPath}/club/&${domain}/kickMember.do"
	method="post">

	<input type="hidden" id="memberId" name="memberId" />
</form:form>

<%-- 회원권한 변경시 사용 되는 폼 --%>
<form:form
	name="clubMemberRoleUpdateFrm" 
	action="${pageContext.request.contextPath}/club/&${domain}/clubMemberRole.do" 
	method="post">

	<input type="hidden" id="memberId" name="memberId"/>
	<input type="hidden" id="clubMemberRole" name="clubMemberRole"/>
</form:form>

<script>
document.querySelectorAll('#kick').forEach((kickButton) => {
	kickButton.onclick = (e) => {
		const frm = document.kickMember;
		
		frm.memberId.value = e.target.value;
		console.log(e.target.value);
		
		frm.submit();
	};
});

document.querySelectorAll('#searchType').forEach((select) => {
	select.onchange = (e) => {
		const frm = document.clubMemberRoleUpdateFrm;
		
		const memberRole = e.target.value;
		const memberId = e.target.title;
		
		const memberName = e.target.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
		
		let role;
		
		switch(memberRole) {
			case '0' : role = '회원'; break;
			case '1' : role = '임원'; break;
			case '2' : role = '부방장'; break;
			case '3' : role = '방장'; break;
		}
		
		if(confirm(`\${memberName}님의 권한을 \${role}로 변경?`)) {
			frm.memberId.value = memberId;
			frm.clubMemberRole.value = memberRole;
			
			frm.submit();
		}
	};
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>