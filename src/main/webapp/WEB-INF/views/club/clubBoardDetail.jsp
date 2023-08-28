<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글" name="title" />
</jsp:include>

<section id="club-boardDetail-sec" class="">

	<div class="container mt-5">
	    <div class="row">
	        <div class="col-md-8 offset-md-2">
	            <div class="card">
	                <img src="${pageContext.request.contextPath}/resources/club/board/" class="card-img-top" alt="첨부된 이미지">
	                <div class="card-body">
	                    <h5 class="card-title">게시글 제목</h5>
	                    <p class="card-text">
	                        게시글 내용이 여기에 들어갑니다. 게시글의 내용이나 추가적인 설명을 이곳에 표시할 수 있습니다.
	                    </p>
	                    <p class="card-text">작성자: John Doe</p>
	                </div>
	                <div class="card-footer">
	                    작성일: 2023년 8월 28일
	                    <div class="d-flex justify-content-between align-items-center">
	                        <div class="like-button">
	                            <button class="btn btn-sm btn-outline-primary">좋아요</button>
	                            <span class="ml-1"><i class="fas fa-heart text-danger"></i> 10</span>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	<div>
		<div id="hartContainer">
			<div id="hartButton">❤</div>
			<input type="checkbox" id="like" style="display: none;"> <label
				for="hartButton"></label>
		</div>
		<div>
			<button type="button" class="btn btn-secondary btn-lg"
				onclick="updateButton()">수정</button>
			<button type="button" class="btn btn-secondary btn-lg"
				onclick="deleteButton()">삭제</button>
		</div>
	</div>

	<form:form name="detailFrm"></form:form>

</section>

<script>

	const updateButton=()=>{
		
		window.location.href = "${pageContext.request.contextPath}/club/${domain}/boardUpdate.do?no=${clubBoard.boardId}";
	};
	
	const deleteButton=()=>{
		if(confirm("게시글을 삭제하시겠습니까?")){
			
			const token= document.detailFrm._csrf.value;
			const boardId= "${clubBoard.boardId}";
			
			$.ajax({
				url : '${pageContext.request.contextPath}/club/${domain}/delBoard.do',
				method:"POST",
				data :{ boardId },
				headers: {
					"X-CSRF-TOKEN": token
				},
				success(data){
					alert(data);
					window.location.href = "${pageContext.request.contextPath}/club/${domain}/clubBoardList.do";
				}
			});
		}
			
		
	};

	document.querySelector("#hartButton").addEventListener("click",()=>{
		const likeBox = document.querySelector("#like");
		likeBox.checked = !likeBox.checked; 
		const like =likeBox.value;
		likeBox.value=  likeBox.checked ? "true" : "false";
		const token= document.detailFrm._csrf.value;
		console.log(token);
		const boardId="${clubBoard.boardId}"
		
		$.ajax({
			url : '${pageContext.request.contextPath}/club/${domain}/likeCheck.do',
			method:"POST",
			data :{like , boardId },
			headers: {
				"X-CSRF-TOKEN": token
			},
			success(board){
				console.log(board);
				const {boardId,clubId,content,createdAt,likeCount,status,title,type,writer} = board;
				const likeCountBox =document.querySelector("#likeCount");
				likeCountBox.innerText=`\${likeCount}`
				
			}
		});
		
	});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>