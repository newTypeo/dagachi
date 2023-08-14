//

const ws = new SockJS(`http://${location.host}/spring/stomp`); // endpoint
const stompClient = Stomp.over(ws);\


stompClient.connect({}, (frame) => {
	console.log('open : ', frame);
});


const renderMessage = (message) => {
	
	const {type, from, to, content, createdAt} = JSON.parse(message.body);
	
	switch(type){
	
	}
}; 