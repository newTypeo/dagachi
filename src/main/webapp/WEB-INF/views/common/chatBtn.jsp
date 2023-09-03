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
	display: flex;
	border-radius: 50%;
	background: #2990D0;
	align-items: center;
    justify-content: center;
}
#chat-open-btn i {
	color: white;
	font-size: 40px;
}

#chat-open-btn:hover {cursor: pointer;}

#chat-wrapper {
	width: 315px;
	height: 600px;
	z-index: 12;
	position: fixed;
	background: white;
	right: 20px;
    bottom: 20px;
    background-color: #2990D0;
    display: none;
    border-radius: 5px;
}

#chat-box-title {
	height: 50px; 
	border-width: 2px 2px 0 2px;
	border-style: solid;
	border-color: #aaa;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	font-weight: bold;
	color: white;
    padding: 5px 10px;
}
#chat-box-title span:first-of-type {
	font-size: 26px;
}
#chat-box-title span:last-of-type {
	font-size: 20px;
	margin: 5px 0;
	cursor: pointer;
}

/* 채팅이모티콘 */
.fa-cat {font-size : 60px;}
</style>

<div id="chat-open-btn">
	<i class="fa-regular fa-comments fa-2xl"></i>
</div>


<div id="chat-wrapper">
	<div id="chat-box-title">
		<span><i class="fa-regular fa-comments"></i> ChatDGC</span>
		<span id="chat-close-btn" style="float:right;">
			<i class="fa-solid fa-x"></i>
		</span>
	</div>
	<iframe name="iframe1" id="iframe1" src="${pageContext.request.contextPath}/chat/chatBox.jsp"
       frameborder="0" border="0" cellspacing="0"
       style="border: 2px solid #aaa; width: 315px; height: 550px; position: relative; 
       border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
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



