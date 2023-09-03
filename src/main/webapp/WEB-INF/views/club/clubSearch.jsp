<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/navBar.jsp"></jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/clubSearch.css" />

<section id="club-search-sec" class="p-2 club-search">
	<div> <c:if test="${not empty inputText}">"${inputText}"</c:if> 검색결과 (${totalCount})</div>
	<div id="filter-wrap">
		<form
			action="${pageContext.request.contextPath}/club/searchClubWithFilter.do">
			<label for="activityArea">활동 지역:</label> 
			<select id="filter-activityArea" name="region"><!-- js로 options 처리 --></select> 
			<select id="filter-activityAreaDetail" name="zone" style="display: none;">
			<option value="">전체</option></select>
			
			<label for="category">모임 분류:</label> <select id="filter-category" name="category"> <!-- js로 options 처리 --></select>

			<button class="btn btn-outline-secondary">Search</button>
		</form>
	</div>

	<c:if test="${empty clubs}">
		<div>검색결과가 없습니다.</div>
	</c:if>
	<c:if test="${not empty clubs}">
		<c:forEach items="${clubs}" var="club" varStatus="vs">
			<table>
				<tr class="cards" onclick="checkLogin('${club.domain}');">
						<td class="card-images">
							<img src="${pageContext.request.contextPath}/resources/upload/club/profile/${club.renamedFilename}" width="200px">
						</td>
						<td class="card-content">
							<p>모임명 : ${club.clubName}</p>
							<p>모임 지역 : ${club.activityArea}</p>
							<p>모임 분류 : ${club.category}</p>
							<p>모임 인원 : ${club.memberCount}/100</p>
							<p>
								모임 생성일 :
								<fmt:parseDate value="${club.createdAt}"
									pattern="yyyy-MM-dd'T'HH:mm" var="createdAt" />
								<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd" />
							</p>
						</td>
				</tr>
			</table>
		</c:forEach>
	</c:if>

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
const checkLogin = (domain) => {
	// 비로그인시 처리코드
	<sec:authorize access="isAnonymous()">
		alert("로그인 후 이용해주세요.");
	</sec:authorize>
	
	// 로그인시 처리코드
	<sec:authorize access="isAuthenticated()">
		window.location = `${pageContext.request.contextPath}/club/\${domain}`;
	</sec:authorize>
};


document.querySelector("#filter-activityArea").onchange = (e) => {
	const detail = document.querySelector("#filter-activityAreaDetail");
	const zone = e.target.value; 
	if(zone == "") {
		detail.style.display = 'none';
		detail.value = '';
		return;
	}
	
	$.ajax({ // 1. 서울시의 모든 구를 요청
		url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=11*00000",
		data : {is_ignore_zero : true},
		success({regcodes}) {
			$.each(regcodes, (index) => { // 2. 서울시 모든 구 중에서 사용자가 선택한 구의 정보를 찾기위한 반복문
				const fullAddr = regcodes[index]["name"];
				const region = fullAddr.split(" ");
				
				if(region[1] == zone) {
					
					const first5 = regcodes[index]["code"].toString().substr(0,5); // 3. 사용자가 선택한 구의 모든 동을 조회하기위한 코드 
					
					$.ajax({ // 4. 위에서 구한 코드로 모든 동정보 요청
						url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=" + first5 + "*",
						data : {is_ignore_zero : true},
						success({regcodes}) {
							const selectAreaDetail = document.querySelector("#filter-activityAreaDetail");
							selectAreaDetail.innerHTML = '<option value="">전체</option>';
							
							$.each(regcodes, (index) => { // 5. 파싱작업을 통해 모든동을 option태그로 만들어서 추가하는 반복문
								const fullAddr = regcodes[index]["name"];
								const region = fullAddr.split(" ");
								
								selectAreaDetail.innerHTML += `<option value="\${region[2]}">\${region[2]}</option>`;
							}); // $.each
						}, // success
						complete() {
							detail.style.display = 'inline-block';
							return;		
						} // complete
					}) // ajax
				} // if
			}); // $.each
		} // success
	}); // ajax
};

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
		if(${not empty region}) {
			document.querySelector("[value='" + '${region}' + "']").selected = 'true';
		}
		if(${not empty category}) {
			document.querySelector("[value='" + '${category}' + "']").selected = 'true';
		}
		if(${not empty zone}) {
			document.querySelector("[value='" + '${zone}' + "']").selected = 'true';
		}
	}
});


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>