<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
		<form:form
			action="${pageContext.request.contextPath}/member/memberLogin.do"
			method="post">
			<div class="modal-body">
						<c:if test="${param.error ne null}">
							<div class="alert alert-danger" role="alert">
								아이디 또는 비밀번호가 일치하지 않습니다.
							</div>
						</c:if>
					<input 
						type="text" class="form-control" name="memberId"
						placeholder="아이디" value="honggd" required> 
					<br /> 
					비번 <input
						type="password" class="form-control" name="password"
						placeholder="비밀번호" value="1234" required>
					</div>
				<div class="modal-footer d-flex flex-column" style="align-items: unset;">
					<div>
						<a href="${pageContext.request.contextPath}/oauth2/authorization/kakao">카카오 로그인</a>
					</div>
				<div class="d-flex justify-content-between">
						<div>
							<input type="checkbox" class="form-check-input" name="remember-me" id="remember-me"/>
							<label for="remember-me" class="form-check-label">Remember me</label>
						</div>
						<div>
							<button type="submit" class="btn btn-outline-success">로그인</button>
						</div>
				</div>
			</div>
		</form:form>	
		
		<button type="button" class="btn btn-primary" style=" text-align: center; display: block; margin: 0 auto;" id="btnOpen">아이디 찾기</button>
		<br/>
		<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h1 class="modal-title fs-5" id="exampleModalLabel" style="text-align: center; display: block; margin: 0 auto;">아이디 찾기</h1>
		            </div>
		            <div class="modal-body">
		                <form:form action="${pageContext.request.contextPath}/member/searchIdModal" method="post">
						    <div class="form-group">
						        <input type="text" class="form-control" name="username" placeholder="이름" value="">
						    </div>
						    <div class="form-group">
						        <div class="input-group">
						            <input type="email" class="form-control" name="email" placeholder="이메일" value="">
						            <button type="button" class="btn btn-primary" id="sendCodeButton">인증코드 보내기</button>
						        </div>
						    </div>
		                    <div class="form-group">
		                        <input type="text" class="form-control" placeholder="인증코드" value="">
		                    </div>
		                    <div class="d-flex justify-content-end">
		                        <button type="submit" class="btn btn-primary">인증</button>
		                    </div>
		                </form:form>
		            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btnClose">Close</button>
            </div>
        </div>
    </div>
</div>
		
		<button type="button" class="btn btn-success" style="text-align: center; display: block; margin: 0 auto;">비밀번호 찾기</button>
		
<script>
	var btnOpen = document.getElementById("btnOpen");
	var btnClose = document.getElementById("btnClose"); // 여기 수정
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var modal = new bootstrap.Modal(document.getElementById("exampleModal"));
	
	btnOpen.addEventListener("click", function() {
	    modal.show();
	});
	
	btnClose.addEventListener("click", function() { // 여기 수정
	    modal.hide();
	});
	
	document.addEventListener("DOMContentLoaded", function() {
        var sendCodeButton = document.getElementById("sendCodeButton");
        var searchIdForm = document.querySelector("#exampleModal form");
        
        sendCodeButton.addEventListener("click", function() {
            var username = searchIdForm.querySelector('input[name="username"]').value;
            var email = searchIdForm.querySelector('input[name="email"]').value;
			console.log(username);
			console.log(email);
			console.log(header);
			console.log(name);
            // AJAX 요청으로 데이터 전송
            $.ajax({
                url: "${pageContext.request.contextPath}/club/searchIdModal.do",
                method: "post",
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
                }
            });
        });
    });
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>