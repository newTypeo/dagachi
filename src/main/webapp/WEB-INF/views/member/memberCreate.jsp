<%--진짜 회원가입이 될 창 지우지 마세요 --%>
 <%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css"/>
<link href="toggle-radios.css" rel="stylesheet" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title" />
</jsp:include>
<style>
.modal { top: -920px; }
.modal-body { height: 400px; }
#club-create-form-wrapper { margin: 50px auto; width: 800px; }
.main-area-id-checked, .address-checked { padding: 5px; margin: 0; }
.main-area-id-checked:hover, .address-checked:hover { background-color: #ddd; cursor: pointer; }
#tagContainer { display: flex; background-color: lightskyblue; border-radius: 5px; }
.tagWrapper { height: 30px; margin: 5px; border: 2px solid white; position: relative; border-radius: 5px; display: flex; }
div#memberId-container { position: relative; padding: 0px; }
div#memberId-container span.guide { display: none; font-size: 12px; position: absolute; top: 12px; right: 10px; }
div#memberId-container span.ok { color: blue; }
div#memberId-container span.error { color: red; }
</style>

<div id="enroll-container" class="mx-auto text-center">
	 <form:form name="memberCreateFrm"
		  action="${pageContext.request.contextPath}/member/memberCreate.do"
		  method="POST"
		  enctype="multipart/form-data">
		<table class="mx-auto w-75">
			<tr>
				<th>아이디</th>
				<td>
	               <div id="memberId-container">
	                  <input type="text" 
	                        class="form-control" 
	                        placeholder="4글자이상"
	                        name="memberId" 
	                        id="memberId"
	                        value="nayoung11"
	                        pattern="\w{4,}"
	                        required>
	                  <span class="guide ok">이 아이디는 사용가능합니다.</span>
	                  <span class="guide error">이 아이디는 이미 사용중입니다.</span>
	                  <span class="memberIdAlert"></span>
	                  <input type="hidden" id="idValid" value="0"/>
	               </div>
				</td>
			</tr>
			<tr>
				<th>패스워드</th><!--실기간 유효성 검사  -->
				<td>
					<input type="password" class="form-control" name="password" id="password" value="1234" required>
					<span class="passwordAlert"></span>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th><!--실기간 유효성 검사 + 패스워드 일치 검사-->
				<td>	
					<input type="password" class="form-control" id="passwordConfirmation" value="1234" required>
				</td>
			</tr>  
			<tr>
				<th>이름</th><!--실기간 유효성 검사  -->
				<td>	
					<input type="text" class="form-control" name="name" id="name" value="김나영" required>
					<span class="nameAlert"></span>
				</td>
			</tr>
			<tr>
				<th>닉네임</th><!--실기간 유효성 검사  -->
				<td>	
					<input type="text" class="form-control" name="nickname" id="nickname" value="나영너굴" required>
					<span class="nicknameAlert"></span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th><!--실기간 유효성 검사 + 양식에 맞게 작성하게   -->
				<td>	
					<input type="text" class="form-control"  name="phoneNo" id="phoneNo" value="010-8119-1111">
					<span class="phoneNoAlert"></span>
				</td>
			</tr>	
			<tr>
				<th>생년월일</th><!--양식에 맞게  검  -->
				<td>	
					<input type="date" class="form-control" name="birthday" id="birthday" value="2004-09-09"/>
				</td>
			</tr> 
			<tr>
				<th>이메일</th><!--이메일은 이메일 인증이필요하기에 걍 두기  -->
				<td>	
					<input type="text" class="form-control"  name="email" id="email" value="nayoung11@naver.com">
					<span class="emailAlert"></span>
				</td>
			</tr>
			<tr>
			    <th>성별</th>
			    <td>
			        <input type="radio" name="gender" id="male" value="M" checked>
			        <label for="male">남</label>
			        
			        <input type="radio" name="gender" id="female" value="F">
			        <label for="female">여</label>
			    </td>
			</tr>			
	
			<tr>
				<th><label for="activity_area">거주지</label></th> <!-- 필수값 지도 API 사용 + 상세 주소값 받아야함  -->
					<td>	
						<div class="input-group">
							<input type="text" class="form-control" id="activity_area" name="activityArea" readonly aria-describedby="button-addon2" value="${club.activityArea}">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
								data-target="#activity-area-modal" id="activity-area-search-btn" >검색</button>
							</div>
						</div>
						<!-- <input type="text" class="form-control"  name="address" id="address" value="서울시 역삼동 구리230-1번지"> -->
					</td>
				</tr>
			<tr>	
				<th><label for="main_area_id">활동 지역</label></th>	
				<td>				
					<div class="input-group">
						<input type="text" class="form-control" id="main_area_id" name="mainAreaId" readonly aria-describedby="button-addon2">
						<div class="input-group-append">
							<button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
							data-target="#main-area-id-modal" id="activity-area-search-btn">검색</button>
						</div>
					</div>					
				</td>
			</tr>		
			<tr>
			    <th><label for="mbti">MBTI</label></th>
			    <td>

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
			    </td>
			</tr>	
			<tr>
			    <th><label for="interests1">관심사</label></th>
			    <td>
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
			    </td>
			</tr>
		</table>
		
		<div class="checkbox_group">

		  <input type="checkbox" id="check_all" >
		  <label for="check_all">전체 동의</label>
		  
		  <input type="checkbox" id="check_1" class="normal" >
		  <label for="check_1">개인정보 처리방침 동의</label>
		  
		  <input type="checkbox" id="check_2" class="normal" >
		  <label for="check_2">서비스 이용약관 동의</label>
		  
		  <input type="checkbox" id="check_3" class="normal" >
		  <label for="check_3">마케팅 수신 동의</label>
		  
		</div>
		<button type="submit" >가입</button>
	</form:form>
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
</div>
<script>

//체크박스 전체 선택
$(".checkbox_group").on("click", "#check_all", function () {
  var checked = $(this).is(":checked");

  if(checked){
  	$(this).parents(".checkbox_group").find('input').prop("checked", true);
  } else {
  	$(this).parents(".checkbox_group").find('input').prop("checked", false);
  }
});
//체크박스 개별 선택
$(".checkbox_group").on("click", ".normal", function() {
  var checked = $(this).is(":checked");

  if (!checked) {
  	$("#check_all").prop("checked", false);
  }
});

// 관심사 체크
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


// 멤버 아이디 실시간 유효성 검사 ( 뭔가 이상함 )
document.querySelector("#memberId").onkeyup = (e) => {
	const value = e.target.value;
	console.log(value);
	const guideOk = document.querySelector(".guide.ok");
	const guideError = document.querySelector(".guide.error");
	const idValid = document.querySelector("#idValid");
	if(value.length >= 4) {
		$.ajax({
			url : "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
			data : {
				memberId : value
			},
			method : "GET",
			dataType : "json",
			success(responseData) {
				console.log(responseData);
				const {available} = responseData;
				if(available) {
					guideOk.style.display = "inline";
					guideError.style.display = "none";
					idValid.value = "1";
				}
				else {
					guideOk.style.display = "none";
					guideError.style.display = "inline";
					idValid.value = "0";
				}
			}
		});
	}
	else {
		guideOk.style.display = "none";
		guideError.style.display = "none";
		idValid.value = "0";
	}
};
// 실시간 유효성
 document.memberCreateFrm.onsubmit = (e) => {
	const idValid = document.querySelector("#idValid");
	const password = document.querySelector("#password");
	const passwordConfirmation = document.querySelector("#passwordConfirmation");
	if(idValid === "0") {
		alert("사용가능한 아이디를 작성해주세요.");
		return false;
	}
	if(password.value !== passwordConfirmation.value) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
}; 
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
//-------------------------------------- 활동지역end--------------------------------
</script>

<script>
// 실시간 유효성 검사
const memberId = $("#memberId").val();
const pwd = $("#password").val();
const pwdCheck = $("#passwordConfirmation").val();
const name = $("#name").val();
const email = $("#email").val();
const phoneNo = $("#phoneNo").val();
const nickName = $("#nickname").val();


const memberIdReg = /^[a-z]+[a-z0-9]{5,19}$/; 
const pwdReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{5,14}$/;
const nameReg = /^[가-힣]{2,5}$/;
const emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; 
const phoneNoReg = /^(010|011|016|017|018|019)-\d{3,4}-\d{4}$/;
const nickNameReg = /^[a-zA-Z가-힣]{3,7}$/;


const $nameArlert = $("#nameArlert");
const $pwdArlert = $("#passwordAlertArlert");
const $emailAlert = $("#emailAlert");
const $phoneNoAlert = $("#phoneNoAlert");
const $nickNameAlert = $("#nicknameAlert");
const $nameAlert = $("#nameAlert");
			
</script>


 <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include> 
   
