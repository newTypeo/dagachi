<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
	
<section id="club-search-sec" class="p-2 club-search">
	<div>
		<input type="range" id="kmRange" value="0" min="0" max="50" oninput="setValue(this);">
		<span id="range_val"></span>
	</div>
</section>
	
	
<script>
const setValue = (rangeTag) => {
	document.querySelector("#range_val").innerHTML = rangeTag.value + "km";
};

document.querySelector("#kmRange").onmouseup = (e) => {
	const distance = e.target.value;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/club/clubSearchByDistance.do",
		data : {distance},
		success(clubs) {
			console.log("주변 비동기검색 success= ", clubs);
		}
	})
	
	
}


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>