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

	<div>
		<div>${clubBoard.title}</div>
	
		<c:if test="${!attachments.isEmpty()}">
			<div class="dropdown">
				<button class="btn btn-secondary dropdown-toggle" type="button"
					data-toggle="dropdown" aria-expanded="false">DownLoad button</button>
				<div class="dropdown-menu">
					<c:forEach items="${attachments}" var="attachment">
						<a class="dropdown-item" href="#">${attachment.originalFilename}</a>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<div>${clubBoard.content}</div>
		<div>${clubBoard.writer}</div>
		<div>${clubBoard.createdAt}</div>
		<div id="likeCount">${clubBoard.likeCount}</div>

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