<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방</title>

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


<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"
	integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"
	integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
</head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css" />
<style>
 .resized-image {
            width: 100%; /* 원하는 크기로 조절 */
            height: auto; /* 가로 세로 비율을 유지하기 위해 */
}
#chatWrap {
	overflow-y: scroll;
	max-height: 400px; /* 원하는 최대 높이로 설정 */
}

.textbox {
	margin-top: 10px;
	margin-bottom: 10px;
}

* {
	padding: 0;
	margin: 0;
	box-sizing: border-box;
}

a {
	text-decoration: none;
}

.wrap {bbnb
	padding: 40px 0;
	background-color: #A8C0D6;
}

.wrap .chat {
	display: flex;
	align-items: flex-start;
	padding: 20px;
}

.wrap .chat .icon {
	position: relative;
	overflow: hidden;
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background-color: #eee;
}

.wrap .chat .icon i {
	position: absolute;
	top: 10px;
	left: 50%;
	font-size: 2.5rem;
	color: #aaa;
	transform: translateX(-50%);
}

.wrap .chat .textbox {
	position: relative;
	display: inline-block;
	max-width: calc(100% - 70px);
	padding: 10px;
	margin-top: 7px;
	font-size: 13px;
	border-radius: 10px;
}

.wrap .chat .textbox::before {
	position: absolute;
	display: block;
	top: 0;
	font-size: 1.5rem;
}

.wrap .ch1 .textbox {
	margin-left: 20px;
	background-color: #ddd;
}

.wrap .ch1 .textbox::before {
	left: -15px;
	content: "◀";
	color: #ddd;
}

.wrap .ch2 {
	flex-direction: row-reverse;
}

.wrap .ch2 .textbox {
	margin-right: 20px;
	background-color: #F9EB54;
}

.wrap .ch2 .textbox::before {
	right: -15px;
	content: "▶";
	color: #F9EB54;
}


</style>
<script>
	window.onload=()=>{
		 document.querySelector("#chatWrap").scrollTop = document.querySelector("#chatWrap").scrollHeight;
	}

</script>
<body>


	<sec:authorize access="isAuthenticated()">

		<sec:authentication property="principal.username" var="memberId" />

		<script>
		const memberId = "${memberId}";
		const clubId = ${clubId};
		const root="${pageContext.request.contextPath}";
	 	let proList=[];

		
	</script>
	
	

		<article id="club-chatRoom-sec" class="">

			<a href="${pageContext.request.contextPath}/chat/chatBox.jsp">목록으로
				돌아가기</a>
			<div class="wrap" id="chatWrap">


				<c:if test="${not empty chatlogs}">

					<c:forEach items="${chatlogs}" var="chatlog">
						<c:if test="${chatlog.writer eq memberId}">
							<div><h6 class="chatIdPrintR">${chatlog.writer}</h6></div>
							<div class="chat ch2">
								<div class="icon">
									<i class="fa-solid fa-user"></i> <img alt=""
										src="${pageContext.request.contextPath}/resources/upload/member/profile/<sec:authentication property="principal.memberProfile.renamedFilename"/>" class="resized-image"/>
								</div>
								<div class="textbox">${chatlog.content}</div>
							</div>
						</c:if>

						<c:if test="${chatlog.writer ne memberId}">
						<div><h6 class="chatIdPrintL">${chatlog.writer}</h6></div>
							<div class="chat ch1">
								<div class="icon">
									<i class="fa-solid fa-user"></i>
									<c:forEach items="${memberProfiles}" var="memberProfile">
										<c:if test="${memberProfile.memberId eq chatlog.writer}">
											<img alt=""
												src="${pageContext.request.contextPath}/resources/upload/member/profile/${memberProfile.renamedFilename}" class="resized-image" />
										</c:if>
									</c:forEach>
								</div>
								<div class="textbox">${chatlog.content}</div>
							</div>
						</c:if>



					</c:forEach>

				</c:if>

				<c:if test="${empty chatlogs}">
					<div class="chat">
						<div class="icon">
							<i class="fa-solid fa-user"></i> <img alt=""
								src="${pageContext.request.contextPath}/resources/upload/member/profile/<sec:authentication property="principal.memberProfile.renamedFilename" />" class="resized-image" />
						</div>
						<div class="textbox">채팅을 시작하세요</div>
					</div>
				</c:if>

			</div>

			<div>
				<textarea rows="3" cols="30" id="msgBox"></textarea>
				<button id="snedMsg">전송</button>
			</div>
		</article>

	</sec:authorize>
	<script>
const loadPro=(from,to)=>{
	let pro="";
	$.ajax({
 		url:'${pageContext.request.contextPath}/chat/findWriterProfile.do',
 		data : {from,to},
 		async :false,
 		success(data){
 			console.log(data,decodeURI(data));
 			if(data !== null){
 				 pro= decodeURI(data);
 			}
 			const profileInfo ={userName : from, userProfileName : data};
 			proList.push(profileInfo);
 			console.log("유저당 한번만 나와야하ㄴ는 콘솔");
 		}
 		
 	});
	return pro;
};

const loadProProList=(clubId)=>{
		
};

document.querySelector("#msgBox").addEventListener("keydown",(e)=>{
	 if (e.key === "Enter" && !e.shiftKey) {
		 e.preventDefault();
		 document.querySelector("#snedMsg").click();
	 }
});

document.querySelector("#snedMsg").addEventListener("click",()=>{
	const msgbox=document.querySelector("#msgBox");
	const content=msgbox.value;
	console.log(content);
	msgbox.value="";
	
	if(content===""){
		alert("메세지가 비었습니다");
		msgbox.focus();
		return false;
	}
	const payload = {
			type : "MOIMTALK",
			from : memberId,
			to : clubId,
			content : content,
			createdAt : Date.now()
		};
		console.log(payload);
		
		const url = `/app/clubTalk/\${payload.to}`;
		
		stompClient.send(url, null, JSON.stringify(payload));

	msgbox.focus();
});
	



</script>

</body>
</html>