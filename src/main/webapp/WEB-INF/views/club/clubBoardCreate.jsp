<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 작성" name="title" />
</jsp:include>

<section id="club-board-sec" class="">

	<form action="">
		<input type="text" placeholder="제목" name="title" required>

		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="inputFileAddon01">Upload</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" id="inputFile01"
					aria-describedby="inputGroupFileAddon01" multiple> <label
					class="custom-file-label" for="inputGroupFile01">파일선택</label>
			</div>
		</div>
		
		<textarea  name="content"></textarea>
		
	</form>

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>