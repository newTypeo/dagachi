<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>


<section id="layout-update" class="">
	<form:form>
		<h3>소모임 스타일 수정</h3>
		<br>
		<h5>레이아웃 선택</h5>
		<div id="layout-select-container">
			<div id="layout-select-container-left"></div>
			<div id="layout-select-container-right">
				<label> 
					<input type="radio" name="singleRadio" value="option1">
					Option 1
				</label> 
				<label> 
					<input type="radio" name="singleRadio" value="option2">
					Option 2
				</label> 
				<label> 
					<input type="radio" name="singleRadio"value="option3">
					Option 3
				</label>
				<label> 
					<input type="radio" name="singleRadio"value="option3">
					Option 4
				</label>
			</div>
		</div>

	</form:form>
</section>

<script>
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>