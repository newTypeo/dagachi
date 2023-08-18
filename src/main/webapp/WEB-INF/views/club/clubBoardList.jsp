<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title" />
</jsp:include>


<section id="club-board-sec" class="">


	<select class="custom-select custom-select-lg mb-3" id="boardType">
		<option value="1" selected>전체보기</option>
		<option value="2">자유글</option>
		<option value="3">정모후기</option>
		<option value="4">가입인사</option>
		<option value="5">공지사항</option>
	</select>

	<div>
		<button type="button" class="btn btn-primary"
			onclick="location.href = '${pageContext.request.contextPath}/club/clubBoardCreate.do'">작성</button>
	</div>


	<table class="table">
		<thead class="thead-light" id="boardTable">
			<tr>
				<th scope="col">제목</th>
				<th scope="col">First</th>
				<th scope="col">Last</th>
				<th scope="col">Handle</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

</section>


<script>
	document.querySelector("#boardType").addEventListener("change",(e)=>{
		const boardType =e.target.value;
		const tbody =document.querySelector("#boardTable tbody");
		console.log(tbody);
		
		$.ajax({
			url : '${pageContext.request.contextPath}/club/findBoardType.do',
			method:"GET",
			data :{boardType},
			success(boards){
				console.log(boards);
				
				const tbody =document.querySelector(".thead-light tbody");
				
				
			}
		});
		
	});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>