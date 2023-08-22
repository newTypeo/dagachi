<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 작성" name="title" />
</jsp:include>

<script>
window.onload = function() {
	checkType();
	renderAtt();
};
</script>

<section id="club-board-sec" class="">



	<form:form name="boardFrm"
		action="${pageContext.request.contextPath}/club/${domain}/boardUpdate.do?no=${clubBoard.boardId}"
		enctype="multipart/form-data" method="post">
		<div class="form-group">
			<label for="exampleFormControlInput1"></label> <input type="text"
				class="form-control" id="exampleFormControlInput1" name="title"
				placeholder="제목을 입력하세요" value="${clubBoard.title}">
		</div>


		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<label class="input-group-text" for="inputGroupSelect01">카테고리</label>
			</div>

			<select class="custom-select" id="inputGroupSelect01" name="type">
				<option selected>선택</option>
				<option value="1">자유글</option>
				<option value="2">정모후기</option>
				<option value="3">가입인사</option>
				<option value="4">공지사항</option>
				<option value="5"hidden">필독</option>
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

		<div id="attachBox">
			<ul>

			</ul>
		</div>

		<div class="form-group">
			<label for="exampleFormControlTextarea1"></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				name="content" rows="3" placeholder="내용을 입력하세요">${clubBoard.content}</textarea>
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

		<button type="submit" class="btn btn-primary btn-lg">수정하기</button>

	</form:form>


</section>

<script>





const renderAtt=()=>{
	
	const no ="${clubBoard.boardId}";
	const domain ="${domain}";

	
	$.ajax({
		url : '${pageContext.request.contextPath}/club/findAttachments.do',
		method:"GET",
		data :{no,domain},
		success(attachs){
		
			if(attachs.length>0){
				const liBox=document.querySelector("#attachBox ul");
				let html='';
				html =attachs.reduce((html,attach)=>{
				const {boardId, id, originalFilename,renamedFilename,thumbnail,createAt} =attach
				
				return html +`
					<li>
						<input type="checkbox" class="delFile"
						value="\${id}" /> \${originalFilename}
						<button type="button" class="attdel" onclick="attdel(this)" value="\${id}">삭제하기</button>
					</li>
				`;
					
				},"");
				
				liBox.innerHTML= html;
			}
			
		}
	});
};

const attdel=(e)=>{
	
	if(confirm("첨부파일을 삭제하시겠습니까?")){
		const id=e.value;
		const token= document.boardFrm._csrf.value;
		
		$.ajax({
			url : '${pageContext.request.contextPath}/club/delAttach.do',
			method:"POST",
			data :{id},
			headers: {
				"X-CSRF-TOKEN": token
			},
			success(data){
				renderAtt();
			}
		});
	}
};




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