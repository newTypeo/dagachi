<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="갤러리 작성" name="title" />
</jsp:include>
<style>
.submit-div{
	position: relative;
    width: 102px;
    margin-top: 29px;
    margin-left: 1515px;
    height: 300px;
}

.form{
    margin: 100px;
}
</style>
<section>
	<div>
		
		<h1>갤러리 사진 올리기</h1>
		<div class = "form">
		<form:form name = "clubGalleryInsertFrm"
		action = "${pageContext.request.contextPath}/club/${domain}/clubGalleryInsert.do"
		enctype = "multipart/form-data" method = "post">
		
		<h2>썸네일에 쓸 사진</h2>
		<div class="custom-file">
		<input type="file" name="upFile" class="custom-file-input" id="fileInput"
		aria-describedby="inputGroupFileAddon01" multiple> <label
		class="custom-file-label" for="fileInput" >${layout.title}</label>
	  	</div>
	  	
	  	<br/><br/>
		<div class="custom-file">
		<input type="file" name="upFile2" class="custom-file-input" id="fileInput2"
		aria-describedby="inputGroupFileAddon01" multiple> <label
		class="custom-file-label" for="fileInput2" >${layout.mainImage}</label>
	  	</div>
	  	
	  	<br/><br/>
		<div class="custom-file">
		<input type="file" name="upFile3" class="custom-file-input" id="fileInput3"
		aria-describedby="inputGroupFileAddon01" multiple> <label
		class="custom-file-label" for="fileInput3" >${layout.mainImage}</label>
	  	</div>
		
		
			<div class="submit-div">
				<button class = "btn btn-primary" type = "submit">사진 올리기</button>
			</div>
		</form:form>
		</div>
	</div>
	
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

document.querySelector("#fileInput2").addEventListener("change",(e) => {
	
	const label = e.target.nextElementSibling;
	const files = e.target.files;
	if(files[0]) {
		label.innerHTML = files[0].name;
	}
	else {
		label.innerHTML = "파일을 선택하세요";
	}

});

document.querySelector("#fileInput3").addEventListener("change",(e) => {
	
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