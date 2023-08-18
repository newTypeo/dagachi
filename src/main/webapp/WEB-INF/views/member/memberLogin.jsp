<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
						placeholder="아이디" value="" required> 
					<br /> 
					<input
						type="password" class="form-control" name="password"
						placeholder="비밀번호" value="" required>
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
							<button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
						</div>
				</div>
			</div>
		</form:form>			
						
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>