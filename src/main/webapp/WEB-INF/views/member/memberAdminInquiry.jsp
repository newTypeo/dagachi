<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자에게 문의하기" name="title" />
</jsp:include>

<style>

.form-check-input[type="radio"] {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    width: 20px;
    height: 20px; 
    border: 2px solid #2990D0; 
    border-radius: 50%;
    margin-right: 5px;
}

.form-check-input[type="radio"]:checked {
    background-color: #2990D0;
    border: 2px solid #2990D0;
}

.form-check-label {
    font-size: 16px; 
    color: #333; 
    margin-left: 10px;
}
</style>

<section id="club-Inquiry-sec" class="">
	<form:form  name="InquiryFrm"
		action="${pageContext.request.contextPath}/member/memberAdminInquiry.do"
		enctype="multipart/form-data" method="post"
		style="width: 700px; margin: 80px auto;">
		<h3 style="text-align: center; font-weight: bold;">📢 Q & A</h3>
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
				name="type"
				style="height: 50px; text-align: center;">
				<option value="1" selected>회원 정보 문의</option>
				<option value="2">소모임 관련 문의</option>
				<option value="3">결제 문의</option>
				<option value="4">신고 문의</option>
			</select>
			
			
			<div class="form-check" style="transform: translateX(10px);">
			  <input class="form-check-input" type="radio" name="open" id="openAll" value="0" checked>
			  <label class="form-check-label" for="openAll">전체 공개</label>
			  </br>
			  <!-- created_at -->
			  <input class="form-check-input" type="radio" name="open" id="openPrivate" value="1">
			  <label class="form-check-label" for="openPrivate">비공개</label>
			</div>
		</div>
		
		
		<div class="form-group">
			<label for="exampleFormControlTextarea1"></label>
			<textarea class="form-control" name="content" id="exampleFormControlTextarea1"
				rows="3" placeholder="내용을 입력하세요"></textarea>
		</div>

		<button type="submit" class="btn btn-primary btn-lg" style="margin-left: 290px;  border: none;  background-color: #2990D0;">문의 하기</button>
		
	 </form:form>
</section>
<script>

document.InquiryFrm.addEventListener("submit",(e)=>{
	const frm=e.target;
	const title= frm.title.value;
	const content= frm.content.value;
	const type= frm.type.value;
	
	if(title === "" || content === "" || type === ""){
		e.preventDefault();
		//임시 얼럿트 추후에 빨간글이든 뭐든 되면 하지 모
		alert("문의 내용이 부족합니다.");
	}
	
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>