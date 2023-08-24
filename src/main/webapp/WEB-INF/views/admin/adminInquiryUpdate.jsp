<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문의 답변하기" name="title" />
</jsp:include>

<section id="club-Inquiry-sec" class="">
	<form:form  name="InquiryFrm"
		action="${pageContext.request.contextPath}/admin/adminInquiryUpdate.do"
		enctype="multipart/form-data" method="post">
		<div>${inquiry.number}</div>
		<div>${inquiry.writer}</div>
		<div>${inquiry.created_at}</div>
		<div>${inquiry.status}</div>
		<div>${inquiry.open}</div>
		
		<div class="form-group">
			<div>${inquiry.title}</div>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<div>${inquiry.type}</div>
			</div>
		</div>
		
		
		<div class="form-group">
			<label for="exampleFormControlTextarea1"></label>
			<textarea class="form-control" name="content" id="exampleFormControlTextarea1"
				rows="3" placeholder="내용을 입력하세요"></textarea>
		</div>
		
	<!-- 	UPDATE admin_Inquiry
		SET admin_id = {}, response = {}, status = '1', response_at = sysdate
		WHERE Inquiry_id = {}; -->
 		<div class="form-group">
			<label for="exampleFormControlTextarea1"></label>
			<textarea class="form-control" name="response" id="exampleFormControlTextarea1"
				rows="3" placeholder="내용을 입력하세요"></textarea>
		</div>
		
		<%-- <c:if test = "${status eq '0'}"> --%>
		<button type="submit" class="btn btn-primary btn-lg">답변/수정 하기</button>
		<%-- </c:if> --%>
		
		
		
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
		alert("입력값이 부족합니다.");
	}
	
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>