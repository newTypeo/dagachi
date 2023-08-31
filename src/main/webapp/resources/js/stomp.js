console.log('Hello stomp.js');

const ws = new SockJS(`http://${location.host}/dagachi/stomp`); // endpoint
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log('open : ', frame);
	
	
	
	stompClient.subscribe(`/app/clubTalk/${clubId}`, (message) => {
		console.log(`/app/clubTalk/${clubId} : `, message);
		
		if(message.headers["content-type"])
			renderMessage(message);
			
	});
	
	stompClient.subscribe(`/app/notice/${memberId}`, (message) => {
			console.log(`/app/clubTalk/${memberId} : `, message);
	
		if(message.headers["content-type"])
			renderMessage(message);
	});
	
	
});


const renderMessage = (message) => {
	
	const {type, from, to, content, createdAt} = JSON.parse(message.body);
	
	
	
	switch(type){
	
		case "CHATNOTICE":
			const alarmWrap=window.parent.document.querySelector("#alarmBox");
			const roomMaps= window.parent.roomMaps;
			console.log(roomMaps);
			const chatRoomCheck=window.parent.document.querySelector("#content");
			if(chatRoomCheck !== chatRoomCheck){
				roomMaps.set(content, (0));
				const alarmDiv=document.createElement('div');
				alarmDiv.setAttribute('id', content);
				alarmDiv.className = 'list-group';
				alarmDiv.innerHTML=`
					 <a href="#" class="list-group-item list-group-item-action list-group-item-light">
						${content} :새로운 메세지가 도착하였습니다 
					</a>
					<span id="" class="badge badge-primary">
						${roomMaps.get(content) || 1}
					</span>
				`;
				alarmWrap.appendChild(alarmDiv);
			}else{
				roomMaps.set(content, (contentCountMap.get(content)) + 1)
				window.parent.document.querySelector("#alarmBox").innerText=`
						${roomMaps.get(content)}
				`;
			}
			
		
		break;
		
		
		
	 	case "MOIMTALK":
		 	const chatWrap =document.querySelector("#chatWrap");
		 	const divbox=document.createElement('div');
			let pro="";
			
			if(proList.length>0){
				for(let i=0; i<proList.length; i++){
				console.log("i번인덱스 확인",proList[i]["userProfileName"]);
					if(proList[i]["userName"]===from){
						pro=proList[i]["userProfileName"];
					}
				}
			}
			
			if(pro === "")
				pro=loadPro(from,to);
			
		 	if(from === memberId)
		 		divbox.className = 'chat ch2';
		 	else
		 		divbox.className = 'chat ch1';
		 		
		 	divbox.innerHTML=`
	            <div class="icon"><i class="fa-solid fa-user"></i>
	           		<img alt="" src="${root}/resources/upload/member/profile/${pro}" class="resized-image" />
	            </div>
	            <div class="textbox">${content}</div>
	      	 	</div>
		 	` ;
		 	chatWrap.appendChild(divbox);
	      	 document.querySelector("#chatWrap").scrollTop = document.querySelector("#chatWrap").scrollHeight;
	 	 break;
	 	 
	 	 
	}
}; 