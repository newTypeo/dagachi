<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://kit.fontawesome.com/d7ccac7be9.js" crossorigin="anonymous"></script>
<style>
#chat-open-btn {
	z-index: 10;
	position: fixed;
	right: 20px;
    bottom: 20px;
	width: 80px;
	height: 80px;
    text-align: center;
	/* border-radius: 50%;
	background: white; */
}

#chat-open-btn:hover {cursor: pointer;}

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

#chat-box-title {height: 50px;}

/* 채팅이모티콘 */
.fa-cat {font-size : 60px;}
</style>

<div id="chat-open-btn">
	<i class="fa-solid fa-cat" style="color: #1060ea;"></i>
</div>
<!-- <button id="chat-open-btn">
	chat
</button> -->

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



