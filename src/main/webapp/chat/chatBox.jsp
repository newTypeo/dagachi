<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
	
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">

<!-- 사용자작성 css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chat.css" />

<sec:authorize access="isAuthenticated()">

	<sec:authentication property="principal" var="currentUser" />

	<script>
		let clubIds=[];
	
	<c:forEach items="${currentUser.clubMember}" var="club">
		
		clubIds.push(${club.clubId});
	</c:forEach>
	
		window.onload = ()=>{
			
			openChatList();
						
			//openChatList(memberId)
		};
	</script>
</sec:authorize>

</head>
<body>
	<div id="chatBox">

		<table id="chatListBox">
			<thead>
				<tr>
					<th colspan="2">채팅</th>
				</tr>
			</thead>

			<tbody>
				
			</tbody>
		</table>

	</div>

	<script>
	
	const openChatList=()=>{
		
		const chatListBody= document.querySelector("#chatListBox tbody");
		let html="";
		
		if(clubIds.length>0){
			clubIds.forEach((clubId)=>{
				$.ajax({
					url : "${pageContext.request.contextPath}/chat/chat/findChatList.do",
					data : {clubId},
					success(data) {
						if(data.cahtlog !=null){
							const {id,clubId,writer,content,createdAt,nickname}=data.cahtlog
							const parsedDate =new Date(createdAt);
							const options={   year: '2-digit',
									  month: '2-digit',
									  day: '2-digit',
									  hour: '2-digit',
									  minute: '2-digit',
									  hour12: false};
							const formattedDate = parsedDate.toLocaleDateString('ko-KR', options);
							html+=`
								<tr>
									<td colspan = "2" class="clubNameWrapper">
										<img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${data.clubProfile}"/>
										<div class="clubNameContainer">
											<span class="clubName">\${data.clubName}</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="writerAndCreatedAt">
											<span>\${nickname }</span>
											<span>\${formattedDate}</span>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan = "2">
										<div class="content">
											<a href="${pageContext.request.contextPath}/chat/chatRoom?no=\${clubId}">
												<div class="truncate-text">\${content}</div>
											</a>
										</div>
									</td>
								</tr>
							`;
							
						}else{
							html+=`
								<tr>
									<td colspan = "2" class="clubNameWrapper">
										<img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${data.clubProfile}"/>
										<div class="clubNameContainer">
											<span class="clubName">\${data.clubName}</span>
										</div>
									</td>
								</tr>
								<tr class="border2">
									<td colspan = "2">
										<div class="noChatBox">
											<a href="${pageContext.request.contextPath}/chat/chatRoom?no=\${clubId}">대화 목록이 없습니다. 대화를 시작하세요.</a>
										</div>
									</td>
								</tr>
							`;
						}
						chatListBody.innerHTML=html;
					}
				}); 
				
			});
		}else{
			const chatListBody= document.querySelector("#chatListBox tbody");
			
			html=`
				<tr>
					<td>아직 가입한 클럽이 없습니다</td>
				</tr>
			`;
			chatListBody.innerHTML=html;
		}
		
		
	};
	
	</script>

</body>
</html>


