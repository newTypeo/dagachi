console.log('Hello stomp.js');

const ws = new SockJS(`http://${location.host}/dagachi/stomp`); // endpoint
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log('open : ', frame);
	
	
	
	stompClient.subscribe(`/app/clubTalk/${clubId}`, (message) => {
		console.log(`/app/clubTalk/${clubId} : `, message);
		renderMessage(message);
	});
	
	
});


const renderMessage = (message) => {
	
	const {type, from, to, content, createdAt} = JSON.parse(message.body);
	
	switch(type){
	 	case "MOIMTALK":
	 	const chatWrap =document.querySelector("#chatWrap");
	 	const divbox=document.createElement('div');
	 	if(from === memberId)
	 		divbox.className = 'chat ch2';
	 	else
	 		divbox.className = 'chat ch1';
	 		
	 	divbox.innerHTML=`
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="textbox">${content}</div>
      	 	</div>
	 	` ;
	 	chatWrap.appendChild(divbox);
      	 document.querySelector("#chatWrap").scrollTop = document.querySelector("#chatWrap").scrollHeight;
	 	 
	 	 
	 	 
	 	 break;
	}
}; 