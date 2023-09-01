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
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<style>
.h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
    margin-bottom: 0.5rem;
    font-weight: 500;
    line-height: 1.2;
    text-align: center;
        height: 53px;
    }
.code-btn{
margin-left: 175px;
    margin-top: -14px;
    height: 56px;
}
.codeConpare-btn{
margin-left: 184px;
    margin-top: -14px;
    height: 56px;
}


}
</style>
	
	<c:if test="${msg ne null}">
		<script>
		alert('${msg}');
		window.close();
		</script>
	</c:if>

	<form:form
		action = "${pageContext.request.contextPath}/member/memberSearchPw.do"
		method = "post"
		>
		<h3>등록되어있는 이름을 입력하세요.</h3>
	<div class="form-floating mb-3">
	  <input type="text" class="form-control" id="floatingInputDisabled" placeholder="홍길동" name = "name" required>
	  <label for="floatingInputDisabled"></label>
	</div>
	
	<h3>등록되어있는 이메일을 입력하세요.</h3>
	<div class="form-floating mb-3">
	  <input type="email" class="form-control" id="floatingInputDisabled2" placeholder="name@example.com" name = "email" required>
	  <label for="floatingInputDisabled"></label>
	</div>
	
	<div class = "code-btn">
	<button type="button" class="btn btn-primary" id="sendCodeButton">인증코드 보내기</button>
	</div>
	
	<h3>인증코드를 입력하세요</h3>
	<div class="form-floating mb-3">
	  <input type="text" class="form-control" id="floatingInputDisabled3" placeholder="q1w2e3r4" name = "code" required>
	  <label for="floatingInputDisabled"></label>
	</div>
	
	
	<div class="codeConpare-btn">
	<button type="button" class="btn btn-primary" id="compareCodeBtn">인증번호 확인</button>
	</div>
	</form:form>	
	
	<script>
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	sendCodeButton.addEventListener("click", function() {
		var username = document.getElementById('floatingInputDisabled').value; // username 입력 필드 값
        var email = document.getElementById('floatingInputDisabled2').value; // email 입력 필드 값
		console.log(email);
		console.log(username);
        // AJAX 요청으로 데이터 전송
        $.ajax({
            url: "${pageContext.request.contextPath}/member/sendCode.do",
            method: "get",
            data: {
            	username: username,
                email: email
            },
            beforeSend(xhr) {
            	console.log('xhr : ', xhr)
    			xhr.setRequestHeader(header, token);
    		},
            success: function(response) {
                alert('인증코드를 이메일로 발송합니다. 등록된 정보가 없을 시 코드가 발송되지 않으니 주의바랍니다!');
                console.log(response); // test를 위해 브라우저 콘솔창에서도 코드보여줄수있게함
                
			compareCodeBtn.addEventListener("click", function() {
			    var userEnteredCode = document.getElementById('floatingInputDisabled3').value;
			    
			    if(userEnteredCode === response){
			    	alert('일치 ㅋ' + email);
			    	window.location.href ="${pageContext.request.contextPath}/member/"+email+"/memberPwUpdate.do";
			    }
			    else{
			    	alert('불일치 ㅋ');
			    }
			});
            }
        });
    });
	
	 
	 
	
	</script>
	
	


