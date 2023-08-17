<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


<section id="main-page-sec" class="p-2 member-list">
	<h1>회원목록 페이지</h1>
	
	<div id="member-list-wrapper">
		<div id="search-container">
	        <label for="searchType">검색타입 :</label> 
	        <select id="searchType">
	            <option value="memberName" >이름</option>      
	            <option value="memberId" >ID</option>      
	            <option value="category" >주소</option>           
	        </select>
		
				<div id="search-name" class="search-type">
					<input type="text" id="memberSearch" placeholder="검색어를 입력하세요" name="memberName">
		        </div>
				
				
				
			<table id="memberListTable">
				<thead>
					<tr>
						<th>ID</th>
						<th>이름</th>
						<th>닉네임</th>
						<th>연락처</th>
						<th>주소</th>
						<th>성별</th>
						<th>생년월일</th>
						<th>가입일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${empty members}">
					<tr>
						<td colspan="7">조회된 회원이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty members}">
					<c:forEach items="${members}" var="member" varStatus="vs">
						<tr>
							<td>${member.memberId}</td>
							<td>${member.name}</td>
							<td>${member.nickname}</td>
							<td>${member.phoneNo}</td>
							<td>${member.address}</td>
							<td>${member.gender}</td>
							<%-- <td>${member.birthday}</td> --%>
							<td>
								<fmt:parseDate value="${member.birthday}" var="birthday"  pattern="yyyy-MM-dd'T'HH:mm"></fmt:parseDate>
								<fmt:formatDate value="${birthday}" pattern="yy/MM/dd" />
							</td>
							<td>
								<fmt:parseDate value="${member.enrollDate}" var="enrollDate"  pattern="yyyy-MM-dd'T'HH:mm"></fmt:parseDate>
								<fmt:formatDate value="${enrollDate}" pattern="yy/MM/dd" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>