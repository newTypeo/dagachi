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
			<input type="text" name="inputText" id="search-club-box" placeholder="BTS 봉준호 다가치 Let's go" required/>
			<button id="search-club-btn"><i class="fa-solid fa-magnifying-glass fa-xl"></i></button>
		</form>
		<div id="search-detail"><a href="${pageContext.request.contextPath}/club/clubSearchSurrounded.do">주변보기<i class="fa-solid " style="color: #eee;"></i></a></div>
	</div>
	
	
	<button type="button" id="club-create-btn" class="btn">
		+ 소모임 생성
	</button>
	
	<div id="category-modal-container">
		<div id="category-modal-left">
			<div id="category-modal-left-upper">
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
const categoryDiv = document.querySelectorAll("#category-modal-left-upper div");

categoryContainer.addEventListener('mouseover', () => {
	categoryModalLeft.style.display = "block";
});
categoryModalContainer.addEventListener('mouseover', () => {
	categoryModalLeft.style.display = "block";
});

categoryContainer.addEventListener('mouseout', () => {
	categoryModalLeft.style.display = "none";
	categoryModalRight.style.display = "none";
});
categoryModalContainer.addEventListener('mouseout', () => {
	categoryModalLeft.style.display = "none";
	categoryModalRight.style.display = "none";
});
/* categoryModalRight.addEventListener('mouseout', () => {
	categoryModalRight.style.display = "none";
}); */

categoryDiv.forEach((element) => {
	element.addEventListener("mouseover", function(e) {
		categoryModalRight.style.display = "block";
		
		const value = e.target.innerText;
		console.log(value);
		
		categoryModalRight.innerHTML = '';
		
		$.ajax({
			url: "${pageContext.request.contextPath}/club/categoryList.do",
			data: {
				category : value 
			},
			success(response) {
				console.log(response);
				response.forEach((club) => {
					categoryModalRight.innerHTML += `
						<a class="card" style="width: 18rem;" href="${pageContext.request.contextPath}/club/\${club.domain}">
							<img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${club.renamedFilename}" class="card-img-top" alt="..." />
							  <div class="card-body">
							    <h5 class="card-title">\${club.clubName}</h5>
							    <p class="card-text">\${club.introduce}</p>
							  </div>
							  <ul class="list-group list-group-flush">
							    <li class="list-group-item">\${club.category}</li>
							    <li class="list-group-item">인원수 : \${club.memberCount}</li>
							  </ul>
						</a>
					`;
				});
			}
		});
		
	});

});



</script>