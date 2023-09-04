<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layoutType0.css"/>


<section>
	<div id="update-btn-container">
		<div class="btn-group" role="group" aria-label="Basic example">
			<button type="button" class="btn btn-primary" id="club-update-btn">정보 수정</button>
			<button type="button" class="btn btn-primary" id="club-style-update">스타일 설정</button>
			<button type="button" class="btn btn-primary" id="club-title-update">타이틀 설정</button>
			<button type="button" class="btn btn-primary" id="club-member-manage">회원 관리</button>
		</div>
		<c:if test ="${memberRole eq 3}">
			<button type="button" class="btn btn-danger" id="clubDisabled">모임 해산</button>
		</c:if>
	</div>

	<form:form name="clubTitleUpdateFrm"
	action="${pageContext.request.contextPath}/club/${domain}/clubTitleUpdate.do"
	enctype="multipart/form-data"
	method ="POST">
	
  
  
	<nav id="club-title" class="">
		메인배너에 사용 할 이미지:
	  <div class="custom-file">
		<input type="file" name="upFile" class="custom-file-input" id="fileInput"
		aria-describedby="inputGroupFileAddon01" multiple> <label
		class="custom-file-label" for="fileInput" >${layout.title}</label>
	  </div>
	  <br/><br/>
		<div id="previewContainer">
			<img src="${pageContext.request.contextPath}/resources/upload/club/title/${layout.title}">
		</div>
	</nav>
	
	<div id="club-main-container2">
	대문에 사용 할 이미지:
	  <div class="custom-file">
	    
		<input type="file" name="upFile2" class="custom-file-input" id="fileInput2"
		aria-describedby="inputGroupFileAddon01" multiple> <label
		class="custom-file-label" for="fileInput2" >${layout.mainImage}</label>
	  </div>
	  <br/><br/>
	  
		<div id="previewContainer2">
			<img src="${pageContext.request.contextPath}/resources/upload/club/main/${layout.mainImage}">
		</div>
		
		
		<div id="club-main-content-container">
			<p class="fontColors">${layout.mainContent}</p>
		</div>
		<input type="text" class="form-control" id="mainContent"  name = "mainContent" value ="${layout.mainContent}" />
	</div>
		<h3>수정할 소개글을 작성하세요!</h3>
	<div id = "club-title-update-btn">
		<div>
			<button type="submit" class="btn btn-primary btn-lg">&nbsp;&nbsp;&nbsp;&nbsp;수&nbsp;&nbsp;&nbsp;정&nbsp;&nbsp;&nbsp;&nbsp;</button>
			</div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div>
			<button type="button" class="btn btn-secondary btn-lg">&nbsp;&nbsp;&nbsp;&nbsp;취&nbsp;&nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;&nbsp;</button>
		</div>
	</div>
</form:form>

	
</section>
	

<script>
const fileInput = document.getElementById('fileInput');
const previewContainer = document.getElementById('previewContainer');

fileInput.addEventListener('change', function() {
  previewContainer.innerHTML = ''; // Clear previous preview

  const files = fileInput.files;

  for (let i = 0; i < files.length; i++) {
    const file = files[i];

    if (file.type.startsWith('image/')) {
      const img = document.createElement('img');
      img.src = URL.createObjectURL(file);
      img.style.maxWidth = '100%';
      img.style.height = '100%';
      previewContainer.appendChild(img);
    } else {
      const p = document.createElement('p');
      p.textContent = `File ${file.name} is not an image.`;
      previewContainer.appendChild(p);
    }
  }
});
</script>
<script>
const fileInput2 = document.getElementById('fileInput2');
const previewContainer2 = document.getElementById('previewContainer2');

fileInput2.addEventListener('change', function() {
  previewContainer2.innerHTML = ''; // Clear previous preview

  const files = fileInput2.files;

  for (let i = 0; i < files.length; i++) {
    const file = files[i];

    if (file.type.startsWith('image/')) {
      const img = document.createElement('img');
      img.src = URL.createObjectURL(file);
      img.style.maxWidth = '100%';
      img.style.height = '100%';
      previewContainer2.appendChild(img);
    } else {
      const p2 = document.createElement('p2');
      p.textContent = `File ${file.name} is not an image.`;
      previewContainer2.appendChild(p2);
    }
  }
});
</script>
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
 <script>
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
  
//준한(모임 비활성화)
const domain = "<%= request.getAttribute("domain") %>"; 

document.querySelector("#club-update-btn").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubUpdate.do';
}

document.querySelector("#club-style-update").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubStyleUpdate.do';
}

document.querySelector("#club-title-update").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubTitleUpdate.do';
}

document.querySelector("#club-member-manage").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/manageMember.do';
}
</script>
<c:if test="${memberRole eq 3}">
	<script>
	//서버 사이드에서 domain 값을 가져와서 설정
	document.querySelector("#clubDisabled").onclick = (e) => {
	  const userConfirmation = confirm("정말 비활성화 하시겠습니까?");
	  if (userConfirmation) {
	      // 도메인 값을 사용하여 컨트롤러로 이동하는 코드를 추가
	      window.location.href = "${pageContext.request.contextPath}/club/" + domain + "/clubDisabled.do";
	      alert('모임이 성공적으로 비활성화 되었습니다.');
	  }
	};
	</script>
</c:if>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>