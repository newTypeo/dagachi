<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>

<section>

	<form:form method ="POST"
			   name="clubTitleUpdateFrm"
			   enctype="multipart/form-data"
			   action="${pageContext.request.contextPath}/admin/adminUpdateBanner.do">
  
		<nav id="club-title" class="">
			메인배너에 추가 할 이미지:
			<div class="custom-file">
				<input type="file" name="upFile" class="custom-file-input" id="fileInput"> 
				<label class="custom-file-label" for="fileInput" >${layout.title}</label>
			</div>
		</nav>
			
		<button type="submit" class="btn btn-primary btn-lg">배너 삽입</button>
		<button type="button" class="btn btn-primary btn-lg">돌아가기</button>
	</form:form>
	
</section>
	

<script>
document.querySelector("#fileInput").addEventListener("change",(e) => {
	
	const label = e.target.nextElementSibling;
	const files = e.target.files;
	if(files[0]) {
		label.innerHTML = files[0].name;
	}
	else {
		label.innerHTML = "파일을 선택하세요";
	}

});
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>