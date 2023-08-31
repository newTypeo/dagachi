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
				<div id="map" style="width:500px;height:400px;"></div>
			</div>
		</div>
	</div>

	
	
</section>
				<button onclick="getCarDirection();">test</button>

<div>${schedule}</div>

<script>

document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";

// -------------------------------길찾기----

var container = document.getElementById('map');
var options = {
	center: new kakao.maps.LatLng(37.394727, 127.110153),
	level: 5
};
var map = new kakao.maps.Map(container, options);


//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(37.394727, 127.110153); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

/* const REST_API_KEY = '0b08c9c74b754bc22377c45ec5ce2736';
const url = 'https://apis-navi.kakaomobility.com/v1/directions?origin=127.11015314141542,37.39472714688412&destination=127.10824367964793,37.401937080111644';
fetch(url, {
	method: "GET",
	headers: {
		"Authorization": 'KakaoAK ' + REST_API_KEY
	}
})
.then(response => response.json())
.then(data => {
	// 여기서 data를 활용하여 원하는 동작을 수행하세요
	console.log(data);
})
.catch(error => {
	// 오류 처리
	console.error("Error:", error);
}); */

async function getCarDirection() {
    const REST_API_KEY = '0b08c9c74b754bc22377c45ec5ce2736';
    // 호출방식의 URL을 입력합니다.
    const url = 'https://apis-navi.kakaomobility.com/v1/directions';

   // 출발지(origin), 목적지(destination)의 좌표를 문자열로 변환합니다.
  //  const origin = `${pointObj.startPoint.lng},${pointObj.startPoint.lat}`; 
  //  const destination = `${pointObj.endPoint.lng},${pointObj.endPoint.lat}`;
    
    // 요청 헤더를 추가합니다.
    const headers = {
      Authorization: 'KakaoAK ' + REST_API_KEY,
      'Content-Type': 'application/json'
    };
  
    // 표3의 요청 파라미터에 필수값을 적어줍니다.
//    const queryParams = new URLSearchParams({
 //     origin: origin,
//      destination: destination
//    });
    
//    const requestUrl = `${url}?${queryParams}`; // 파라미터까지 포함된 전체 URL

    try {
      const response = await fetch(url + '?origin=127.11015314141542,37.39472714688412&destination=127.10824367964793,37.401937080111644', {
        method: 'GET',
        headers: headers
      });

      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      const data = await response.json();
      console.log(data)
      
      const linePath = [];
      data.routes[0].sections[0].roads.forEach(router => {
        router.vertexes.forEach((vertex, index) => {
           // x,y 좌표가 우르르 들어옵니다. 그래서 인덱스가 짝수일 때만 linePath에 넣어봅시다.
           // 저도 실수한 것인데 lat이 y이고 lng이 x입니다.
          if (index % 2 === 0) {
            linePath.push(new kakao.maps.LatLng(router.vertexes[index + 1], router.vertexes[index]));
          }
        });
      });
      var polyline = new kakao.maps.Polyline({
        path: linePath,
        strokeWeight: 5,
        strokeColor: '#000000',
        strokeOpacity: 0.7,
        strokeStyle: 'solid'
      }); 
      polyline.setMap(map);
      
    } catch (error) {
      console.error('Error:', error);
    }
  }




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>