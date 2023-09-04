<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp">
	<jsp:param value="게시글 작성" name="title" />
</jsp:include>
<script>

</script>
<section id="club-board-sec" class="">
	<nav id="club-title" class="">
	<c:if test="${layout.title eq null}">
		<div id="default-title">
			<h2>${domain}</h2>
		</div>
	</c:if>
	
	<c:if test="${layout.title ne null}">
		<img src="${pageContext.request.contextPath}/resources/upload/club/title/${layout.title}">
	</c:if>
	</nav>

	<nav id="club-nav-bar" style="border-color: ${layout.pointColor}">
		<h5><a href="${pageContext.request.contextPath}/club/${domain}">🚩${clubName}</a></h5>
		<div class="fontColors">
			<ul>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">📢공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">🐳자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">✋가입인사</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">🎉정모후기</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubGallery.do">📷갤러리</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">📅일정</a></li>
			</ul>
		</div>
    </nav>



	<form:form name="boardFrm" style="width: 700px; margin: 0 auto;"
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

			<select class="custom-select" id="inputGroupSelect01" name="type">
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
				<input type="file" name="upFile" class="custom-file-input"
					id="inputFile01" aria-describedby="inputGroupFileAddon01" multiple>
				<label class="custom-file-label" for="inputGroupFile01">파일선택</label>
			</div>
		</div>
				<div id="attchBox">
					<ul>
						
					</ul>
				</div>
				

		<div class="form-group">
			<label for="exampleFormControlTextarea1"></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				name="content" rows="3" placeholder="내용을 입력하세요"></textarea>
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

	</form:form>


</section>

<script>
//레이아웃 및 네브바
document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";


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


document.querySelector("#inputFile01").addEventListener("change",() => {

	
		const files = Array.from(document.querySelector("#inputFile01").files);
		
		renderAttach(files);
	
});

		
const renderAttach=(files)=>{
	
	let html='';
	
	const attBox=document.querySelector("#attchBox ul");
	
	attBox.innerHTML = files.reduce((html,file,index)=>{
		 return html + `
			<li>
				 \${file.name}  
				 <button type="button" class="selCancel" onclick="selCancel(this,\${index})">x</button>
			 </li>
		`;
	},"");
};
		
const selCancel= (e,index)=>{
	
	const fileElement = e.parentElement;
    fileElement.remove();
    
    const filesInput = document.querySelector("#inputFile01");
    const selectedFiles = Array.from(filesInput.files);
    selectedFiles.splice(index, 1);
    
    const updatedFileList = new DataTransfer();
    
    for (const file of selectedFiles) 
        updatedFileList.items.add(file);
    
    filesInput.files = updatedFileList.files;
    
    const files = Array.from(filesInput.files);
    
    renderAttach(files);
    
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