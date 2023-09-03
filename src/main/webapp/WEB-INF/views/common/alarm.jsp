<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
<script >
		const memberId= "<sec:authentication property="principal.memberId"/>";
		window.roomMaps = new Map();

		window.onload=()=>{
			alarmLoad();
		};
		
</script>

		<i id="bell" class="fa-solid fa-bell fa-2xl"></i>
		<div id="alarmBox" class=""></div>

		<script>
				
				document.querySelector("#bell").addEventListener("click",(e)=>{
					const receiver= memberId;
					const bell=e.target;
					const token= document.memberLogoutFrm._csrf.value;
					bell.classList.remove("fa-beat");
					
					const alarmBox=document.querySelector("#alarmBox");
					const computedStyle = window.getComputedStyle(alarmBox);
					const displayPropertyValue = computedStyle.getPropertyValue("display");
					
					if (displayPropertyValue === "none"){
						  alarmBox.style.display = "inline";
		
						$.ajax({
							url:"${pageContext.request.contextPath}/notification/checkedAlarm.do",
							method :"POST",
							data:{receiver},
							headers: {
								"X-CSRF-TOKEN": token
							},
							success(){}
						});
						
					}
					else 
						  alarmBox.style.display = "none";
					
					
					 
				});
				
				
				const alarmLoad=()=>{
					const receiver= memberId;
					console.log(receiver);
					$.ajax({
						url:"${pageContext.request.contextPath}/notification/findAlarms.do",
						data:{receiver},
						success(alarms){
							console.log(alarms);
					
							if(alarms.length>0){
								alarms.forEach((alarm)=>{
									const {id,receiver,sender,type,createdAt,content}=alarm;
									
									const alarmWrap=document.querySelector("#alarmBox");
									if(type==="CHATNOTICE"){
										const divId=`#\${content.replace(/\s/g, "_")}`;
										const spanId=`#\${content.replace(/\s/g, "-")}`;
										
										const chatRoomCheck=document.querySelector(divId);
										if(chatRoomCheck === null){
											roomMaps.set(content, 1);
											const alarmDiv=document.createElement('div');
											alarmDiv.setAttribute('id', content.replace(/\s/g, "_"));
											alarmDiv.className = 'list-group';
											alarmDiv.innerHTML=`
												 <a href="#" class="list-group-item list-group-item-action list-group-item-light">
													\${content} :새로운 메세지가 도착하였습니다 
													<span id="\${content.replace(/\s/g, "-")}" class="badge badge-primary">
														\${roomMaps.get(content)}
													</span>
												</a>
											`;
											alarmWrap.appendChild(alarmDiv);
										}else{
											roomMaps.set(content, (roomMaps.get(content)+ 1));
											
											document.querySelector(spanId).innerText=`\${roomMaps.get(content)}`;
										}
									
									}else{
						
								 	 	const noticeAlarm=document.createElement('div');
								 	 	noticeAlarm.className = 'list-group';
								 	 	noticeAlarm.innerHTML=`
												 <a href="#" class="list-group-item list-group-item-action list-group-item-light">
													\${content} 
												</a>
											`;
										alarmWrap.appendChild(noticeAlarm);
									}
								
								});
								
								document.querySelector("#bell").classList.add("fa-beat");
							}
						
						}
						
					});
				}; 
				
				</script>
</sec:authorize>