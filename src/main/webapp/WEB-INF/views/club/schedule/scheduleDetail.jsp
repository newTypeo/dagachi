<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93a8b5c4b928b15af7b1a5137fba4962"></script>

<section id="club-board-sec" class="">

	<nav id="club-title" class="">
		<c:if test="${layout.title eq null}">
			<div id="default-title">
				<h2>${domain}</h2>
			</div>
		</c:if>
		
		<c:if test="${layout.title ne null}">
			<img src="${pageContext.request.contextPath}/resources/upload/club/title/${layout.title}">
		</c:if>
	</nav>
	
	<nav id="club-nav-bar" style="border-color: ${layout.pointColor}">
		<h5><a href="${pageContext.request.contextPath}/club/${domain}">🚩${clubName}</a></h5>
		<div class="fontColors">
			<ul>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">📢공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">🐳자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">✋가입인사</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">🎉정모후기</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubGallery.do">📷갤러리</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">📅일정</a></li>
			</ul>
		</div>
	</nav>

	<div id="schedule-content-container">
		<h3>${schedule.title}</h3>	
		<div>
			<figure>
				<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${schedule.renamedFilename}">
			</figure>
			<div>
				<strong><a>${schedule.nickname}</a> | 
					<c:if test="${clubMember.clubMemberRole eq 3}">
					🥇방장
					</c:if>
					<c:if test="${clubMember.clubMemberRole eq 2}">
					🥇부방장
					</c:if>
					<c:if test="${clubMember.clubMemberRole eq 1}">
					🥇임원
					</c:if>
					<c:if test="${clubMember.clubMemberRole eq 0}">
					🎀일반회원
					</c:if>
				</strong><br>
				<span>
					<fmt:parseDate value="${schedule.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
	    			<fmt:formatDate value="${createdAt}" pattern="yyyy.MM.dd HH:mm"/>
				</span>
			</div>
		</div>
		<div id="schedule-content-container2">
			<div id="scc2-left">
			</div>
			<div id="scc2-right">
				<div id="map" style="width:800px;height:800px;"></div>
			</div>
		</div>
	</div>

	
	
</section>

<div>${schedule}</div>
<div>
</div>

<script>

document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";

// -------------------------------길찾기--------
const startX = '${schedule.places[0].getXCo()}';
const startY = '${schedule.places[0].getYCo()}';

var container = document.getElementById('map');
var options = {
	center: new kakao.maps.LatLng(startY, startX),
	level: 5
};
var map = new kakao.maps.Map(container, options);

window.addEventListener('DOMContentLoaded', function() {
    // 버튼 클릭 효과 처리
    document.querySelector('.onloadBtn').click();
});


const REST_API_KEY = '0b08c9c74b754bc22377c45ec5ce2736';
const url = 'https://apis-navi.kakaomobility.com/v1/directions?';
var polyline = new kakao.maps.Polyline({
	strokeWeight: 4,
	strokeColor: 'darkred',
	strokeOpacity: 0.8,
	strokeStyle: 'solid'
}); 

function getPath(elem) {
	polyline.setMap(null);
	const startSeq = elem.classList[0].split("to")[0];
	const endSeq = elem.classList[0].split("to")[1];
	var leng = endSeq - startSeq + 1;
	
	getPoint(startSeq, endSeq, leng); // 마커를 표시하고 지도 위치 이동
	
	var keywordUrl = ''; // url뒤에 붙을 내용
	var origin = '';
	var waypoints = '';
	var destination = '';
	
	for (let i = startSeq; i <= endSeq; i++) {
		var xStr = document.querySelector(".seq"+i).classList[1];
		var yStr = document.querySelector(".seq"+i).classList[2];
		var name = document.querySelector(".seq"+i).innerHTML;
		if (i == startSeq) {
			origin = xStr + ',' + yStr;
		} else if (i == endSeq) {
			destination = xStr + ',' + yStr;
		} else {
			waypoints += xStr + ',' + yStr;
			if (i != endSeq-1) {
				waypoints += '|';
			}
		}
	}
	keywordUrl += 'origin=' + origin + '&waypoints=' + waypoints + '&destination=' + destination;
	const requestUrl = url + keywordUrl;
	
	fetch(requestUrl, {
		method: "GET",
		headers: {
			"Authorization": 'KakaoAK ' + REST_API_KEY
		}
	})
	.then(response => response.json())
	.then(data => {
		
		const linePath = [];
		data.routes[0].sections.forEach((section) => {
			section.roads.forEach((road) => {
				road.vertexes.forEach((vertex, index) => {
					// x,y 좌표가 우르르 들어옵니다. 그래서 인덱스가 짝수일 때만 linePath에 넣어봅시다.
					// 저도 실수한 것인데 lat이 y이고 lng이 x입니다.
					if (index % 2 === 0) {
						linePath.push(new kakao.maps.LatLng(road.vertexes[index + 1], road.vertexes[index]));
					}
				});
			});
		});
		polyline.setPath(linePath);
		polyline.setMap(map);
	})
	.catch(error => {
		// 오류 처리
		console.error("Error:", error);
	});
	
}





function getPoint(startSeq, endSeq, leng) {
	var xSum = 0;
	var ySum = 0;
	
	for (let i = startSeq; i <= endSeq; i++) {
		var x = parseFloat(document.querySelector(".seq"+i).classList[1]);
		var y = parseFloat(document.querySelector(".seq"+i).classList[2]);
		
		xSum += x;
		ySum += y;
	}
	
	map.setCenter(new kakao.maps.LatLng(ySum/leng, xSum/leng)); // 지도 중심 이동
	
	var bounds = new kakao.maps.LatLngBounds();  // 지도를 재설정할 범위정보 객체 생성
	
	for (let i = startSeq; i <= endSeq; i++) {
		var x = parseFloat(document.querySelector(".seq"+i).classList[1]);
		var y = parseFloat(document.querySelector(".seq"+i).classList[2]);
		var marker = new kakao.maps.Marker({
		    position: new kakao.maps.LatLng(y, x)
		});
	    marker.setMap(map); // 마커 추가
	    
	    var extraLatLng = new kakao.maps.LatLng(y, x);
	    bounds.extend(extraLatLng); // 마커가 다 보이도록 영역 확장
	}
	
	map.setBounds(bounds);
}

// --------------------------------------------------

var startDate = new Date('${schedule.getStartDate()}');
var endDate = new Date('${schedule.getEndDate()}');
const scc2Left = document.querySelector("#scc2-left");
var index = 0;
var currentDate = new Date(startDate);

while (currentDate <= endDate) {
	scc2Left.insertAdjacentHTML("beforeend", `
		<div class="scheduleSlide\${index}"></div>		
	`);
	console.log(currentDate);
    currentDate.setDate(currentDate.getDate() + 1);
    index++;
}





document.querySelector(".scheduleSlide0").innerHTML = `
	<div></div>
	<button class="0to${schedule.places.size()} btn btn-primary onloadBtn" onclick="getPath(this);">전체경로</button>
	<h5 class="seq0 ${myHome[0]} ${myHome[1]}">우리집</h5>
	<c:forEach items="${schedule.places}" var="place" varStatus="vs">
		<button class="${vs.index}to${vs.index+1} btn btn-primary" onclick="getPath(this);">경로</button>
		<h5 class="seq${place.sequence} ${place.getXCo()} ${place.getYCo()}">${place.name}</h5>									
	</c:forEach>
`;


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>