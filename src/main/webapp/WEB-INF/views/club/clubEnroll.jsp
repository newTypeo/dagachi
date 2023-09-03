<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 가입하기</title>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<script>
window.onload = () => {
	$("#EnorllModal")
		.modal()
		.on('hide.bs.modal', () => {
			location.href = '${pageContext.request.contextPath}';
		});
}
</script>
</head>
<body>
	<!-- Modal시작 -->
	<!-- https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
	<div class="modal fade" id="EnorllModal" tabindex="-1" role="dialog"
		aria-labelledby="EnorllModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="loginModalLabel">가입하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form:form
					action="${pageContext.request.contextPath}/club/${domain}/clubEnroll.do"
					method="post">
					<input type="hidden" class="clubId" name="clubId" 
					placeholder="" value="${club.clubId}" required> 
				
					
					 <div class="modal-body">
						❗❗${club.clubName}가입 질문❗❗
							<br/> 
							<br/> 
								❓${club.enrollQuestion}
							<br/> 
							<input 
								type="text" class="form-control" name="answer"
								placeholder="" value="" required> 
							<br/> 
							<div>모임 가입 신청 란입니다. 추후 수정이 불가능하니 신중하게 
								답변해주세요 </div>
						</div>
					<div class="modal-footer d-flex flex-column" style="align-items: unset;">
						<div class="d-flex justify-content-between">
							<div>
								<button type="submit" class="btn btn-outline-success">가입 신청 하기</button>
								<button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<!-- Modal 끝-->
</body>
</html>
