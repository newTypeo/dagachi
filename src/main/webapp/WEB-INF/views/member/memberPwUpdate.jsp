<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
body {
	width: 300px;
	margin: 100 auto;
	border: 2px solid;
	height: 200px;
	padding: 15px;
	border-radius: 15px;
}

</style>
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
<fmt:requestEncoding value="utf-8"/>
<h4>비밀번호 변경</h4>
<form:form name="memberPwUpdateFrm"
	action="${pageContext.request.contextPath}/member/memberPwUpdate.do"
	method="POST">
	<h5>•변경할 비밀번호</h5>
	<input type="password" name="newPassword" id="newPassword" class="input-bar">

	<h5>•비밀번호 확인</h5>
	<input type="password" name="newPassword2" id="newPassword2" class="input-bar">

	<!-- 받아온 이메일 input태그에 숨겨서 컨트롤러로 제출 -->
	<input type="hidden" name="email" value="${email}">

	<button type="button" onclick="validatePasswords()">변경</button>
</form:form>

<script>
function validatePasswords() {
    var newPassword = document.getElementById("newPassword").value;
    var newPassword2 = document.getElementById("newPassword2").value;

    if (newPassword !== newPassword2) {
        alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
    } else {
        // 비밀번호가 일치하는 경우, 폼 제출
        document.forms["memberPwUpdateFrm"].submit();
    }
}
</script>