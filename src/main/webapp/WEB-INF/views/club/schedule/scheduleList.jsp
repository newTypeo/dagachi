<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>

<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>

<style>
#calendar {
	margin: 30px 10px;
}
.fc-toolbar-title {
	transform: translateX(20px);
}
.fc-toolbar-chunk:nth-of-type(3) {
	transform: translateX(-106px);
}
#scheduleCreateBtn {
	background-color: #2990D0;
	position: absolute;
	font-weight: bold;
	color: white;
	transform: translate(1132px, 31px);
    height: 39px;
    display: none;
}

</style>

<c:if test="${not empty msg}">
	<script>
		alert('${msg}');
	</script>
</c:if>

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
		<button id="scheduleCreateBtn" class="btn">+ 일정생성</button>
		<div id="calendar"></div>
	</div>
</section>

<!-- <div id="scheduleSummaryBox"></div> -->

<script>

document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";

//--------------

document.documentElement.style.setProperty('--fc-border-color', '${layout.pointColor}');

const scheduleSummaryBox = document.querySelector("#scheduleSummaryBox");

$.ajax({
	url: '${pageContext.request.contextPath}/club/${domain}/getSchedules.do',
	success(schedules) {
		
		var eventLists = [];
		schedules.forEach((schedule) => {
			var {scheduleId, title, startDate, endDate} = schedule;
			var event = {
				title : title,
				url : '${pageContext.request.contextPath}/club/${domain}/scheduleDetail.do?no=' + scheduleId,
				start : startDate,
				end : endDate
			};
			eventLists.push(event);
		});
		
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar: {
			    left: 'dayGridMonth,listWeek',
		 	    center: 'title',
		    	right: 'prev,next today'
		    },
			initialView: 'dayGridMonth',
			height: '800px',
			locale: 'ko',
			events : eventLists,
			defaultAllDay : true,
		});
		calendar.render();
		document.querySelector("#scheduleCreateBtn").style.display = "block";
	}
});

scheduleCreateBtn.addEventListener('click', () => {
	location.href = "${pageContext.request.contextPath}/club/${domain}/scheduleCreate.do";
});

/* 마우스위치에 인포 띄우기 
document.querySelectorAll(".fc-event-title-container").forEach((e) => {
	e.addEventListener('mouseenter', (event) => {
		var scrollX = window.scrollX || window.pageXOffset; // 가로 스크롤 위치
		var scrollY = window.scrollY || window.pageYOffset; // 세로 스크롤 위치
		
		var newX = event.clientX + scrollX; // 마우스 클릭 위치 X 좌표 + 가로 스크롤 위치
		var newY = event.clientY + scrollY; // 마우스 클릭 위치 Y 좌표 + 세로 스크롤 위치
		
		// 이동할 div의 위치를 변경합니다.
		scheduleSummaryBox.style.left = newX + "px";
		scheduleSummaryBox.style.top = newY + "px";
		scheduleSummaryBox.style.display = "block";
	});
	e.addEventListener('mouseleave', (event) => {
		scheduleSummaryBox.style.display = "none";
	}); 
})
*/

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>