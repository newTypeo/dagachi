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
	                <div class="card-body">
	                    <h5 class="card-title">게시글 제목 : ${clubBoard.title}</h5>
	                    
	            		<c:forEach items="${attachments}" var="attach">
			                <img src="${pageContext.request.contextPath}/resources/upload/club/board/${attach.renamedFilename}" class="card-img-top" alt="첨부된 이미지">
	            		</c:forEach>
	                    <p class="card-text">
	                        ${clubBoard.content}
	                    </p>
	                    <p class="card-text">작성자: ${clubBoard.writer}</p>
                   		<div>
							<div>
								<button type="button" class="btn btn-secondary btn-lg"
									onclick="updateButton()">수정</button>
								<button type="button" class="btn btn-secondary btn-lg"
									onclick="deleteButton()">삭제</button>
							</div>
						</div>
	                </div>
	                <div class="card-footer">
	                    작성일: ${clubBoard.createdAt}
	                    <div class="like-wrapper">
	                    	<input type="checkbox" id="like" ${liked ? 'checked' : ''}/>
						    <label for="heart" id="heartButton">
						        ${clubBoard.likeCount}
						    </label>
						</div>
	                </div>
	            </div>
	        </div>
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
				success(data) {
					alert(data);
					window.location.href = "${pageContext.request.contextPath}/club/${domain}/clubBoardList.do";
				}
			});
		}
			
		
	};

	document.querySelector("#like").addEventListener("click",()=>{
		const like = document.querySelector("#like").checked;
		console.log(like);
		const token= document.detailFrm._csrf.value;
		const boardId="${clubBoard.boardId}";
		
		$.ajax({
			url : '${pageContext.request.contextPath}/club/${domain}/likeCheck.do',
			method:"POST",
			data :{like , boardId},
			headers: {
				"X-CSRF-TOKEN": token
			},
			success(board){
				console.log(board);
				const {boardId,clubId,content,createdAt,likeCount,status,title,type,writer} = board;
				const likeCountBox =document.querySelector("#heartButton");
				likeCountBox.innerText=`\${likeCount}`;
			}
		});
		
	});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>