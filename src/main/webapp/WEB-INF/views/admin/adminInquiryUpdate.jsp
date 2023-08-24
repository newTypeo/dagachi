<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문의 답변하기" name="title" />
</jsp:include>
<div> 답변하기 </div>

<section id="club-Inquiry-sec" class="">
	<form:form  name="InquiryFrm"
		action="${pageContext.request.contextPath}/admin/adminInquiryUpdate.do?no=${inquiry.inquiryId}"
		enctype="multipart/form-data" method="post">
	<div>
		<c:choose>
			<c:when test="${inquiry.type == 1}">
				<td>회원 정보 문의</td>
			</c:when>
			<c:when test="${inquiry.type == 2}">
				<td>소모임 관련 문의</td>
			</c:when>
			<c:when test="${inquiry.type == 3}">
				<td>결제 문의</td>
			</c:when>
			<c:when test="${inquiry.type == 4}">
				<td>신고 문의</td>
			</c:when>
			<c:otherwise>
				<td>알 수 없는 문의</td>
			</c:otherwise>
		</c:choose>
	</div>
	<div>
		 작성자 아이디 : 
	</div>
	<div>
		제목  ${inquiry.title}
	</div>
		  문의 내용 ${inquiry.content}
	<div>
 		<c:if test="${inquiry.open == 1}"><td>비공개 문의</td></c:if>
		<c:if test="${inquiry.open == 0}"><td>공개 문의</td></c:if>		
	</div>     

	<!-- 	UPDATE admin_Inquiry
		SET admin_id = {}, response = {}, status = '1', response_at = sysdate
		WHERE Inquiry_id = {}; -->
		
		
 		<div class="form-group">
 		[답변하기 ]
			<label for="exampleFormControlTextarea1"></label>
			<textarea class="form-control" name="response" id="exampleFormControlTextarea1"
				rows="3" placeholder="내용을 입력하세요"></textarea>
		</div>
		<button type="submit" class="btn btn-primary btn-lg">답변/수정 하기</button>
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