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
	
	
});


const renderMessage = (message) => {
	
	const {type, from, to, content, createdAt} = JSON.parse(message.body);
	
	
	
	switch(type){
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