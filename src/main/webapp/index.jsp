<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:if test="${not empty msg}">
	<script>
		alert('${msg}');
	</script>
</c:if>


<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/navBar.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/chatBtn.jsp"></jsp:include>

<section id="main-page-sec" class="">
<div id="banner-and-info-container">
	<nav id="main-banner" class="">
		<div id="carouselExampleControls" class="carousel slide"
			data-ride="carousel">
			<div class="carousel-inner">
				
			</div>
			<button class="carousel-control-prev" type="button"
				data-target="#carouselExampleControls" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-target="#carouselExampleControls" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</button>
		</div>
	</nav>
	<nav id="my-club-info">
	<sec:authorize access="isAnonymous()"><img style="margin-top:0px; hight:600px" class="img-place" alt="" src="${pageContext.request.contextPath}/resources/images/main2.png"></sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<div class="myInfo">
				<div class="myProfile">
					<img class="img-place" alt="" src="${pageContext.request.contextPath}/resources/upload/member/profile/<sec:authentication property="principal.memberProfile.renamedFilename"/>">
				</div>
				<div class="my-info-place">
					<span class="my-info-nickname"><sec:authentication property="principal.nickname"/></span><br>
					<span class="mainArea"></span>
					<script>
					$.ajax({
						url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=" + <sec:authentication property="principal.activityArea.mainAreaId"/>,
						success({regcodes}) {
							const strArr = regcodes[0].name.split(' ');
							const area = strArr.slice(1).join(' ');
							
							document.querySelector(".mainArea").innerHTML = "활동지역 : " + area; 
						}
					}); 
					</script>
					<sec:authentication property="principal.memberInterest" var="interestList"/>

					<ul>
					    <c:forEach items="${interestList}" var="interest">
					        <li>${interest.interest}</li>
					    </c:forEach>
					</ul>
				</div>
			</div>
			<div class="myClubList">
				<h5 class="myClubList-header-text-style">👌 나의 소모임</h5>
				<ul style="list-style: none;">
				</ul>
				<script>
					
					$.ajax({
						url : "${pageContext.request.contextPath}/club/getClubName.do",
						success(clubs) {
							const clubListUl = document.querySelector(".myClubList ul");
							clubs.forEach((club) => {
								clubListUl.innerHTML += `
									<li>▸ <a class='my-club-a' href='${pageContext.request.contextPath}/club/\${club.domain}'>\${club.clubName}</a></li>
								`;					
							});
						}
					});
				</script>
			</div>
		</sec:authorize>
	</nav>
</div>

<nav>
	

</nav>

	<sec:authorize access="isAnonymous()">
		<section id="class">
	  		<div class="posts"></div>
		</section>
		
<script>
// card의 div태그 a태그로 교체함 - 동찬
// 로그인 안했을때 카드출력
$.ajax({
    url: "${pageContext.request.contextPath}/club/clubList.do",
    success: function(clubs) {
        const container = document.querySelector(".posts");

        clubs.forEach((clubAndImage) => {
            const { clubName, category, status, reportCount, introduce, domain, renamedFilename, memberCount } = clubAndImage;
            if (status !== false) {

                const card = document.createElement("a");
                card.classList.add("card");
                card.style.width = "18rem";
                card.addEventListener("click", function(event) {
                    event.preventDefault(); // Prevent the default link behavior
                    alert("로그인 후 이용 가능합니다."); // Display the alert message
                });

                card.innerHTML = `
                    <img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${renamedFilename}" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">\${clubName}</h5>
                        <p class="card-text">\${introduce}</p>
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">\${category}</li>
                        <li class="list-group-item">인원수 : \${memberCount}</li>
                    </ul>
                `;

                container.appendChild(card);
            }
        });
    }
});
</script>		
		
	</sec:authorize>
	
	<sec:authorize access="isAuthenticated()">
		<section id="class2">
	   		<br>
			<strong class="title-headLine">추천 모임</strong>
	   		<div class="posts2"></div>
	   		<br>
	   		<strong class="title-headLine">모든 모임</strong>
	   		<div class="posts3"></div>
		</section>

<script>

$.ajax({
    url: "${pageContext.request.contextPath}/club/loginClubList.do",
    success: function(clubs) {
        const container = document.querySelector(".posts2");

        if (clubs.length === 0) {
            container.innerHTML = "<p>추천목록이 없습니다.</p>";
        } else {
            clubs.forEach((clubAndImage) => {
                const { clubName, category, status, reportCount, introduce, domain, renamedFilename, memberCount } = clubAndImage;
                if (status !== false) {
                    container.innerHTML += `
                        <a class="card" style="width: 18rem;" href="${pageContext.request.contextPath}/club/\${domain}">
                            <img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${renamedFilename}" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">\${clubName}</h5>
                                <p class="card-text">\${introduce}</p>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">\${category}</li>
                                <li class="list-group-item">인원수 : \${memberCount}</li>
                            </ul>
                        </a>
                    `;
                }
            });
        }
    }
});

$.ajax({
	url : "${pageContext.request.contextPath}/club/clubList.do",
	success(clubs){
		const container = document.querySelector(".posts3");
		
		clubs.forEach((clubAndImage)=>{
			const { clubName, category, status, reportCount, introduce, domain, renamedFilename, memberCount} = clubAndImage;
			if (status !== false) {
				
				container.innerHTML += `
					<a class="card" style="width: 18rem;" href="${pageContext.request.contextPath}/club/\${domain}">
					  <img src="${pageContext.request.contextPath}/resources/upload/club/profile/\${renamedFilename}" class="card-img-top" alt="...">
					  <div class="card-body">
					    <h5 class="card-title">\${clubName}</h5>
					    <p class="card-text">\${introduce}</p>
					  </div>
					  <ul class="list-group list-group-flush">
					    <li class="list-group-item">\${category}</li>
					    <li class="list-group-item">인원수 : \${memberCount}</li>
					  </ul>
					</a>
				`;
			}
		});
	}
});
</script>
		
	</sec:authorize>
</section>

<script>
const carouselInner = document.querySelector(".carousel-inner");

$.ajax({
	url : "${pageContext.request.contextPath}/admin/mainBannerList.do",
	success(banners) {
		carouselInner.innerHTML = '';
		banners.forEach((banner) => {
			const { renamedFilename } = banner;
			carouselInner.innerHTML += `
				<div class="carousel-item">
					<img src="${pageContext.request.contextPath}/resources/upload/main/\${renamedFilename}" class="d-block w-100">
				</div>
			`;
			const carouselItem = document.querySelector(".carousel-item");
			carouselItem.classList.add("active");
		});
		
	}
	
});

</script>

<script>


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>