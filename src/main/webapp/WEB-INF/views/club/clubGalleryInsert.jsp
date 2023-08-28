<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="갤러리 작성" name="title" />
</jsp:include>
	<div>
		<h1>갤러리 사진 올리기</h1>
		<form:form name = "clubGalleryInsertFrm"
		action = "${pageContext.request.contextPath}/club/${domain}/clubGalleryInsert.do"
		enctype = "multipart/form-data" method = "post">
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
		
		
			<button class = "btn btn-primary" type = "submit">사진 올리기</button>
		</form:form>
	
	</div>
<script>
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

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>