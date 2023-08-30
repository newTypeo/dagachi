<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nav.css" />


<!-- 클릭하면 카테고리 관련 창을 닫는 div -->
<div id="dark" style="position:absolute; width: 100%; height: 100vh; display:none; z-index:1"></div>

<nav id="main-nav-bar">
	<div id="category-container" style="z-index: 2">
		<i class="fa-solid fa-bars fa-xl" style="color: #666;"></i>
		<span>카테고리</span>
	</div>
	
	<div id="nav-blank"></div>
	
	<div id="search-container">
		<form id="clubSearchFrm" action="${pageContext.request.contextPath}/club/clubSearch.do">
			<input type="text" name="inputText" id="search-club-box" placeholder="BTS 봉준호 손흥민 다가치 Let's go"/>
			<button id="search-club-btn"><i class="fa-solid fa-magnifying-glass fa-xl"></i></button>
		</form>
		<div id="search-detail" onclick="checkLoginSearch();">
			<i class="fa-regular fa-map fa-lg" style="color: #ffffff;"></i>
		</div>
	</div>
	
	
	<button type="button" id="club-create-btn" class="btn">
		+ 소모임 생성
	</button>
	
	<div id="category-modal-container" style="z-index: 2">
		<div id="category-modal-left" style="z-index: 2">
			<div id="category-modal-left-upper" style="z-index: 2">
				<div><a>차/오토바이</a></div>
				<div><a>게임/오락</a></div>
				<div><a>여행</a></div>
				<div><a>운동/스포츠</a></div>
				<div><a>인문학/독서</a></div>
				<div><a>업종/직무</a></div>
				<div><a>언어/회화</a></div>
				<div><a>공연/축제</a></div>
				<div><a>음악/악기</a></div>
				<div><a>공예/만들기</a></div>
				<div><a>댄스/무용</a></div>
				<div><a>봉사활동</a></div>
				<div><a>사교/인맥</a></div>
				<div><a>사진/영상</a></div>
				<div><a>야구관람</a></div>
				<div><a>요리/제조</a></div>
				<div><a>애완동물</a></div>
				<div><a>자유주제</a></div>
			</div>
			<div id="category-modal-left-lower">
				<a>모든 주제 보기 ></a>
			</div>
		</div>
		<div id="category-modal-right" style="display:none;">
			<div id="row" class="row" style="padding:5px;">
			
			</div>
		</div>
	</div>
</nav>


<sec:authorize access="isAnonymous()">
	<script>
		document.querySelectorAll('#ccc').forEach((one) => {
			one.addEventListener('click', function(e) {
				e.preventDefault();
				alert('땡!');
				return false;
			});
		});
	</script>
</sec:authorize>



<script>
const checkLoginSearch = () => {
	// 비로그인시 처리코드
	<sec:authorize access="isAnonymous()">
		alert("로그인 후 이용해주세요.");
	</sec:authorize>
	
	// 로그인시 처리코드
	<sec:authorize access="isAuthenticated()">
		window.location = `${pageContext.request.contextPath}/club/clubSearchSurrounded.do`;
	</sec:authorize>
};


// 모임 생성 버튼
document.querySelector("#club-create-btn").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/clubCreate.do';
};

	  
let selected;
const categoryContainer = document.querySelector("#category-container");
const categoryModalContainer = document.querySelector("#category-modal-container");
const categoryModalLeft = document.querySelector("#category-modal-left");
const categoryModalRight = document.querySelector("#category-modal-right");
const categoryDiv = document.querySelectorAll("#category-modal-left-upper div");
const row = document.querySelector("#row");

const dark = document.querySelector("#dark");


categoryContainer.addEventListener('click', () => {
	categoryModalLeft.style.display = "block";
	dark.style.display = "block";
});
categoryModalContainer.addEventListener('mouseover', () => {
	categoryModalLeft.style.display = "block";
	dark.style.display = "block";
});
/*
categoryContainer.addEventListener('mouseout', () => {
	categoryModalLeft.style.display = "none";
	//categoryModalRight.style.display = "none";
});*/
/*
categoryModalContainer.addEventListener('mouseout', () => {
	categoryModalLeft.style.display = "none";
	categoryModalRight.style.display = "none";
});*/
/*categoryModalRight.addEventListener('mouseout', () => {
	categoryModalRight.style.display = "none";
});*/
dark.addEventListener('click', () => {
	categoryModalLeft.style.display = 'none';
	categoryModalRight.style.display = 'none';
	dark.style.display = 'none';
});

categoryDiv.forEach((element) => {
	element.addEventListener("click", function(e) {
		categoryModalRight.style.display = "block";
		
		const value = e.target.innerText;
		selected = value;
		
		//categoryModalRight.innerHTML = '';
		row.innerHTML = '';
		
		$.ajax({
			url: "${pageContext.request.contextPath}/club/categoryList.do",
			data: {
				category : value 
			},
			success(response) {
				response.forEach((club) => {
					row.innerHTML += `
						<div class="col col-lg-6" style="padding-right: 0px;">
							<a class="card" id="ccc" style="width: 9.5rem; text-align:center;" href="${pageContext.request.contextPath}/club/\${club.domain}">
								<img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${club.renamedFilename}" class="card-img-top" style="height: 9rem;" alt="..." />
								    <span class="card-title" style="height: 3rem;">\${club.clubName}</span>
							</a>
						</div>
					`;
				});
				row.innerHTML += `<br/>
				&nbsp;&nbsp;&nbsp; <a href="${pageContext.request.contextPath}/club/clubSearch.do?inputText=\${selected}">더보기</a>
				`;
			}
		});
		
	});

});

/*
window.onload = () => {
	location.href = "${pageContext.request.contextPath}/club/checkLogin.do"
};
*/

</script>