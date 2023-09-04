<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
/* 메인 버튼 컨테이너 스타일 */
.btn-main-style {
  display: flex;
  justify-content: center;
  margin-top: 10px;
}

/* 서브 버튼 스타일 */
.btn-sub-style {
  padding: 5px 10px;
  margin: 0 10px;
  font-size: 15px;
  background-color: #007BFF;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

/* 서브 버튼 호버 효과 */
.btn-sub-style:hover {
  background-color: #0056b3;
}
</style>
<section>

	<form:form method ="POST"
			   name="clubTitleUpdateFrm"
			   enctype="multipart/form-data"
			   action="${pageContext.request.contextPath}/admin/adminUpdateBanner.do"
			   style="width: 700px; margin: 150px auto;">
  
		<nav id="club-title" class=""
		style="font-weight: bold;">
			메인배너에 추가 할 이미지:
			<div class="custom-file">
				<input type="file" name="upFile" class="custom-file-input" id="fileInput" required> 
				<label class="custom-file-label" for="fileInput" >${layout.title}</label>
			</div>
		</nav>
		<div class="btn-main-style" style="margin-top: 10px;">
			<button class="btn-sub-style" type="submit">배너 삽입</button>
			<button class="btn-sub-style" type="button">돌아가기</button>
		</div>
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