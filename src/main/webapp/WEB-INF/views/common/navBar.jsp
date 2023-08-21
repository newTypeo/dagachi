<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nav.css" />

<nav id="main-nav-bar">
	<div id="category-container">
		<i class="fa-solid fa-bars fa-xl" style="color: #666;"></i>
		<span>카테고리</span>
	</div>
	
	<div id="nav-blank"></div>
	
	<div id="search-container">
		<form id="clubSearchFrm" action="${pageContext.request.contextPath}/club/clubSearch.do">
			<input type="text" name="inputText" id="search-club-box" placeholder="검색할 모임 입력"/>
			<button id="search-club-btn"><i class="fa-solid fa-magnifying-glass fa-xl"></i></button>
		</form>
		<div id="search-detail">상세검색<i class="fa-solid fa-chevron-down" style="color: #eee;"></i></div>
	</div>
	
	
	<button type="button" id="club-create-btn" class="btn">
		+ 소모임 생성
	</button>
	
	<div id="category-modal-container">
		<div id="category-modal-left">
			<div id="category-modal-left-upper">
				<a>차/오토바이</a><br>
				<a>게임/오락</a><br>
				<a>여행</a><br>
				<a>운동/스포츠</a><br>
				<a>인문학/독서</a><br>
				<a>업종/직무</a><br>
				<a>언어/회화</a><br>
				<a>공연/축제</a><br>
				<a>음악/악기</a><br>
				<a>공예/만들기</a><br>
				<a>댄스/무용</a><br>
				<a>봉사활동</a><br>
				<a>사교/인맥</a><br>
				<a>사진/영상</a><br>
				<a>야구관람</a><br>
				<a>요리/제조</a><br>
				<a>애완동물</a><br>
				<a>자유주제</a><br>
			</div>
			<div id="category-modal-left-lower">
				<a>모든 주제 보기 ></a>
			</div>
		</div>
		<div id="category-modal-right">
			
		</div>
	</div>
</nav>





<script>
// 모임 생성 버튼
document.querySelector("#club-create-btn").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/clubCreate.do';
};

const categoryContainer = document.querySelector("#category-container");
const categoryModalContainer = document.querySelector("#category-modal-container");
const categoryModalLeft = document.querySelector("#category-modal-left");
const categoryModalRight = document.querySelector("#category-modal-right");
const categoryA = document.querySelectorAll("#category-modal-left-upper a");

categoryContainer.addEventListener('mouseover', () => {
	categoryModalLeft.style.display = "block";
});
categoryModalContainer.addEventListener('mouseover', () => {
	categoryModalLeft.style.display = "block";
});
categoryModalRight.addEventListener('mouseover', () => {
	categoryModalRight.style.display = "block";
	categoryModalLeft.addEventListener('mouseover', () => {
		categoryModalRight.style.display = "block";
	});
});


categoryContainer.addEventListener('mouseout', () => {
	categoryModalLeft.style.display = "none";
	categoryModalRight.style.display = "none";
});
categoryModalContainer.addEventListener('mouseout', () => {
	categoryModalLeft.style.display = "none";
	categoryModalRight.style.display = "none";
});

categoryA.forEach((element) => {
	element.addEventListener("mouseenter", function() {
		categoryModalRight.style.display = "block";
	});

	element.addEventListener("mouseleave", function() {
		categoryModalRight.style.display = "block";
	});
});






</script>