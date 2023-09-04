<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/navBar.jsp"></jsp:include>
	
<section id="club-search-sec" class="p-2 club-search">


	<div>
		<label for="category">모임 분류 :</label>
		<select id="filter-category" name="category"><!-- js로 options 처리 --></select>
		<input type="range" id="kmRange" value="0" min="1" max="6" step="1" oninput="setValue(this);">
		<span id="range_val"></span>
	</div>
	<hr>
	<div class="mt-4"><div class="row" id="clubs-wrapper"></div></div>
</section>
	
	
<script>
// 카테고리 변경시 비동기 요청
document.querySelector("#filter-category").onchange = () => {
	const rangeTag = document.querySelector("#kmRange");
	loadCLubs(rangeTag);
};

// 페이지 로드 시 1km반경의 모임 자동으로 요청
window.onload = () => {
	const rangeTag = document.querySelector("#kmRange"); 
	document.querySelector("#range_val").innerHTML = '1km';
	rangeTag.value = 1;	
	loadCLubs(rangeTag);
};


// 페이지 로드 시 카테고리 첫 항목으로 전체 삽입
const category = document.querySelector("#filter-category");
category.innerHTML ='<option value="">전체</option>';

//카테고리 option (navBar.jsp에서 가져옴)
document.querySelectorAll("#category-modal-left-upper a").forEach((a) => {
	category.innerHTML += `
		<option value="\${a.innerHTML}" name="\${a.innerHTML}">\${a.innerHTML}</option>
	`;
});

// range태그 움직일 때마다 km텍스트 출력
const setValue = (rangeTag) => {
	document.querySelector("#range_val").innerHTML = rangeTag.value + "km";
};

// range태그 마우스 클릭 후 때는 순간 모임 비동기 검색
document.querySelector("#kmRange").onmouseup = (e) => {
	loadCLubs(e.target);
}

// 비동기 모임 검색 함수
const loadCLubs = (target) => {
	const distance = target.value;
	if(distance == 0) return;
	const mainAreaId = ${mainAreaId};
	
	$.ajax({ // 활동지역코드로 활동지역 명 가져옴 ex) 1168010100 -> "서울특별시 강남구 역삼동"
		url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=" + mainAreaId,
		data : {is_ignore_zero : true},
		success({regcodes}) { 
			const mainAreaName = regcodes[0].name;
			const category = document.querySelector("#filter-category").value; 
			
			$.ajax({ // km, 주활동지역의 법정동명, 선택한 카테고리(옵션)으로 모임 검색
				url : "${pageContext.request.contextPath}/club/clubSearchByDistance.do", // 입력한 km반경을 알고리즘으로 구해서 모임을 검색해온다.
				data : {distance, mainAreaName, category},
				success(clubs) {
					let html = '';
					const clubsWrapper = document.querySelector("#clubs-wrapper");
					clubsWrapper.innerHTML = '';
					clubs.forEach((club) => {
						html += `
							<div class="col-md-4 mb-4">
					            <div class="card" onclick="checkLogin('\${club.domain}');">
					                <img src="/dagachi/resources/upload/club/profile/\${club.renamedFilename}" class="card-img-top img-fluid" alt="Club Image">
					                <div class="card-body">
					                    <h5 class="card-title">모임명: \${club.clubName}</h5>
					                    <p class="card-text">모임 지역: \${club.activityArea}</p>
					                    <p class="card-text">모임 분류: \${club.category}</p>
					                    <p class="card-text">모임 인원: \${club.memberCount}/100</p>
					                    <p class="card-text">모임 생성일: \${club.createdAt.substring(0,10)}</p>
					                </div>
					            </div>
				        	</div>
						`;
					}); // forEach
					if(html == '') {
						html += `<h4>검색 결과가 없습니다.</h4></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br>`;
					}
					
					clubsWrapper.innerHTML = html;
				} // success
			}); // ajax
		} // success
	}); // ajax
};

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
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>