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

.wrap {
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
<body>

	<%-- <a href="${pageContext.request.contextPath}/chat/chatBox.jsp">목록으로 돌아가기</a> --%>

	<sec:authorize access="isAuthenticated()">

		<sec:authentication property="principal.username" var="memberId" />

		<script>
		const memeberId = "${memberId}";
		const clubId = ${clubId};
		
		console.log(memeberId);
		
	</script>

		<section id="club-chatRoom-sec" class="">

			<div class="wrap" id="chatWrap">

				<c:if test="${not empty cahtlogs}">

					<c:forEach items="cahtlogs" var="chatlog">

						<c:if test="${writer eq memberId}">
							<div class="chat ch2">
								<div class="icon">
									<i class="fa-solid fa-user"></i>
								</div>
								<div class="textbox">${content}</div>
							</div>
						</c:if>

						<c:if test="${writer ne memberId}">
							<div class="chat ch1">
								<div class="icon">
									<i class="fa-solid fa-user"></i>
								</div>
								<div class="textbox">${content}</div>
							</div>
						</c:if>



					</c:forEach>

				</c:if>

				<c:if test="${empty cahtlogs}">

					<div class="textbox">채팅을 시작하세요</div>
				</c:if>

			</div>

			<!-- 			<div class="chat ch1">
				<div class="icon">
					<i class="fa-solid fa-user"></i>
				</div>
				<div class="textbox">안녕하세요. 반갑습니다.</div>
			</div>
			<div class="chat ch2">
				<div class="icon">
					<i class="fa-solid fa-user"></i>
				</div>
				<div class="textbox">안녕하세요. 친절한효자손입니다. 그동안 잘 지내셨어요?</div>
			</div>
 -->
			<div>
				<textarea rows="3" cols="30" id="msgBox"></textarea>
				<button id="snedMsg">전송</button>
			</div>
		</section>

	</sec:authorize>
	<script>



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
	
	const payload = {
			type : "MOIMTALK",
			from : memeberId,
			to : clubId,
			content : content,
			createdAt : Date.now()
		};
		console.log(payload);
		
		const url = `/app/clubTalk/\${payload.to}`;
		
		stompClient.send(url, null, JSON.stringify(payload));

});
	



</script>

</body>
</html>