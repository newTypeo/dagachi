<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
	
<section id="club-search-sec" class="p-2 club-search">
	<div>'${inputText}'검색결과 (${totalCount})</div>
	<div id="filter-wrap">
		<form action="${pageContext.request.contextPath}/club/searchClubWithFilter.do">
			<label for="activityArea">활동 지역:</label>
		    <select id="filter-activityArea" name="area">
		        <option value="">전체</option>
		        <option value="강남구">강남구</option>
		        <option value="마포구">마포구</option>
		        <option value="종로구">종로구</option>
		        <option value="송파구">송파구</option>
		        <option value="중랑구">중랑구</option>
		        <option value="강북구">강북구</option>
		    </select>
		    
		    <label for="category">모임 분류:</label>
		    <select id="filter-category" name="category"><!-- js로 options 처리 --></select>

		    <button>필터 적용</button>
		</form>
	</div>
	<div>
		<c:if test="${empty clubs}">
			<div>검색결과가 없습니다.</div>
		</c:if>
		<c:if test="${not empty clubs}">
			<c:forEach items="${clubs}" var="club" varStatus="vs">
				<div>
					<c:if test="${not empty club.renamedFilename}">
					<img src="${pageContext.request.contextPath}/resources/upload/club/profile/${club.renamedFilename}" width="150px">
					</c:if>
					<c:if test="${empty club.renamedFilename}">
					<img src="${pageContext.request.contextPath}/resources/images/001.png" width="150px">
					</c:if>
					<span>모임명 : ${club.clubName}</span>
					<span>모임 지역 : ${club.activityArea}</span>
					<span>모임 분류 : ${club.category}</span>
					<span>모임 인원 : ${club.memberCount}/100</span>
					<span>모임 생성일 : ${club.createdAt}</span>
				</div>
			</c:forEach>
		</c:if>
	</div>
	<div id="pagebar-wrapper">	
		<c:if test="${empty pagebar}">
				<span></span>
		</c:if>
		<c:if test="${not empty pagebar}">
				<span>${pagebar}</span>
		</c:if>
	</div>
</section>
	
	
<script>
// 검색창에 검색내용 남기기
document.querySelector("input[name=inputText]").value = '${inputText}';

const category = document.querySelector("#filter-category");
category.innerHTML ='<option value="">전체</option>';

// 카테고리 option
document.querySelectorAll("#category-modal-left-upper a").forEach((a) => {
	category.innerHTML += `
		<option value="\${a.innerHTML}" name="\${a.innerHTML}">\${a.innerHTML}</option>
	`;
});

// 활동지역 option
$.ajax({
	url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=11*00000",
	data : {is_ignore_zero : true},
	success({regcodes}) {
		const selectArea = document.querySelector("#filter-activityArea");
		selectArea.innerHTML = '<option value="">전체</option>';
		
		$.each(regcodes, (index) => {
			const fullAddr = regcodes[index]["name"];
			const region = fullAddr.split(" ");
			
			selectArea.innerHTML += `<option value="\${region[1]}">\${region[1]}</option>`;
			
		});
	},
	complete() {
		if(${not empty area}) {
			document.querySelector("[value='" + '${area}' + "']").selected = 'true';
		}
		if(${not empty category}) {
			document.querySelector("[value='" + '${category}' + "']").selected = 'true';
		}
	}
});


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>