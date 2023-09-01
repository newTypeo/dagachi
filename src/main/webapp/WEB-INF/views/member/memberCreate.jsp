 <%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="회원가입" name="title" />
</jsp:include>

<c:if test="${not empty msg}">
	<script>
		alert('${msg}');
	</script>
</c:if>

<style>
.disabled-button {
  opacity: 0.7; /* 오파시티 설정 */
  cursor: not-allowed; /* 마우스 커서를 기본으로 변경 */
}
div#memberId-container { position:relative; padding:0px; }
div#nickname-container { position:relative; padding:0px; }
div#email-container { position:relative; padding:0px; }
span.guide { display:none; font-size:12px; position:absolute; top:12px; right:10px; }
span.nickname { display:none; font-size:12px; position:absolute; top:12px; right:10px; }
span.email { display:none; font-size:12px; position:absolute; top:12px; right:10px; }
#phone-container {
  display: flex; /* Flexbox 사용 */
  align-items: center; /* 수직 정렬을 가운데로 조정 */
}

#phone-container {
  display: flex; /* 입력 필드를 가로로 배치 */
  align-items: center; /* 수직 가운데 정렬 */
}

#phone-container input {
  margin-right: 5px; /* 입력 필드 사이 간격 설정 */
}

.phone.error {
  display: block; /* 블록 요소로 표시하여 아래에 나타나도록 함 */
  margin-top: 5px; /* 원하는 간격 설정 */
}
.phone.error{
	display: none;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberCreate.css"/>
 <div class="container">
   <div class="member-container">
   <div class = "main_area">
	 <form:form name="memberCreateFrm"
		  action="${pageContext.request.contextPath}/member/memberCreate.do"
		  method="POST"
		  enctype="multipart/form-data">
       <div class="header"> 
          <div>회원 가입</div>
      </div> 
      <fieldset class = "area_agreement">
       <legend class="sub_title">필수 정보</legend>
         <div class="fadeIn first">
            <label>아이디</label>
                  <div id="memberId-container">
                     <input type="text" class="form-control" name="memberId" id="memberId"  placeholder="아이디를 작성해주세요.">
                     <span class="guide error" style="color: red; font-size: 12px;">이 아이디는 이미 사용중입니다.</span>
                     <span class="guide reg"style="color: red; font-size: 12px;" >영,숫자로만 이루어진 5~19자리여야합니다.</span>
                     <input type="hidden" id="idValid" value="0"/>
                  </div>         
         </div>      
		<div class="fadeIn first">
		    <label>비밀번호</label>
		    <input type="password" class="form-control" name="password" id="password" placeholder="대소문자 영문,특수문자,숫자를 포함하여 9자 이상" required>
		</div>      
		<div class="fadeIn first">
		    <label>비밀번호 확인</label>
		    <input type="password" class="form-control" id="passwordConfirmation" placeholder="위의 비밀번호를 다시 입력해주세요." required>
			 <span class="passwordAlert" style="color: red; font-size: 12px;"></span>   
		</div>   
		<div class="fadeIn first">
		  <label>이름</label>
		  <input type="text" class="form-control" name="name" id="name" placeholder="이름을 입력(2글자 이상) 해주세요." required>
		  <span class="nameAlert" style="color: red; font-size: 12px;"></span>
		</div>
         <div class="fadeIn first">
                <label>닉네임</label>
			    <div id="nickname-container">
			        <input type="text" class="form-control" name="nickname" id="nickname"  placeholder="닉네임을 입력해주세요.">
			        <span class="nickname error" style="color: red; font-size: 12px;">이 닉네임은 이미 사용중입니다.</span>
			        <span class="nickname reg" style="color: red; font-size: 12px;">특수문자가 안들어간 5~10자리여야합니다.</span>
			        <input type="hidden" id="nicknameValid" value="0"/>
			    </div>		  
         </div>   
         
         <div class="fadeIn first">
            <label>전화번호</label>
			<div id="phone-container">
			  <input type="text" class="form-control" name="phone1" id="phone1" maxlength="3" required  placeholder="010">-
			  <input type="text" class="form-control" name="phone2" id="phone2" maxlength="4" required placeholder="4자리">-
			  <input type="text" class="form-control" name="phone3" id="phone3" maxlength="4" required placeholder="4자리">
			  <input type="hidden" id="phone" name="phoneNo" value="">
			  <span class="phone error" style="color: red; font-size: 12px;">핸드폰 번호 형식이 올바르지 않습니다.</span>
			</div>
         </div>   
         
         <div class="fadeIn first">
            <label>생년월일</label>
               <input type="date" class="form-control" name="birthday" id="birthday" required/>
         </div>      
         <div class="fadeIn first">
            <label>이메일</label>
			    <div id="email-container">
			        <input type="text" class="form-control" name="email" id="email" placeholder="이메일 양식에 맞게 작성해주세요.">
			        <span class="email error" style="color: red; font-size: 12px;" >이 이메일은 이미 사용중입니다.</span>
			        <span class="email reg" style="color: red; font-size: 12px;">올바른 이메일 형식이어야 합니다.</span>
			        <input type="hidden" id="emailValid" value="0"/>
			    </div>	   
            <div class = "code-btn">
            <button type="button" class="btn btn-primary" id="sendCodeButton">인증코드 보내기</button>
            </div>               
            <div>인증 코드</div>
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="floatingInputDisabled3" placeholder="q1w2e3r4" name = "code" required>
              <label for="floatingInputDisabled"></label>
            </div>
            <div><p id="emailWarning" style="color: red;"></p></div>
            <div class = "emailWarning "></div>
               <div class="codeConpare-btn">
               <button type="button" class="btn btn-primary" id="compareCodeBtn">인증번호 확인</button>
               </div>
         </div>   
         <div class="fadeIn first">
            <label>성별</label>
                 <input type="radio" name="gender" id="male" value="M" checked>
                 <label for="male">남</label>
                 
                 <input type="radio" name="gender" id="female" value="F">
                 <label for="female">여</label>
         </div>   
      </fieldset>
      
      <fieldset class = "area_interest">
      
      
       <legend class="sub_title">관심 정보</legend>
       
             <div class="fadeIn first">
               <label for="activity_area">거주지</label> <!-- 필수값 지도 API 사용 + 상세 주소값 받아야함  -->
                  
                  <div class="input-group">
                        <input type="text" class="form-control" id="activity_area" name="activityArea" readonly aria-describedby="button-addon2" placeholder="본인의 집 주소를 입력해주세요" required>
                        <div class="input-group-append">
                           <button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
                           data-target="#activity-area-modal" id="activity-area-search-btn" >검색</button>
                        </div>
                  </div>
               </div>
            <div class="fadeIn first">
               <label for="main_area_id">활동 지역</label>
                  <div class="input-group">
                     <input type="text" class="form-control" id="main_area_id" name="mainAreaId" placeholder="주로 활동할 지역을 입력해주세요" readonly aria-describedby="button-addon2" required>
                     <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
                        data-target="#main-area-id-modal" id="activity-area-search-btn">검색</button>
                     </div>
                  </div>   
               </div>      
      </fieldset>
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
			    <label for="interests">관심사</label>
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
				            <input type="hidden" name="interest" > 
				            <div><p id="interestError" style="color: red;"></p></div>
				        </div>		
			         </div>


      </fieldset>
         
           <fieldset class="area_agreement">
            
           
                            <legend class="sub_title">이용약관 / 개인정보 수집 및 이용 동의</legend>
                            <div class="agree-check">
                                <div class="all_check_area">
                                    <input type="checkbox" id="all" class="all_check">
                                    <label for="all">전체동의</label>
                                </div>
                                <div data-error_insert_container="">
                                    <input type="checkbox" id="chk1" class="check" name="" data-parsley-required="true" data-parsley-multiple="chk1">
                                    <label for="chk1">(필수) 만 14세 이상입니다.</label>
                                </div>
                        <div data-error_insert_container=""><!-- 수정한거 -->
                            <input type="checkbox" id="chk2" class="check" name="AGREEMENT" data-parsley-required="true" data-parsley-multiple="AGREEMENT">
                            <label for="chk2">(필수) 이용약관 동의</label>
                            <a href="javascript:void(0);" class="btn_view" title="이용약관 동의" id="openModalBtn1">내용보기</a>
                        </div>
                  
                                <div data-error_insert_container="">
                                    <input type="checkbox" id="chk3" class="check" name="PRIVACY" data-parsley-required="true" data-parsley-multiple="PRIVACY">
                                    <label for="chk3">(필수) 개인정보 수집 및 이용 동의</label>
                                     <a href="javascript:void(0);"class="btn_view2" title="개인정보 수집 및 이용 동의" id="openModalBtn2">내용보기</a>
                                    <div>

                                    </div>
                                    <dl>
                                        <dt>개인정보 수집</dt>
                                        <dd>
                                            <div>
                                                <span>목적</span>이용자 식별 및 본인 여부 확인
                                            </div>
                                            <div>
                                                <span>항목</span>성명, 휴대전화, 이메일, 비밀번호
                                            </div>
                                            <div>
                                                <span>보유기간</span>회원 탈퇴 시 파기
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div>
                                    <input type="checkbox" id="chk4" class="check" name="OFM0001">
                                    <label for="chk4">(선택) 이메일 수신</label>
                                    <span class="info_txt">단, 모임 참여와 관련된 정보는 수신동의 여부 관계없이 발송됩니다.</span>
                                    <dl>
                                        <dt>선택정보 수집</dt>
                                        <dd>
                                            <div>
                                                <span>목적</span>회사 광고 및 파트너 센터 서비스 제공
                                            </div>
                                            <div>
                                                <span>항목</span>이름, 이메일
                                            </div>
                                            <div>
                                                <span>보유기간</span>수신 동의 철회 또는 회원 탈퇴 시 파기
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </fieldset>


      <div class="loginbtn">
         <button type="submit">가입</button>
       </div>   
      </form:form>
   </div>
</div>
<!-- 모달 -->
   <!-- 모달 창 -->
   <div id="myModal1" class="modal1">
       <div class="modal-content1">
           <span class="close1">&times;</span>
           <jsp:include page="modalContent1.jsp" />
       </div>
   </div>
   <!-- 모달 창 -->
   <div id="myModal2" class="modal2">
       <div class="modal-content2">
           <span class="close2">&times;</span>
           <jsp:include page="modalContent2.jsp" />
       </div>
   </div>
   
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
//이메일 인증 코드 + 인증확인하기 
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
document.addEventListener('DOMContentLoaded', function() {
    var emailInput = document.querySelector("#email"); // email 입력 필드 요소
    var email = ""; // email 변수 초기화

    var emailWarning = document.getElementById('emailWarning'); // ID로 찾음
    var sendCodeButton = document.getElementById('sendCodeButton'); // 버튼 엘리먼트

    sendCodeButton.addEventListener("click", function() {
    	emailWarning.textContent = '인증번호 전송중. . . ';
        email = emailInput.value; // 버튼 클릭 시 입력 필드의 값을 가져옴
        $.ajax({
            url: "/dagachi/member/memebrInsertEmail.do",
            method: "get",
            data: {
                email: email
            },
            beforeSend(xhr) {
                console.log('xhr: ', xhr)
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
               emailWarning.textContent = '이미 존재하는 이메일이거나, 양식이 올바르지 않으면 코드가 도착하지 않을수있습니다. 반복된다면 관리자에게 문의하세요. ';
                console.log(response);
                
                var compareCodeBtn = document.getElementById('compareCodeBtn'); // 버튼 엘리먼트
                compareCodeBtn.addEventListener("click", function() {
                    var userEnteredCode = document.getElementById('floatingInputDisabled3').value;
                    if (userEnteredCode === response) {
                        emailWarning.textContent = '이메일 인증 성공!';
                    } else {
                        emailWarning.textContent = '이메일 인증 실패';
                        document.getElementById('email').value = '';
                    }
                });
            }
        });
    });
});

//관심사 체크
document.addEventListener("DOMContentLoaded", function () {
    const interestCheckboxes = document.querySelectorAll('input[name="interests"]');
    const interestError = document.getElementById("interestError");
    
    interestCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("change", function () {
            const checkedInterestCount = document.querySelectorAll(
                'input[name="interests"]:checked'
            ).length;

            if (checkedInterestCount === 0) {
                interestError.textContent = "최소 1개의 관심사를 선택해야 합니다.";
            } else if (checkedInterestCount > 3) {
                interestError.textContent = "최대 3개의 관심사까지 선택 가능합니다.";
                this.checked = false; // 3개 이상 선택 시 체크 해제
            } else {
                interestError.textContent = "";
            }

            const selectedInterests = Array.from(interestCheckboxes)
                .filter((checkbox) => checkbox.checked)
                .map((checkbox) => checkbox.value)
                .join(", ");
            
            console.log(selectedInterests);
                
            // 선택한 관심사를 쉼표로 구분된 문자열로 만들어서 input 필드에 설정
            document.querySelector('input[name="interest"]').value = selectedInterests;
        });
    });
});


// 전체동의 체크 (누르면 전체동의 한번더 누르면 전체동의 안됨)
document.getElementById("all").addEventListener("click", function () {
    var checkboxes = document.querySelectorAll(".check");
    var allChecked = this.checked;

    checkboxes.forEach(function (checkbox) {
        checkbox.checked = allChecked;
    });
});

//-----------이용약관 모달창 열고 닫기 
document.getElementById("openModalBtn1").addEventListener("click", function() {//모달 열기
    document.getElementById("myModal1").style.display = "block";
});

document.getElementsByClassName("close1")[0].addEventListener("click", function() {//모달 닫기
    document.getElementById("myModal1").style.display = "none";
});

window.addEventListener("click", function(event) {//모달 닫기 ( 외부)
    if (event.target == document.getElementById("myModal")) {
        document.getElementById("myModal1").style.display = "none";
    }
});

document.getElementById("openModalBtn2").addEventListener("click", function() {//모달 열기
    document.getElementById("myModal2").style.display = "block";
});
document.getElementsByClassName("close2")[0].addEventListener("click", function() {//모달 닫기
    document.getElementById("myModal2").style.display = "none";
});
window.addEventListener("click", function(event) {//모달 닫기 ( 외부)
    if (event.target == document.getElementById("myModal2")) {
        document.getElementById("myModal2").style.display = "none";
    }
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
//-------------------------------------- 활동지역end--------------------------------

// ------------------------------- 실시간 유효성 검사들 -------------------------------
// 관심사 체크
const minInterestCount = 1;
const maxInterestCount = 3;
const interestCheckboxes = document.querySelectorAll('input[type="checkbox"][name="interests"]');
const interestError = document.getElementById('interestError');

interestCheckboxes.forEach((checkbox) => {
    checkbox.addEventListener('change', () => {
    	console.log(interestCheckboxes);
    	console.log(interestError);
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

//멤버 아이디 실시간 유효성 검사
$(document).ready(function() {
  const memberIdInput = document.querySelector("#memberId");
  const guideError = document.querySelector(".guide.error");
  const guideReg = document.querySelector(".guide.reg");
  const idValid = document.querySelector("#idValid");
  const memberIdReg = /^[a-z]+[a-z0-9]{5,19}$/;
  memberIdInput.onkeyup = () => {
    const value = memberIdInput.value;
    console.log(value);
    if (!memberIdReg.test(value)) {
      guideReg.style.display = "inline";
      guideError.style.display = "none";
      idValid.value = "0";
    } else {
      guideReg.style.display = "none";
      $.ajax({
        url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
        data: {
          memberId: value
        },
        type: "GET",
        dataType: "json",
        success: function(responseData) {
          console.log(responseData);
          const { available } = responseData;
          if (available) {
            guideError.style.display = "none";
            idValid.value = "1";
          } else {
            guideError.style.display = "inline";
            idValid.value = "0";
          }
        }
      });
    }
  };
});

// 닉네임 실시간 검사
document.addEventListener("DOMContentLoaded", function () {
  const nicknameInput = document.querySelector("#nickname");
  const nicknameOk = document.querySelector(".nickname.ok");
  const nicknameError = document.querySelector(".nickname.error");
  const nicknameRegMsg = document.querySelector(".nickname.reg");
  const nicknameValid = document.querySelector("#nicknameValid");
  const nicknameReg = /^[a-zA-Z0-9가-힣]{5,10}$/;

  nicknameInput.onkeyup = () => {
    const value = nicknameInput.value;

    if (!nicknameReg.test(value)) {
      nicknameRegMsg.style.display = "inline";
      nicknameError.style.display = "none";
      nicknameOk.style.display = "none";
      nicknameValid.value = "0";
    } else {
      nicknameRegMsg.style.display = "none";
      $.ajax({
        url: "${pageContext.request.contextPath}/member/checkNicknameDuplicate.do",
        data: {
          nickname: value
        },
        type: "GET",
        dataType: "json",
        success: function(responseData) {
          console.log(responseData);
          const { available } = responseData;
          if (available) {
            nicknameOk.style.display = "inline";
            nicknameError.style.display = "none";
            nicknameValid.value = "1";
          } else {
            nicknameOk.style.display = "none";
            nicknameError.style.display = "inline";
            nicknameValid.value = "0";
          }
        }
      });
    }
  };
});


// 이메일 실시간검사
document.addEventListener("DOMContentLoaded", function () {
	  document.querySelector("#email").onkeyup = () => {
	    const emailInput = document.querySelector("#email");
	    const emailError = document.querySelector(".email.error");
	    const emailRegMsg = document.querySelector(".email.reg");
	    const emailValid = document.querySelector("#emailValid");
	    const emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	    
	    const value = emailInput.value;
	    
	    if (!emailReg.test(value)) {
	      emailRegMsg.style.display = "inline";
	      emailError.style.display = "none";
	      emailValid.value = "0";
	    } else {
	      emailRegMsg.style.display = "none";
	      $.ajax({
	        url: "${pageContext.request.contextPath}/member/checkEmailDuplicate.do",
	        data: {
	          email: value
	        },
	        type: "GET",
	        dataType: "json",
	        success: function(responseData) {
	          const { available } = responseData;
	          if (available) {
	            emailError.style.display = "none";
	            emailValid.value = "1";
	          } else {
	            emailError.style.display = "inline";
	            emailValid.value = "0";
	          }
	        }
	      });
	    }
	  };
	});
	
// 비밀번호 검사
document.querySelector("#passwordConfirmation").onkeyup = () => {
  const password = document.querySelector("#password").value;
  const passwordConfirmation = document.querySelector("#passwordConfirmation").value;
  const passwordAlert = document.querySelector(".passwordAlert");
  const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{9,}$/;

  if (password !== passwordConfirmation) {
    passwordAlert.innerText = "비밀번호가 일치하지 않습니다.";
  } else if (!passwordPattern.test(password)) {
    passwordAlert.innerText = "비밀번호 형식이 올바르지 않습니다. (대소문자 영문, 특수문자, 숫자를 포함하여 9자 이상)";
  } else {
    passwordAlert.innerText = ""; // 유효성 검사 통과
  }
};

	
// 핸드폰 유효성 검사
document.querySelector("#phone1").onkeyup = () => {
  combinePhoneNumbers();
};

document.querySelector("#phone2").onkeyup = () => {
  combinePhoneNumbers();
};

document.querySelector("#phone3").onkeyup = () => {
  combinePhoneNumbers();
};
function combinePhoneNumbers() {
  const phone1 = document.querySelector("#phone1").value;
  const phone2 = document.querySelector("#phone2").value;
  const phone3 = document.querySelector("#phone3").value;
  const phoneInput = document.querySelector("#phone");
  const phoneAlert = document.querySelector(".phone.error");
  if (phone1.length !== 3 || phone2.length !== 4 || phone3.length !== 4) {
    phoneAlert.innerText = "핸드폰 번호 형식이 올바르지 않습니다.";
    document.querySelector(".phone.error").style.display = "inline";
    phoneInput.value = "";
  } else {
    phoneAlert.innerText = ""; 
    document.querySelector(".phone.error").style.display = "none";
    phoneInput.value = `${phone1}-${phone2}-${phone3}`; 
  }
}

// 이름 유효성 검사
document.querySelector("#name").addEventListener("input", function () {
    const nameInput = this.value.trim(); // 공백 제거
    const nameAlert = document.querySelector(".nameAlert");

    if (/^[가-힣]{2,5}$/.test(nameInput)) {
      // 2자에서 5자 사이의 한국어 문자열인 경우
      nameAlert.textContent = "";
    } else {
      // 조건에 맞지 않는 경우
      nameAlert.textContent = "이름을 2자에서 5자 사이의 한국어로 입력해주세요.";
    }
  });
  

// 조건 불 만족시 제출 버튼 비활성화
document.querySelector('form[name="memberCreateFrm"]').addEventListener('submit', function (e) {
  const memberId = document.querySelector("#memberId").value;
  const password = document.querySelector("#password").value;
  const passwordConfirmation = document.querySelector("#passwordConfirmation").value;
  const name = document.querySelector("#name").value;
  const nickname = document.querySelector("#nickname").value;
  const phone1 = document.querySelector("#phone1").value;
  const phone2 = document.querySelector("#phone2").value;
  const phone3 = document.querySelector("#phone3").value;
  const email = document.querySelector("#email").value;
  const code = document.querySelector("#floatingInputDisabled3").value;
  const submitButton = document.querySelector("button[type='submit']"); // 제출 버튼 선택

  if (
    memberId === "" ||
    password === "" ||
    passwordConfirmation === "" ||
    name === "" ||
    nickname === "" ||
    phone1 === "" ||
    phone2 === "" ||
    phone3 === "" ||
    email === "" ||
    code === ""
  ) {
    alert("입력 필드를 모두 작성해주세요.");
    e.preventDefault(); // 폼 제출 막기
    submitButton.disabled = false; // 제출 버튼 활성화
  } else {
    submitButton.disabled = true; // 제출 버튼 비활성화
  }
});

</script>


 <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include> 
   