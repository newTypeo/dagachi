<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
	
<section id="club-search-sec" class="p-2 club-search">


	<div>
		<label for="category">모임 분류:</label>
		<select id="filter-category" name="category"><!-- js로 options 처리 --></select>
		<input type="range" id="kmRange" value="0" min="0" max="6" step="1" oninput="setValue(this);">
		<span id="range_val"></span>
	</div>
	<div id="clubs-wrapper"></div>
</section>
	
	
<script>
const category = document.querySelector("#filter-category");
category.innerHTML ='<option value="">전체</option>';

//카테고리 option
document.querySelectorAll("#category-modal-left-upper a").forEach((a) => {
	category.innerHTML += `
		<option value="\${a.innerHTML}" name="\${a.innerHTML}">\${a.innerHTML}</option>
	`;
});


const setValue = (rangeTag) => {
	document.querySelector("#range_val").innerHTML = rangeTag.value + "km";
};

document.querySelector("#kmRange").onmouseup = (e) => {
	const distance = e.target.value;
	if(distance == 0) return;
	const mainAreaId = ${mainAreaId};
	
	$.ajax({ // 4. 위에서 구한 코드로 모든 동정보 요청
		url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=" + mainAreaId,
		data : {is_ignore_zero : true},
		success({regcodes}) {
			const mainAreaName = regcodes[0].name;
			const category = document.querySelector("#filter-category").value; 
			
			$.ajax({
				url : "${pageContext.request.contextPath}/club/clubSearchByDistance.do",
				data : {distance, mainAreaName, category},
				success(clubs) {
					console.log("주변 비동기검색 success= ", clubs);
					let html = '';
					const clubsWrapper = document.querySelector("#clubs-wrapper");
					clubsWrapper.innerHTML = '';
					clubs.forEach((club) => {
						html += `
							<div>
								<img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${club.renamedFilename}" width="150px">
								<span>모임명 : \${club.clubName}</span>
								<span>모임 지역 : \${club.activityArea}</span>
								<span>모임 분류 : \${club.category}</span>
								<span>모임 인원 : \${club.memberCount}/100</span>
								<span>모임 생성일 : \${club.createdAt}</span>
							</div>
						`;
					});
					clubsWrapper.innerHTML = html;
				}
			});
		}
	});
	
}




</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>