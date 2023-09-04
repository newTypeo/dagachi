console.log('Hello stomp.js');

const ws = new SockJS(`http://${location.host}/dagachi/stomp`); // endpoint
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	//console.log('open : ', frame);
	
	
	
	stompClient.subscribe(`/app/clubTalk/${clubId}`, (message) => {
	//	console.log(`/app/clubTalk/${clubId} : `, message);
		
		if(message.headers["content-type"])
			renderMessage(message);
			
	});
	
	stompClient.subscribe(`/app/notice/${memberId}`, (message) => {
			console.log(`/app/notice/${memberId} : `, message);
	
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
			console.log(roomMaps,"룸 널인지 확인");
			const divId=`#${content.replace(/\s/g, "_")}`;
			const spanId=`#${content.replace(/\s/g, "-")}`;
			const chatRoomCheck=window.parent.document.querySelector(divId);
			console.log(window.parent.document.querySelector(spanId),spanId,content.replace(/\s/g, "."));
			if(chatRoomCheck === null){
				roomMaps.set(content, 1);
				const alarmDiv=document.createElement('div');
				alarmDiv.setAttribute('id', content.replace(/\s/g, "_"));
				alarmDiv.className = 'list-group';
				alarmDiv.innerHTML=`
					 <a href="#" class="list-group-item list-group-item-action list-group-item-light">
						${content} :새로운 메세지가 도착하였습니다 
						<span id="${content.replace(/\s/g, "-")}" class="badge badge-primary">
							${roomMaps.get(content)}
						</span>
					</a>
				`;
				alarmWrap.appendChild(alarmDiv);
			}else{
				roomMaps.set(content, (roomMaps.get(content)+ 1));
				
				window.parent.document.querySelector(spanId).innerText=`${roomMaps.get(content)}`;
			}
			
			const bell=window.parent.document.querySelector("#bell");
			bell.classList.add("fa-beat");
		break;
		
		
		
	 	case "MOIMTALK":
		 	const chatWrap =document.querySelector("#chatWrap");
		 	const divbox=document.createElement('div');
			let pro="";
			const namebox=document.createElement('div');
			
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
		 	else{
		 		divbox.className = 'chat ch1';
		 		namebox.innerHTML=`
		 			<h6 class="chatIdPrintL">${from}</h6>
		 		`;
		 		chatWrap.appendChild(namebox);
		 	}
		 		
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
	 	 
	 	 
	 	 case "NOTICE":
	 	 	
	 	 	const noticeAlarm=document.createElement('div');
				noticeAlarm.className = 'list-group';
				noticeAlarm.innerHTML=`
					 <a href="#" class="list-group-item list-group-item-action list-group-item-light">
						${content} 
					</a>
				`;
				alarmWrap.appendChild(alanoticeAlarmrm);
				
			bell.classList.add("fa-beat");
			
	 	 break;
	 	 
	}
}; 