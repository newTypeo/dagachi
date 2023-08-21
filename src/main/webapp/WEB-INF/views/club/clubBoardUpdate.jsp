<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 작성" name="title" />
</jsp:include>

<script >
window.onload = function() {
	checkType();
};
</script>

<section id="club-board-sec" class="">



	<form:form name="boardFrm"
		action="${pageContext.request.contextPath}/club/${domain}/boardUpdate.do?no=${clubBoard.boardId}"
		enctype="multipart/form-data" method="post">
		<div class="form-group">
			<label for="exampleFormControlInput1"></label> <input type="text"
				class="form-control" id="exampleFormControlInput1"
				name="title"
				placeholder="제목을 입력하세요"
				value="${clubBoard.title}">
		</div>


		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<label class="input-group-text" for="inputGroupSelect01">카테고리</label>
			</div>

			<select class="custom-select" id="inputGroupSelect01" name="boardType">
				<option selected>선택</option>
				<option value="1" >자유글</option>
				<option value="2">정모후기</option>
				<option value="3">가입인사</option>
				<option value="4">공지사항</option>
			</select>

		</div>



		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="inputFileAddon01">Upload</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" id="inputFile01"
					aria-describedby="inputGroupFileAddon01" multiple> <label
					class="custom-file-label" for="inputGroupFile01">파일선택</label>
			</div>
		</div>

		<div class="form-group">
			<label for="exampleFormControlTextarea1"></label>
			<textarea class="form-control" id="exampleFormControlTextarea1" name="content"
				rows="3" placeholder="내용을 입력하세요" >${clubBoard.content}</textarea>
		</div>

		<div class="btn-group-toggle" data-toggle="buttons">
			<label class="btn btn-secondary active"> <input
				type="checkbox"> 게시글상위고정
			</label>
		</div>

		<button type="submit" class="btn btn-primary btn-lg">수정하기</button>
	
	</form:form>


</section>

<script>

document.querySelector("#inputFile01").addEventListener("change",(e) => {
	
		const label = e.target.nextElementSibling;
		const files = e.target.files;
		if(files[0]) {
			label.innerHTML = files[0].name;
		}
		else {
			label.innerHTML = "파일을 선택하세요";
		}
	
});

const checkType=()=>{
	const type= "${clubBoard.type}";
	document.querySelector("#inputGroupSelect01").value= type;
};


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>