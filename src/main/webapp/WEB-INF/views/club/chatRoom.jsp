<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="채팅방" name="title" />
</jsp:include>


<section id="club-chatRoom-sec" class="">
<style>
#chatWrap {
    overflow-y: scroll;
    max-height: 400px; /* 원하는 최대 높이로 설정 */
}

.textbox {
    margin-top: 10px;
    margin-bottom: 10px;
}
</style>
 	<script>
 		const moimTitle="가제";
	</script>
	
	  <div class="wrap" id="chatWrap">
	  	<div>\${moimTitle} 가제(디비가 없는 관계)</div>
	 
	  
        <div class="chat ch1">
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="textbox">안녕하세요. 반갑습니다.</div>
        </div>
        <div class="chat ch2">
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="textbox">안녕하세요. 친절한효자손입니다. 그동안 잘 지내셨어요?</div>
        </div>
     	
     	
        
      
    </div>
	  <div>
        	<textarea rows="3" cols="30" id="msgBox" ></textarea>
        	<button id="snedMsg">전송</button>
        </div>
	
	<script>
	document.querySelector("#snedMsg").onclick = (e) => {
		const payload = {
			type : "MOIMTALK",
			from : memberId,
			to : moimTitle,
			content : document.querySelector("#msgBox").value,
			createdAt : Date.now()
		};
		console.log(payload);
		
	
		
		const url = `/app/moimtalk/\${payload.to}`;
		
		stompClient.send(url, null, JSON.stringify(payload));
		
		
		document.querySelector("#msgBox").value ="";
		document.querySelector("#msgBox").focus();
		
	};
	
	</script>

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>