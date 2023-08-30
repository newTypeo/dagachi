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

	<style>
.profile-card {
	background-color: #ffffff;
	border-radius: 10px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	display: flex;
	padding: 20px;
}

.profile-picture {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	margin-right: 15px;
	border: 1px solid;
}

.profile-info {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.name {
	font-size: 1.2rem;
	margin: 0;
	color: #333333;
}

.comment {
	font-size: 0.9rem;
	margin: 5px 0 0;
	color: #666666;
}

.comment-input {
	display: flex;
	align-items: center;
	margin-top: 20px;
}

.comment-textarea {
	flex: 1;
	border: 1px solid #ccc;
	border-radius: 3px;
	padding: 10px;
	resize: none;
}

.comment-button {
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 3px;
	padding: 5px 10px;
	margin-left: 10px;
	cursor: pointer;
}
</style>

	<div class="container mt-5">
		<div class="row">
			<div class="col-md-8 offset-md-2">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">게시글 제목 : ${clubBoard.title}</h5>

						<c:forEach items="${attachments}" var="attach">
							<img
								src="${pageContext.request.contextPath}/resources/upload/club/board/${attach.renamedFilename}"
								class="card-img-top" alt="첨부된 이미지">
						</c:forEach>
						<p class="card-text">${clubBoard.content}</p>
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
							<input type="checkbox" id="like" ${liked ? 'checked' : ''} /> <label
								for="heart" id="heartButton"> ${clubBoard.likeCount} </label>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div>

		<div class="comment-input">
			<textarea id="comment-textarea" class="comment-textarea"
				placeholder="댓글을 입력하세요. :)"></textarea>
			<button id="comment-button" class="comment-button"
				onclick="creatComment()">게시</button>
		</div>


		<div id="commentBox">
			<c:if test="${empty comments}">
				<div class="profile-card">
					<div class="profile-info">
						<p class="comment">아직 댓글이 없습니다.</p>
					</div>
				</div>
			</c:if>

			<c:if test="${not empty comments}">

				<c:forEach items="${comments}" var="comment">

					<div class="profile-card">
						<img class="profile-picture"
							src="${pageContext.request.contextPath}/resources/upload/member/profile/${comment.profile}"
							alt="">
						<div class="profile-info">
							<h2 class="name">${comment.writer}</h2>
							<p class="comment">${comment.content}</p>
						</div>
					</div>

				</c:forEach>

			</c:if>

		</div>


	</div>



	<form:form name="detailFrm"></form:form>

</section>

<script>
	
	document.querySelector("#comment-textarea").addEventListener("keydown",(e)=>{
		 if (e.key === "Enter" && !e.shiftKey) {
			 e.preventDefault();
			 creatComment();
		 }
	});
		
	
	const creatComment=()=>{
		const commentContent=document.querySelector("#comment-textarea");
		const content= commentContent.value;
		const boardId=${clubBoard.boardId};
		const token= document.detailFrm._csrf.value;
		
		commentContent.value="";
		
		console.log(content);
		console.log(boardId);
		
		$.ajax({
			url : '${pageContext.request.contextPath}/club/${domain}/createComment.do',
			method:"POST",
			data :{boardId,content},
			headers: {
				"X-CSRF-TOKEN": token
			},
			success(data) {
				console.log(data);
				const {boardId,commentId,commentLevel,commentRef,content,createdAt,status,writer,profile}=data;
				
				const newCommentDiv = document.createElement("div");
				newCommentDiv.className="profile-card";
				newCommentDiv.innerHTML=`
					<img class="profile-picture"
					src="http://localhost:8080/dagachi/resources/upload/member/profile/\{profile}"
					alt="">
					<div class="profile-info">
						<h2 class="name">${comment.writer}</h2>
						<p class="comment">${comment.content}</p>
					</div>
				`;
				
				 const commentBox = document.querySelector("#commentBox");
			     commentBox.appendChild(newCommentDiv);
			}
		});
		
		
	};
	

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