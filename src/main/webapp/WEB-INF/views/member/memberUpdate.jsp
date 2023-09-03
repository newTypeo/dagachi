<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>



<style>
section {
	
	display: flex;
	justify-content: center;
	align-items: center;
	height: 120vh;
	margin: 0 auto;
	font-family: Arial, sans-serif;
}

/* 카드 스타일 설정 */
/* 헤더와 푸터 사이에 간격을 추가합니다 */
.container11 {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
	padding: 40px;
	width: 570px;
	margin-top: 20px;
	margin-bottom: 20px;
}

/* 프로필 이미지 스타일 설정 */
.figure11 {
	text-align: center;
	margin-bottom: 20px;
}

.figure11 img {
	border-radius: 50%;
	width: 120px;
	height: 120px;
	object-fit: cover;
	border: 1px solid lightgray;
}

/* 입력 필드 스타일 설정 */
.form-control11 {
	margin-bottom: 8px;
	border: none;
	border-top: 1px solid #bbb;
	padding: 7px;
	width: 100%;
}

/* 파일 선택 필드 스타일 설정 */
.custom-file-label11::after {
	content: "파일 선택";
}

/* 버튼 스타일 설정 */
.btn-primary11, .btn-secondary11 {
	background-color: #3498db;
	border: none;
	color: #fff;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	margin-right: 10px;
	transition: background-color 0.3s;
}

.btn-secondary11 {
	background-color: #95a5a6;
}

/* 버튼 호버 효과 설정 */
.btn-primary11:hover, .btn-secondary11:hover {
	background-color: #2980b9;
}

.btn-container11 {
	text-align: center;
}

/* 파일 이미지 */
.custom-file11 {
	position: relative;
	display: inline-block;
	width: 100px; /* 원하는 너비로 조정 */
	height: 40px; /* 원하는 높이로 조정 */
	overflow: hidden;
	border-radius: 5px;
	background-color: #f0f0f0;
	cursor: pointer;
}

.custom-file-input11 {
	position: absolute;
	left: -9999px;
}

.custom-file-label11 {
	display: block;
	padding: 5px;
	text-align: center;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	background-color: #e9e9e9;
	border-radius: 5px;
	cursor: pointer;
}

</style>
<br><br><br>
<section>
	<form:form id="command" name="memberUpdateFrm"
		action="${pageContext.request.contextPath}/member/memberUpdate.do" method="POST"
		enctype="multipart/form-data">
		<div class="container11">
			<figure class="figure11">
				<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${profile.renamedFilename}"
					class="figure-img img-fluid rounded" alt="...">
			</figure>
			<div class="custom-file11">
				<input type="file" name="upFile" class="custom-file-input11"
					id="inputGroupFile01" aria-describedby="inputGroupFileAddon01"
					multiple> <label class="custom-file-label11"
					for="inputGroupFile01">${profile.renamedFilename}</label>
			</div>
			<div>
				<div style="margin-top: 20px;">
					<label for="memberId">아이디</label>
					<input type="text" class="form-control11" id="memberId"
						name="memberId" placeholder="honggd" value="${loginMember.memberId}" readonly>
				</div>

				<div>
					<label for="name">이름</label>
					<input type="text" class="form-control11" id="name" name="name"
						value="${loginMember.name}" required>
				</div>

				<div>
					<label for="nickname">닉네임</label>
					<input type="text" class="form-control11" id="nickname"
						name="nickname" value="${loginMember.nickname}" required>
				</div>
			</div>

			<div>
				<label for="phoneNo">전화번호</label>
				<input type="text" class="form-control11" id="phoneNo" name="phoneNo"
					value="${loginMember.phoneNo}" required>
			</div>

			


			<fieldset class = "type">
		<div>관심 정보</div>
			<div class="fadeIn first"> 
			    <label for="mbti">MBTI</label>
				        <div class="toggle-radio" data-style="rounded"> 
								<label><input type="radio" name="mbti" value="ISTJ" class="custom-radio" checked> ISTJ</label>
								<label><input type="radio" name="mbti" value="ISFJ" class="custom-radio"> ISFJ</label>
								<label><input type="radio" name="mbti" value="INFJ" class="custom-radio"> INFJ</label>
								<label><input type="radio" name="mbti" value="INTJ" class="custom-radio"> INTJ</label>
								<label><input type="radio" name="mbti" value="ISTP" class="custom-radio"> ISTP</label>
								<label><input type="radio" name="mbti" value="ISFP" class="custom-radio"> ISFP</label>
								<label><input type="radio" name="mbti" value="INFP" class="custom-radio"> INFP</label>
								<label><input type="radio" name="mbti" value="INTP" class="custom-radio"> INTP</label>
								<label><input type="radio" name="mbti" value="ESTP" class="custom-radio"> ESTP</label>
								<label><input type="radio" name="mbti" value="ESFP" class="custom-radio"> ESFP</label>
								<label><input type="radio" name="mbti" value="ENFP" class="custom-radio"> ENFP</label>
								<label><input type="radio" name="mbti" value="ENTP" class="custom-radio"> ENTP</label>
								<label><input type="radio" name="mbti" value="ESTJ" class="custom-radio"> ESTJ</label>
								<label><input type="radio" name="mbti" value="ESFJ" class="custom-radio"> ESFJ</label>
								<label><input type="radio" name="mbti" value="ENFJ" class="custom-radio"> ENFJ</label>
								<label><input type="radio" name="mbti" value="ENTJ" class="custom-radio"> ENTJ</label>
				        </div>
 					</div>
				<div class="fadeIn first"> 
			    <label for="interests1">관심사</label>
				        <div class="form-group">
				            <label><input type="checkbox" name="interests" value="차/오토바이" checked> 차/오토바이</label>
				            <label><input type="checkbox" name="interests" value="게임/오락"> 게임/오락</label>
				            <label><input type="checkbox" name="interests" value="여행"> 여행</label>
				            <label><input type="checkbox" name="interests" value="운동/스포츠"> 운동/스포츠</label>
				            <label><input type="checkbox" name="interests" value="인문학/독서"> 인문학/독서</label>
				            <label><input type="checkbox" name="interests" value="업종/직무"> 업종/직무</label>
				            <label><input type="checkbox" name="interests" value="언어/회화"> 언어/회화</label>
				            <label><input type="checkbox" name="interests" value="공연/축제"> 공연/축제</label>
				            <label><input type="checkbox" name="interests" value="음악/악기"> 음악/악기</label>
				            <label><input type="checkbox" name="interests" value="공예/만들기"> 공예/만들기</label>
				            <label><input type="checkbox" name="interests" value="댄스/무용"> 댄스/무용</label>
				            <label><input type="checkbox" name="interests" value="봉사활동"> 봉사활동</label>
				            <label><input type="checkbox" name="interests" value="사교/인맥"> 사교/인맥</label>
				            <label><input type="checkbox" name="interests" value="사진/영상"> 사진/영상</label>
				            <label><input type="checkbox" name="interests" value="야구관람"> 야구관람</label>
				            <label><input type="checkbox" name="interests" value="요리/제조"> 요리/제조</label>
				            <label><input type="checkbox" name="interests" value="애완동물"> 애완동물</label>
				            <label><input type="checkbox" name="interests" value="자유주제"> 자유주제</label>
				            <div><p id="interestError" style="color: red;"></p></div>
				        </div>		
			         </div>
		</fieldset>
<!-- 활동지역 받는 모달창 -->
 	<div class="modal modal-dialog modal-dialog-scrollable fade"
			id="main-area-id-modal" data-backdrop="static" data-keyboard="false"
			tabindex="-1" aria-labelledby="staticBackdropLabel" style="display: none;"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">주소검색</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<label for="main-area-id-search-box">주 활동지 : </label> 
						<input id="main-area-id-search-box" name="address" readonly/><br>
						<label for="gu-filter">서울특별시 </label>
						<select id="gu-filter"></select>
						<div class="main-area-id-box">
							<p>먼저 지역구를 선택해주십시오.</p>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
						<button id="main-area-id-confirm-btn" type="button"
							class="btn btn-primary">확인</button>
					</div>
				</div>
			</div>
		</div><!-- 활동지역 받는 모달창 end -->
		<!-- 집주소 받는 모달창 -->
		<div class="modal modal-dialog modal-dialog-scrollable fade"
			id="activity-area-modal" data-backdrop="static" data-keyboard="false"
			tabindex="-1" aria-labelledby="staticBackdropLabel" style="display: none;"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">주소 검색:</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<label for="address-search-box">도로명 주소 : </label> <input
							id="address-search-box" name="address"
							placeholder="ex) 강남구 역삼동 or 역삼동" />
						<div class="address-box"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
						<button id="address-confirm-btn" type="button"
							class="btn btn-primary">확인</button>
					</div>
				</div>
			</div>
		</div><!-- 집주소 받는 모달창 end -->
			
			<fieldset class = "area_interest">
		
		
		 <legend class="sub_title">관심 정보</legend>
		 
				 <div class="fadeIn first">
					<label for="activity_area">거주지</label> <!-- 필수값 지도 API 사용 + 상세 주소값 받아야함  -->
						
						<div class="input-group">
								<input type="text" class="form-control" id="activity_area" name="activityArea" readonly aria-describedby="button-addon2" placeholder="본인의 집 주소를 입력해주세요"">
								<div class="input-group-append">
									<button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
									data-target="#activity-area-modal" id="activity-area-search-btn" >검색</button>
								</div>
						</div>
					</div>
						<!-- <input type="text" class="form-control"  name="address" id="address" value="서울시 역삼동 구리230-1번지"> -->
				
				<div class="fadeIn first">
					<label for="main_area_id">활동 지역</label>
						<div class="input-group">
							<input type="text" class="form-control" id="main_area_id" name="mainAreaId" placeholder="주로 활동할 지역을 입력해주세요" readonly aria-describedby="button-addon2">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
								data-target="#main-area-id-modal" id="activity-area-search-btn">검색</button>
							</div>
						</div>	
					</div>		
		</fieldset>
			
			<div>
				<label for="birthday">생일</label>
				<input type="date" class="form-control11" name="birthday"
					id="birthday" value="${loginMember.birthday }" />
			</div>

			<div>
				<label for="gender">성별</label> <select class="custom-select"
					id="gender" name="gender">
					<option value="M" ${loginMember.gender eq 'M' ? 'selected' : '' }>M</option>
                	<option value="F" ${loginMember.gender eq 'F' ? 'selected' : '' }>F</option>
				</select>
			</div>

			<hr>

			<div class="btn-container11">
				<button type="submit" class="btn-primary11">수정</button>
				<button type="button" class="btn-secondary11">취소</button>
			</div>
		</div>
	</form:form>
</section>
<br><br><br>
<script>
  document.querySelector("#inputGroupFile01").addEventListener("change",(e) => {
		
		const label = e.target.nextElementSibling;
		const files = e.target.files;
		if(files[0]) {
			label.innerHTML = files[0].name;
		}
		else {
			label.innerHTML = "파일을 선택하세요";
		}
	
});
  
//관심사 체크
  const minInterestCount = 1;
  const maxInterestCount = 3;
  const interestCheckboxes = document.querySelectorAll('input[type="checkbox"][name="interests"]');
  const interestError = document.getElementById('interestError');
  interestCheckboxes.forEach((checkbox) => {
      checkbox.addEventListener('change', () => {
          const selectedInterestCount = document.querySelectorAll('input[type="checkbox"][name="interests"]:checked').length;
          if (selectedInterestCount < minInterestCount) {
              interestError.textContent = '최소 하나 이상의 관심사를 선택하세요.';
          } else if (selectedInterestCount > maxInterestCount) {
              interestError.textContent = '최대 세 개의 관심사까지 선택할 수 있습니다.';
          } else {
              interestError.textContent = '';
          }
      });
  });

//-------------------------------------- 집 주소 시작 --------------------------------
  const addressSearchBox = document.querySelector("#address-search-box");
  const addressBox = document.querySelector(".address-box");	
  //주소검색에 키 입력 리스너를 추가
  addressSearchBox.onkeyup = (e) => {
  	$.ajax({
  		url : '${pageContext.request.contextPath}/club/findAddress.do',
  		data : { keyword : e.target.value },
  		method : "GET",
  		success(addressList) {
  			// 비어있는 경우 출력
  			if (addressList == '') {
  				addressBox.innerHTML = '<p>검색 결과가 존재하지 않습니다.</p>';
  				return;
  			}
  			// 초기화
  			addressBox.innerHTML = "";
  			// 주소 추가
  			addressList.forEach((address) => {
  				addressBox.innerHTML += `
  					<p class='address-checked'>\${address}</p>
  				`;
  			});
  		}
  	});
  }
  // 문서 클릭 이벤트
  document.addEventListener('click', (e) => {
   const clickedElement = e.target;
   // 클릭된 요소가 'address-checked' 클래스를 가진 경우 주소 검색 상자에 값을 설정
   if (clickedElement.matches(".address-checked")) {
       addressSearchBox.value = e.target.innerHTML;
   }
   // 클릭된 요소가 'address-confirm-btn' 아이디를 가진 경우 활동 영역 값을 설정하고 모달을 닫습니다.
   if (clickedElement.matches("#address-confirm-btn")) {
   	document.querySelector("#activity_area").value = addressSearchBox.value;
   	$('#activity-area-modal').modal('hide');
   }
  });
  //-------------------------------------- 집 주소 끝 --------------------------------

  //-------------------------------------- 주 활동지역start--------------------------------
  const mainAreaIdSearchBox = document.querySelector("#main-area-id-search-box");
  const mainAreaIdBox = document.querySelector(".main-area-id-box");	
  //활동지역 option 
  $.ajax({
  	// 요청 url 은 서버에서 서울시 지역을 가져옴
  	url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=11*00000",
  	data : {is_ignore_zero : true},
  	success({regcodes}) {
  		const selectArea = document.querySelector("#gu-filter");
  		selectArea.innerHTML = '<option value="" disabled selected>-선택-</option>';
  		$.each(regcodes, (index) => {
  			const fullAddr = regcodes[index]["name"];
  			const region = fullAddr.split(" ");
  			//'구'를 선택할수있는 HTML의 만들고 select 로 요소 선택
  			selectArea.innerHTML += `<option value="\${region[1]}">\${region[1]}</option>`;
  		});
  	},
  	complete() {
  		console.log("ASd");
  	}
  });
  // 구 선택 값이 변경될때마다 이벤트 핸들러
  document.querySelector("#gu-filter").onchange = (e) => {
  	const zone = e.target.value; 
  	if(zone == "") {
  		detail.style.display = 'none';
  		detail.value = '';
  		return;
  	}
  	// 아래는 선택한 구에 따라 동을 가져오고 화면에 뿌려줌
  	$.ajax({ // 1. 서울시의 모든 구를 요청
  		url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=11*00000",
  		data : {is_ignore_zero : true},
  		success({regcodes}) {
  			$.each(regcodes, (index) => { // 2. 서울시 모든 구 중에서 사용자가 선택한 구의 정보를 찾기위한 반복문
  				const fullAddr = regcodes[index]["name"];
  				const region = fullAddr.split(" ");
  				if(region[1] == zone) { 
  					const first5 = regcodes[index]["code"].toString().substr(0,5); // 3. 사용자가 선택한 구의 모든 동을 조회하기위한 코드 
  					$.ajax({ // 4. 위에서 구한 코드로 모든 동정보 요청
  						url : "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=" + first5 + "*",
  						data : {is_ignore_zero : true},
  						success({regcodes}) {
  							mainAreaIdBox.innerHTML = ""
  							$.each(regcodes, (index) => { // 5. 파싱작업을 통해 모든동을 option태그로 만들어서 추가하는 반복문
  								const fullAddr = regcodes[index]["name"];
  								mainAreaIdBox.innerHTML += `<p class='main-area-id-checked'>\${fullAddr}</p>`;
  							}); // $.each
  						} // success
  					}) // ajax
  				} // if
  			}); // $.each
  		} // success
  	}); // ajax
  };
  //클릭 이벤트 리스너 
  document.addEventListener('click', (e) => {
      const clickedElement = e.target;
      if (clickedElement.matches(".main-area-id-checked")) {
      	mainAreaIdSearchBox.value = e.target.innerHTML;
      }
      // 사용자가 확인 버튼 클릭시 활동지역을 activity_area 요소에 설정하고 모달 창을 닫음
      if (clickedElement.matches("#main-area-id-confirm-btn")) {
      	document.querySelector("#main_area_id").value = mainAreaIdSearchBox.value;
      	$('#activity-area-modal').modal('hide');
      }
  });
  
  
  </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>



