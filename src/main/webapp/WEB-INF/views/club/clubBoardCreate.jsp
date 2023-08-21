<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 작성" name="title" />
</jsp:include>

<section id="club-board-sec" class="">



	<form name="boardFrm"
		action="${pageContext.request.contextPath}/club/${domain}/boardCreate.do"
		enctype="multipart/form-data" method="post">
		<div class="form-group">
			<label for="exampleFormControlInput1"></label> <input type="text"
				class="form-control" id="exampleFormControlInput1" name="title"
				placeholder="제목을 입력하세요">
		</div>


		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<label class="input-group-text" for="inputGroupSelect01">카테고리</label>
			</div>

			<select class="custom-select" id="inputGroupSelect01"
				name="type">
				<option value="1" selected>자유글</option>
				<option value="2">정모후기</option>
				<option value="3">가입인사</option>
				<option value="4">공지사항</option>
				<option value="5" hidden>필독</option>
			</select>

		</div>



		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="inputFileAddon01">Upload</span>
			</div>
			<div class="custom-file">
				<input type="file" name="upFile" class="custom-file-input" id="inputFile01"
					aria-describedby="inputGroupFileAddon01" multiple> <label
					class="custom-file-label" for="inputGroupFile01">파일선택</label>
			</div>
		</div>

		<div class="form-group">
			<label for="exampleFormControlTextarea1"></label>
			<textarea class="form-control" name="content" id="exampleFormControlTextarea1"
				rows="3" placeholder="내용을 입력하세요"></textarea>
		</div>

		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<div class="input-group-text">
					<input type="checkbox"
						aria-label="Checkbox for following text input" id="mustRead">
				</div>
			</div>
			<input type="text" class="form-control"
				aria-label="Text input with checkbox"
				value="필독을 선택하시면 게시판 상단에 고정됩니다." readonly>
		</div>

		<button type="submit" class="btn btn-primary btn-lg">제출하기</button>
		
	</form>


</section>

<script>

document.boardFrm.addEventListener("submit",(e)=>{
	const frm=e.target;
	const title= frm.title.value;
	const content= frm.content.value;
	const type= frm.type.value;
	
	if(title === "" || content === "" || type === ""){
		
		e.preventDefault();
		//임시 얼럿트 추후에 빨간글이든 뭐든 되면 하지 모
		alert("입력값이 부족합니다.");
	}
	
});


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

document.querySelector("#mustRead").addEventListener("click",(e) => {
	const checkBox= e.target;
	
	const type =document.querySelector("#inputGroupSelect01");
	
	if(e.target.checked){
		type.value=5;
	}else{
		type.value=1;
	}
	
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>