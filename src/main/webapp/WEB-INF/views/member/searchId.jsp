<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<fmt:requestEncoding value="utf-8"/>
<style>
.submit-div {
    margin-left: 212px;
    margin-top: -17px;
}
.h3, h3 {
    font-size: 1.67rem;
    text-align: center;
}
.email-div{
	margin-top: 43px;
    height: 14%;
}

</style>
	<form:form
		action = "${pageContext.request.contextPath}/member/memberSearchId.do"
		method = "post"
		>
		<div class="email-div">
		<h3>등록되어있는 이메일을 입력하세요.</h3>
		</div>
	<div class="form-floating mb-3">
	  <input type="email" class="form-control" id="floatingInputDisabled" placeholder="name@example.com" name = "email">
	  <label for="floatingInputDisabled"></label>
	</div>
	<div class = "submit-div">
	<button type="submit" class="btn btn-primary">제출</button>
	</div>
	</form:form>	
	
	
	
	


