<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubBoardDetail.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp">
	<jsp:param value="게시글" name="title" />
</jsp:include>

<script>
	 window.onload=()=>{
		 const likeCheck=${liked};
		 likeChecked(likeCheck);
	 }
</script>

<section id="club-boardDetail-sec" class="">
		<nav id="club-title" class="">
		<c:if test="${layout.title eq null}">
			<div id="default-title">
				<h2>${domain}</h2>
			</div>
		</c:if>
		
		<c:if test="${layout.title ne null}">
			<img src="${pageContext.request.contextPath}/resources/upload/club/title/${layout.title}">
		</c:if>
	</nav>
	
	<nav id="club-nav-bar" style="border-color: ${layout.pointColor}">
		<h5><a href="${pageContext.request.contextPath}/club/${domain}">🚩${clubName}</a></h5>
		<div class="fontColors">
			<ul>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">📢공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">🐳자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">✋가입인사</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">🎉정모후기</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubGallery.do">📷갤러리</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">📅일정</a></li>
			</ul>
		</div>
	</nav>
	

	<div class="container mt-5">
		<div class="row">
			<div class="col-md-8 offset-md-2">
				<div class="card">
					<div class="card-body">
						<h3 class="card-title">${clubBoard.title}</h3>
						<p class="card-text2"> ${nickname} &nbsp;|&nbsp; 
							<fmt:parseDate value="${clubBoard.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="boardCreatedAt"/>
			    			<fmt:formatDate value="${boardCreatedAt}" pattern="yy.MM.dd HH:mm"/>
						</p>
						<hr>
						<c:forEach items="${attachments}" var="attach">
							<img
								src="${pageContext.request.contextPath}/resources/upload/club/board/${attach.renamedFilename}"
								class="card-img-top attach-img" alt="첨부된 이미지" style="width: 690px;">
						</c:forEach>
						<p class="card-text1">${clubBoard.content}</p>
						
						<sec:authentication property="principal.username" var="username"/>
						<c:if test="${clubBoard.writer eq username or ClubMemberRole != 0}">
							<div>
								<div>
									
									<button type="button" class="btn btn-secondary btn-lg"
										onclick="updateButton();">수정</button>
									<button type="button" class="btn btn-secondary btn-lg"
										onclick="deleteButton();">삭제</button>
								</div>
							</div>
						</c:if>
						
						
					</div>
					<div class="card-footer">
						<div class="like-wrapper">
							<i id="heartEM" class="fa-regular fa-heart fa-2xl" style="color: #f50000;" onclick="heartClick1(event)"></i>
							<i id="heartEM2" class="fa-solid fa-heart fa-bounce fa-2xl" style="color: #f50000;" onclick="heartClick2(event)"></i>
							<input type="checkbox" id="like" ${liked ? 'checked' : ''} style="display: none;" /> <label
								for="heart" id="heartButton"> ${clubBoard.likeCount} </label>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div>

		<div class="comment-input">
			<div id="count-input">0/99</div>
			<textarea id="comment-textarea" class="comment-textarea" placeholder="댓글을 입력하세요." maxlength="98" style="height: 65px;"></textarea>
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
							<h2 class="name">${comment.nickname}</h2>
							<p class="comment">${comment.content}</p>
							<p class="comment-createdAt">
								<fmt:parseDate value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
				    			<fmt:formatDate value="${createdAt}" pattern="yy.MM.dd HH:mm"/>
				    		</p>
						</div>
					</div>
				</c:forEach>
				
			</c:if>
		</div>
	</div>
	

	<form:form name="detailFrm"></form:form>

</section>

<script>

// 레이아웃 및 네브바
document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";



document.querySelector("#comment-textarea").onkeyup = (e) => {
	const tag = document.querySelector("#count-input");
	tag.innerHTML = e.target.textLength;
	tag.innerHTML += '/99';
};


document.querySelector("#comment-textarea").addEventListener("keydown", (e) => {
	 if (e.key === "Enter" && !e.shiftKey) {
		 e.preventDefault();
		 creatComment();
	 }
});
	
// 비동기 댓글작성 후 출력
const creatComment = () => {
	const commentContent=document.querySelector("#comment-textarea");
	const content= commentContent.value;
	const boardId=${clubBoard.boardId};
	const token= document.detailFrm._csrf.value;
	commentContent.value="";
	
	$.ajax({
		url : '${pageContext.request.contextPath}/club/${domain}/createComment.do',
		method:"POST",
		data :{boardId, content},
		headers: {
			"X-CSRF-TOKEN": token
		},
		success(data) {
			const {boardId, commentId, commentLevel, commentRef, content, createdAt, status, nickname, profile} = data;
			
			// date formatting
			const parsedDate = new Date(createdAt);
			const options={ 
					year: '2-digit',
					month: '2-digit',
					day: '2-digit',
				 	hour: '2-digit',
					minute: '2-digit',
					hour12: false};
			
			const formattedDate = parsedDate.toLocaleDateString('ko-KR', options);
			
			
			const newCommentDiv = document.createElement("div");
			newCommentDiv.className="profile-card";
			newCommentDiv.innerHTML=`
				<img class="profile-picture"
				src="http://localhost:8080/dagachi/resources/upload/member/profile/\${profile}"
				alt="">
				<div class="profile-info">
					<h2 class="name">\${nickname}</h2>
					<p class="comment">\${content}</p>
					<p class='comment-createdAt'>\${formattedDate}</p>
				</div>
			`;
			
			 document.querySelector(".profile-info").innerHTML = '';
			 const commentBox = document.querySelector("#commentBox");
		     commentBox.appendChild(newCommentDiv);
		} // success
	}); // ajax
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
			success(msg) {
				alert(msg);
				window.location.href = "${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=0";
			}
		});
	}
		
	
};

const likeChecked=(like)=>{
	
	if(like){
		document.querySelector("#heartEM").style.display = "none";
		document.querySelector("#heartEM2").style.display = "inline";
	}
	else{
		document.querySelector("#heartEM2").style.display = "none";
		document.querySelector("#heartEM").style.display = "inline";
	}
};


const heartClick1=(e)=> {
 
	e.target.style.display = "none";
	document.querySelector("#heartEM2").style.display = "inline";
	document.querySelector("#like").click();
	
};

const heartClick2=(e)=>  {
	 
	e.target.style.display = "none";
	document.querySelector("#heartEM").style.display = "inline";
	document.querySelector("#like").click();
	
};


document.querySelector("#like").addEventListener("click", () => {
	const like = document.querySelector("#like").checked;
	const token= document.detailFrm._csrf.value;
	const boardId="${clubBoard.boardId}";
	
	$.ajax({
		url : '${pageContext.request.contextPath}/club/${domain}/likeCheck.do',
		method:"POST",
		data :{like , boardId},
		headers: {"X-CSRF-TOKEN": token},
		success(board) {
			const {boardId,clubId,content,createdAt,likeCount,status,title,type,writer} = board;
			const likeCountBox =document.querySelector("#heartButton");
			likeCountBox.innerText=`\${likeCount}`;
		}
	});
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>