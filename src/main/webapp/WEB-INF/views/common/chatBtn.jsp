<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#chat-open-btn {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	z-index: 10;
	position: fixed;
	background: white;
	right: 20px;
    bottom: 20px;
    text-align: center;
}

#chat-open-btn:hover {
	cursor: pointer;
}

#chat-wrapper {
	width: 300px;
	height: 600px;
	z-index: 12;
	position: fixed;
	background: white;
	right: 20px;
    bottom: 20px;
    background-color: pink;
    display: none;
}

#chat-box-title {
	height: 50px;
}
</style>

<button id="chat-open-btn">
	채팅
</button>

<div id="chat-wrapper">
	<div id="chat-box-title">
		<span>채팅박스</span>
		<button id="chat-close-btn">X</button>
	</div>
	<iframe name="iframe1" id="iframe1" src="${pageContext.request.contextPath}/chat/chatBox.jsp"
       frameborder="0" border="0" cellspacing="0"
       style="border-style: none; width: 300px; height: 550px; position: relative;">
    </iframe>	
</div>

<script>
const chatOpenBtn = document.querySelector("#chat-open-btn");
const chatCloseBtn = document.querySelector("#chat-close-btn");
const chatWrapper = document.querySelector("#chat-wrapper");

chatOpenBtn.onclick = () => {
	chatWrapper.style.display = "block";
}

chatCloseBtn.onclick = () => {
	chatWrapper.style.display = "none";
}
</script>



