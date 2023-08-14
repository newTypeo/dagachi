//

const ws = new SockJS(`http://${location.host}/spring/stomp`); // endpoint
const stompClient = Stomp.over(ws);\


stompClient.connect({}, (frame) => {

});


const renderMessage = (message) => {

}; 