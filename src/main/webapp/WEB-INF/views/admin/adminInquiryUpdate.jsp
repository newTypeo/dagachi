<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문의 답변하기" name="title" />
</jsp:include>

<style>
#club-Inquiry-sec {
    max-width: 600px;
    margin: 0 auto;
    background-color: #f5f5f5;
    border: 1px solid #2990D0;
    padding: 20px;
    border-radius: 5px;
    margin-top: 30px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

.title {
    font-weight: bold;
    color: #333;
    font-size: 18px; 
}

.member {
    color: #555;
}

.form-control {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-top: 10px;
}

.btn-primary {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
}

.btn-primary {
    background-color: #2990D0;
}

.type-box {
    padding: 10px;
    border-radius: 5px;
    color: #fff;
    margin-top: 10px;
    text-align: center;
    font-size: 14px;
    font-weight: bold;
}


.type-box.public {
    background-color: #2990D0;
}

.form-group textarea {
    border: 1px solid #2990D0;
    padding: 10px;
    border-radius: 5px;
    font-size: 16px;
    margin-top
}
.cta {
    display: inline-block;
    margin-right: 10px; 
}
  .blue-line {
    border-bottom: 2px solid #2990D0;  /* 파란색 선을 그리고 싶은 두께와 색상을 조절할 수 있습니다. */
  }
 element.style {
    transform: translate(190px, 3px);
}

.center{
	    text-align: center;
}
</style>
<section id="club-Inquiry-sec" class="">
	<form:form  name="InquiryFrm"
		action="${pageContext.request.contextPath}/admin/adminInquiryUpdate.do?no=${inquiry.inquiryId}"
		enctype="multipart/form-data" method="post">
		<input type ="hidden" value = "${inquiry.inquiryId}" name ="inquiryId" />
	<div class = "center">
	 	<span class = "title">문의 번호</span>
		<h1>${inquiry.inquiryId}</h1>
		<c:choose>
			<c:when test="${inquiry.type == 1}">
				<td class = "cta">회원 정보 문의</td>
			</c:when>
			<c:when test="${inquiry.type == 2}">
				<td class = "cta">소모임 관련 문의</td>
			</c:when>
			<c:when test="${inquiry.type == 3}">
				<td class = "cta" >결제 문의</td>
			</c:when>
			<c:when test="${inquiry.type == 4}">
				<td class = "cta" >신고 문의</td>
			</c:when>
			<c:otherwise>
				<td class = "cta" >알 수 없는 문의</td>
			</c:otherwise>
		</c:choose>
		<div>
	 		<c:if test="${inquiry.open == 1}"><td class = "cta" >비공개 문의</td></c:if>
			<c:if test="${inquiry.open == 0}"><td class = "cta" >공개 문의</td></c:if>		
		</div>
	</div>
	 </br> 
		<div class = "blue-line"></div>
 </br>
	<div>
		 <span class = "title">작성자 아이디 :</span> <span class = "member">${inquiry.writer}</span>
	</div>
	<div >
		 <span class = "title">제목 :</span> <span class = "member ">${inquiry.title}</span>
	</div>
		   <span class = "title">문의 내용 :</span> <span class = "member"> ${inquiry.content}</span>
			</br></br>
			<div class = "blue-line"></div>
			<c:if test="${inquiry.adminId != null}">
				<div class = "blue-line"></br>
				<span class = "title">답변자 :</span><span class = "member">${inquiry.adminId}</span></br>
				<span class = "title">답변 내용:</span> <span class = "member">${inquiry.response}</span></br>
				<span class = "title"> 답변일자 :</span> <span class = "member">${inquiry.responseAt}</span>
				 </br></br>
				 </div>
			</c:if>
 		<div class="form-group">
			<label for="exampleFormControlTextarea1"></label>
			<textarea class="form-control" name="response" id="exampleFormControlTextarea1"
				rows="3" placeholder="문의 내용 답변을 입력해주세요."></textarea>
		</div>
		<button type="submit" class="btn btn-primary btn-lg" style=" transform: translate(190px, 3px)">답변/수정 하기</button>
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
		alert("입력값이 부족합니다.");
	}
});
</script> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>