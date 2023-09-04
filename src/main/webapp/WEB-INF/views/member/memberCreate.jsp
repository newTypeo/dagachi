 <%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:if test="${not empty msg}">
	<script>
		alert('${msg}');
	</script>
</c:if>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="회원가입" name="title" />
</jsp:include>

<style>
        /* 비활성화된 버튼 스타일 */
        button:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }
* {
  box-sizing: border-box;
  font-family: 'IBM Plex Sans KR', sans-serif;
  font-style: normal;
}

body {
  display: flex;
  flex-direction: row;
  justify-content: center;
}

.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 700px;
  height: 1990px;
  margin-top: 130px;
  margin-bottom: 60px;
  background: #ffffff;
  border: solid 4px #DDD;
  border-radius: 20px;
  box-shadow: 0 0 0 rgba(0, 0, 0, 0); 
  transition: box-shadow 0.3s ease-in-out; 
}
.container:hover {
    box-shadow: 0 0 50px rgba(0, 0, 0, 0.3);
}
.member-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 470px;
  height: 818px;
  margin-top: 72px;
  margin-bottom: 70px;
}

.header {
  width: 466px;
  height: 94px;
  font-weight: 700;
  font-size: 32px;
  line-height: 47px;
  color: #2990D0;
}

.user-info div {
  font-weight: 400;
  font-size: 16px;
  line-height: 24px;
  color: #797979;
  border-bottom: 1px solid #cfcfcf;
  width: 466px;
  height: 80px;
  margin-top: 21px;
}

.user-info #email {
  border-bottom: 1px solid #2990D0;
}

.gender {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 140px;
  height: 23.94px;
  margin-top: 50px;
}

.form-control input {
  width: 20px;
  height: 19.95px;
  background: #ebebeb;
  border: 1px solid #2990d0;
}


.agree-check {
  width: 454px;
  height: 21.06px;
  margin-top: 52.05px;
  font-weight: 400;
  font-size: 14px;
  line-height: 21px;
  color: #000000;
}

.enrollbtn button {
  display: flex;
  flex-direction: column;
  justify-content: center; /* 텍스트를 수직 방향 가운데 정렬 */
  align-items: center; /* 텍스트를 수평 방향 가운데 정렬 */
  margin-top: 25x;
  width: 470px;
  height:70px
  border-top: 1px solid #2990D0;
  font-size: 30px;
  color: #ffffff;
  background: #2990D0;
  border: 1px solid #2990D0;
  border-radius: 10px;
}

.btn-email {
  background: #2990D0;
  color: #ffffff;
  height: 36px;
  border-radius: 5px;
  border: 1px solid #2990D0; 
   
}
/******/
.modal {
    top: 20px;
}

.modal-body {
    height: 200px;
}
.modal.show .modal-dialog {
    -webkit-transform: none;
    transform: none;
    margin-top: 250px;
}

.main-area-id-checked, .address-checked {
    padding: 5px;
    margin: 0;
}

.main-area-id-checked:hover, .address-checked:hover {
    background-color: #ddd;
    cursor: pointer;
}

#tagContainer {
    display: flex;
    background-color: lightskyblue;
    border-radius: 5px;
}

.tagWrapper {
    height: 30px;
    margin: 5px;
    border: 2px solid white;
    position: relative;
    border-radius: 5px;
    display: flex;
}

.modal1 {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.7);
}

.modal-content1 {
    background-color: #fff;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 50%;
    height: 400px;
    overflow: scroll;
}

/* 닫기 버튼 1 스타일 */
.close1 {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

/* 보기 버튼 스타일 */
.btn_view {
    cursor: pointer;
}


.disabled-button {
  opacity: 0.7; /* 오파시티 설정 */
  cursor: not-allowed; /* 마우스 커서를 기본으로 변경 */
}
div#memberId-container { position:relative; padding:0px; }
div#nickname-container { position:relative; padding:0px; }
div#name-container { position:relative; padding:0px; }
div#email-container { position:relative; padding:0px; }
div#password-container { position:relative; padding:0px; }
div#passwordConfirmation-container { position:relative; padding:0px; }
span.guide { display:none; font-size:12px; position:absolute; top:12px; right:10px; }
span.nickname { display:none; font-size:12px; position:absolute; top:12px; right:10px; }
span.name { display:none; font-size:12px; position:absolute; top:12px; right:10px; }
span.email { display:none; font-size:12px; position:absolute; top:12px; right:10px; }
span.password { display:none; font-size:12px; position:absolute; top:12px; right:10px; }
span.passwordConfirmation { display:none; font-size:12px; position:absolute; top:12px; right:10px; }
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

/* 전체 동의 영역 스타일 */
.agreement {
    border: 1px solid #ccc;
    border-radius: 10px;
    padding: 20px;
    margin-top: -20px;
    margin-bottom: 40px;
    height: 340px;
    background-color: #e9ecef;
}

/* 전체 동의 제목 스타일 */
.sub_title {
  font-weight: bold;
  margin-bottom: 10px;
  font-size: 20px;
  border-bottom: 1px solid #2990D0; /* 아래쪽에 1px 두께의 선 추가 */
  display: inline-block; /* 선을 추가하기 위해 inline-block으로 설정합니다. */
  padding-bottom: 5px; /* 선 아래 여백 조절 (선택 사항) */
}

.sub_title1 {
  font-weight: bold;
  margin-bottom: 10px;
  font-size: 20px;

}

/* 전체 동의 체크박스 및 라벨 스타일 */
.all_check_area {
    border-bottom: 1px solid #ccc;
    font-size: 24px;
    margin-top: -60px;
    padding-bottom: 10px;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
}

.all_check_area input[type="checkbox"] {
  margin-right: 10px;
}

/* '내용보기' 링크 스타일 */
.btn_view {
  color: gray;
  text-decoration: none;
  font-size: 14px;
  margin-left: 10px;
}

/* 개인정보 수집 dl 스타일 */
.agreement dl {
  background-color: #fff;
  border-radius: 5px;
  padding: 10px;
  margin-top: 10px;
}

.agreement dl dt {
  font-weight: bold;
  margin-bottom: 5px;
}

.agreement dl dd {
  margin-bottom: 15px;
}

/* 필수 항목 텍스트 스타일 */
.agreement .check label {
  font-weight: bold;
}
/* email_group 클래스에 대한 스타일 */
.email_group {
    display: flex; /* 내부 요소를 가로로 나란히 배치하기 위해 Flex 사용 */
}



.form-control#email {
    width: 370px; /* 원하는 너비로 설정 (예: 100%는 부모 요소의 너비에 맞게 확장) */
    margin-bottom: 10px;
}
.form-control#floatingInputDisabled3 {
    width: 370px; /* 원하는 너비로 설정 (예: 100%는 부모 요소의 너비에 맞게 확장) */
}
/* fadeIn.first 내부 요소를 가로로 나란히 표시 */
.fadeIn.first {
	display: flex;
    align-items: stretch;
    flex-wrap: wrap;
    justify-content: space-between;
    margin: 3px;
}


/* 아이디 라벨 스타일 */
.fadeIn.first label {
    font-size: 16px; /* 라벨의 텍스트 크기 조절 */
    color: #333; /* 라벨 텍스트 색상 설정 */
    margin-right: 30px; /* 라벨과 입력 필드 사이 간격 설정 */
}

/* 아이디 입력 필드 스타일 */
.fadeIn.first input[type="text"] {
    flex: 1; /* 남은 공간을 모두 사용하여 확장 */
    font-size: 16px; /* 입력 필드 텍스트 크기 조절 */
}
/* 아이디 입력 필드 너비 조정 */
#memberId {
    width: 370px; /* 원하는 너비로 설정 (예: 100%는 부모 요소의 너비에 맞게 확장) */
    font-size: 16px; /* 입력 필드 텍스트 크기 조절 */
}
#password{
    width: 370px;  /* 원하는 너비로 설정 (예: 100%는 부모 요소의 너비에 맞게 확장) */
    font-size: 16px; /* 입력 필드 텍스트 크기 조절 */
}
#passwordConfirmation{
    width: 370px; /* 원하는 너비로 설정 (예: 100%는 부모 요소의 너비에 맞게 확장) */
    font-size: 16px; /* 입력 필드 텍스트 크기 조절 */
}
#name{
    width: 370px;  /* 원하는 너비로 설정 (예: 100%는 부모 요소의 너비에 맞게 확장) */
    font-size: 16px; /* 입력 필드 텍스트 크기 조절 */
}
#nickname{
    width:  370px;  /* 원하는 너비로 설정 (예: 100%는 부모 요소의 너비에 맞게 확장) */
    font-size: 16px; /* 입력 필드 텍스트 크기 조절 */
}

/* .fadeIn.first 클래스 내부의 라디오 버튼에만 적용되는 CSS */
.fadeIn.first input[type="radio"][name="gender"] {
    /* 라디오 버튼 스타일 (숨김) */
    display: none;
}

.fadeIn.first input[type="radio"][name="gender"] + label {
    /* 라디오 버튼 레이블 스타일 */
    margin-right: 10px; /* 라디오 버튼 레이블 간의 간격 조정 */
    padding: 4px 8px;
    border: 1px solid #ccc;
    border-radius: 20px;
    cursor: pointer;
}

.fadeIn.first input[type="radio"][name="gender"]:checked + label {
    /* 선택된 라디오 버튼 스타일 */
    background-color: #2990D0;
    color: #fff;
    border-color: #2990D0;
}

img {
    vertical-align: middle;
    border-style: none;
    margin-bottom: 60px;
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
<%--       
      <legend class="sub_title">간편 회원가입</legend>  
		 <a href="${pageContext.request.contextPath}/oauth2/authorization/kakao">
			<img src="${pageContext.request.contextPath}/resources/images/kakaoL.png" alt="카카오 로그인">
		 </a> --%>
		 
      <fieldset class = "area_agreement">
       <legend class="sub_title">회원 정보</legend>
         <div class="fadeIn first">
            <label>아이디</label>
                  <div id="memberId-container">
                     <input type="text" class="form-control" name="memberId" id="memberId"  placeholder="아이디를 작성해주세요." >
                     <span class="guide error" style="color: GRAY; font-size: 12px;">이 아이디는 이미 사용중입니다.</span>
                     <span class="guide reg"style="color: GRAY; font-size: 12px;" >영,숫자로만 이루어진 5~19자리여야합니다.</span>
                     <input type="hidden" id="idValid" value="0"/>
                  </div>         
         </div>      
         
		<div class="fadeIn first">
		    <label>비밀번호</label>
		     <div id="name-container">
		    <input type="password" class="form-control" name="password" id="password" placeholder="대소문자 영문,특수문자,숫자를 포함하여 9자 이상"  required>
		    <span class="password error" style="color: GRAY; font-size: 12px;">비밀번호 형식이 올바르지 않습니다.</span>
		    <input type="hidden" id="passwordValid" value="0"/>
		    </div>
		</div>
		
		<div class="fadeIn first">
		    <label>비밀번호 확인</label>
		     <div id="passwordConfirmation-container">
		    <input type="password" class="form-control" id="passwordConfirmation" placeholder="위의 비밀번호를 다시 입력해주세요."  required>
			<span class="passwordConfirmation error" style="color: GRAY; font-size: 12px;">비밀번호가 일치하지 않습니다.</span>
			 <input type="hidden" id="passwordConfirmationValid" value="0"/>
			</div>
		</div>   
		
		<div class="fadeIn first">
		   <label>이름</label>
			  <div id="name-container">
			  <input type="text" class="form-control" name="name" id="name" placeholder="이름을 입력(2글자 이상) 해주세요." required>
			  <span class="name reg" style="color: GRAY; font-size: 12px;">이름은 한글 2~5글자 여야합니다.</span>
			  <input type="hidden" id="nameValid" value="0"/>
			  
 
			</div>
		</div>
		
         <div class="fadeIn first">
                <label>닉네임</label>
			    <div id="nickname-container">
			        <input type="text" class="form-control" name="nickname" id="nickname"   placeholder="닉네임을 입력해주세요." required>
			        <span class="nickname error" style="color: GRAY; font-size: 12px;">이 닉네임은 이미 사용중입니다.</span>
			        <span class="nickname reg" style="color: GRAY; font-size: 12px;">특수문자가 안들어간 5~10자리여야합니다.</span>
			        <input type="hidden" id="nicknameValid" value="0"/>
			    </div>		  
         </div>   
         
         <div class="fadeIn first">
            <label>전화번호  </label><span class="phone error" style="color: GRAY; font-size: 12px;"> 핸드폰 번호 형식이 올바르지 않습니다.</span>
			<div id="phone-container">
			  <input type="text" class="form-control" name="phone1" id="phone1" maxlength="3" required  placeholder="3자리" >-
			  <input type="text" class="form-control" name="phone2" id="phone2" maxlength="4" required placeholder="4자리">-
			  <input type="text" class="form-control" name="phone3" id="phone3" maxlength="4" required placeholder="4자리">
			</div>
         </div>   
          <input type="hidden" id="phoneNo" name="phoneNo" value="">
			   <input type="hidden" id="phoneNoValid" value="0"/>
         
         <div class="fadeIn first">
            <label>생년월일</label>
               <input type="date" class="form-control" name="birthday" id="birthday" required/>
         </div>      
                     
         <div class="fadeIn first">
            <label>성별</label>
                 <input type="radio" name="gender" id="male" value="M" checked>
                 <label for="male">남</label>
                 
                 <input type="radio" name="gender" id="female" value="F">
                 <label for="female">여</label>
         </div>
         
         <div class="fadeIn first">
            <label>이메일</label>
            <div class = "email_group">
			    <div id="email-container">
			        <input type="text" class="form-control" name="email" id="email" placeholder="이메일 양식에 맞게 작성해주세요." required>
			        <span class="email error" style="color: GRAY; font-size: 12px;" >이 이메일은 이미 사용중입니다.</span>
			        <span class="email reg" style="color: GRAY; font-size: 12px;">올바른 이메일 형식이어야 합니다.</span>
			        <input type="hidden" id="emailValid" value="0"/>
			    </div>	   
	            <div class = "code-btn">
	           		 <button type="button" class = "btn-email" id="sendCodeButton">인증코드 보내기</button>
	          	</div>  
	         </div>
	         
	          <div class = "email_group">
	            <div>
	              <input type="text" class="form-control" id="floatingInputDisabled3" placeholder="인증코드를 입력해주세요." name = "code"  required>
	              <label for="floatingInputDisabled"></label>
	              <input type="hidden" id="emailCkValid" value="0"/>
	            </div>
	            <div>
	              <button type="button" class = "btn-email"  id="compareCodeBtn">인증번호 확인</button>
	            </div>
            </div>
            <div><p id="emailWarning" style="color: GRAY;"></p></div>
              <div class = "emailWarning "></div>
         </div>   

      </fieldset>
      
      <fieldset class = "area_interest">
      
      
       <legend class="sub_title">관심 정보</legend>
       
             <div class="fadeIn first">
               <label for="activity_area">거주지</label> <!-- 필수값 지도 API 사용 + 상세 주소값 받아야함  -->
                  
                  <div class="input-group">
                        <input type="text" class="form-control" id="activity_area" name="activityArea" readonly aria-describedby="button-addon2" placeholder="본인의 집 주소를 입력해주세요" required>
                         <input type="hidden" id="activityAreaValid" value="0"/>
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
                       <input type="hidden" id="mainAreaIdValid" value="0"/>
                     <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
                        data-target="#main-area-id-modal" id="activity-area-search-btn">검색</button>
                     </div>
                  </div>   
               </div>      
      </fieldset>
      <fieldset class = "type">
         <div class="fadeIn first"> 
             <label for="mbti">MBTI</label>
                    <div class="toggle-radio" data-style="rounded"> 
                        <label><input type="radio" name="mbti" value="ISTJ" class="custom-radio" required> ISTJ</label>
                        <label><input type="radio" name="mbti" value="ISFJ" class="custom-radio" required> ISFJ</label>
                        <label><input type="radio" name="mbti" value="INFJ" class="custom-radio"required> INFJ</label>
                        <label><input type="radio" name="mbti" value="INTJ" class="custom-radio"required> INTJ</label>
                        <label><input type="radio" name="mbti" value="ISTP" class="custom-radio"required> ISTP</label>
                        <label><input type="radio" name="mbti" value="ISFP" class="custom-radio"required> ISFP</label>
                        <label><input type="radio" name="mbti" value="INFP" class="custom-radio"required> INFP</label>
                        <label><input type="radio" name="mbti" value="INTP" class="custom-radio"required> INTP</label>
                        <label><input type="radio" name="mbti" value="ESTP" class="custom-radio"required> ESTP</label>
                        <label><input type="radio" name="mbti" value="ESFP" class="custom-radio"required> ESFP</label>
                        <label><input type="radio" name="mbti" value="ENFP" class="custom-radio"required> ENFP</label>
                        <label><input type="radio" name="mbti" value="ENTP" class="custom-radio"required> ENTP</label>
                        <label><input type="radio" name="mbti" value="ESTJ" class="custom-radio"required> ESTJ</label>
                        <label><input type="radio" name="mbti" value="ESFJ" class="custom-radio"required> ESFJ</label>
                        <label><input type="radio" name="mbti" value="ENFJ" class="custom-radio"required> ENFJ</label>
                        <label><input type="radio" name="mbti" value="ENTJ" class="custom-radio"required> ENTJ</label>
                    </div>
                </div>
				<div class="fadeIn first"> 
			    <label for="interests">관심사</label>
				        <div class="form-group">
				            <label><input type="checkbox" name="interests" value="차/오토바이" > 차/오토바이</label>
				            <label><input type="checkbox" name="interests" value="게임/오락"  > 게임/오락</label>
				            <label><input type="checkbox" name="interests" value="여행"  > 여행</label>
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
				            <div><p id="interestError" style="color: GRAY;"></p></div>
				        </div>		
			         </div>
			         <input type="hidden" name="interest" > 
			         <input type="hidden" id="interestValid" value="0"/> 
      </fieldset>
         
           <fieldset class="agreement">
                            <legend class="sub_title1">이용약관 / 개인정보 수집 및 이용 동의</legend>
                            <div class="agree-check">
                                <div class="all_check_area">
                                    <input type="checkbox" id="all" class="all_check" >
                                    <label for="all" >전체동의</label>
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
                 	 <input type="hidden" id="agreementValid" value="0">
                                <div data-error_insert_container="">
                                    <input type="checkbox" id="chk3" class="check" name="PRIVACY" data-parsley-required="true" data-parsley-multiple="PRIVACY">
                                    <label for="chk3">(필수) 개인정보 수집 및 이용 동의</label>
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
                            </div>
                        </fieldset>
      <div class="enrollbtn">
         <button type="submit">가입</button>
       </div>   
      </form:form>
   </div>
</div>
<!-- 모달 -->
   <!-- 동의 목록 모달 창 -->
   <div id="myModal1" class="modal1">
       <div class="modal-content1">
           <span class="close1">&times;</span>
           <jsp:include page="modalContent1.jsp" />
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
    const emailCkValid = document.querySelector("#emailCkValid");
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
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
               emailWarning.textContent = ' ! ! !인증번호 발송 완료 ! ! ! 인증번호가 오지 않으면 입력하신 정보가 맞는지 확인해주세요.문제가 지속된다면 관리자에게 문의 바랍니다.';
                console.log(response); 
                var compareCodeBtn = document.getElementById('compareCodeBtn'); // 버튼 엘리먼트
                compareCodeBtn.addEventListener("click", function() {
                    var userEnteredCode = document.getElementById('floatingInputDisabled3').value;
                    if (userEnteredCode === response) {
                        emailWarning.textContent = '이메일 인증 성공!';
                        emailCkValid.value = "1";
                    } else {
                        emailWarning.textContent = '이메일 인증 실패! 다시 시도해주세요.';
                        emailCkValid.value = "0";
                    }
                    checkConditions();
                });
            }
        });
    });
});

//전체동의 체크 (누르면 전체동의 한번더 누르면 전체동의 안됨)
document.getElementById("all").addEventListener("click", function () {
    var checkboxes = document.querySelectorAll(".check");
    var allChecked = this.checked;

    checkboxes.forEach(function (checkbox) {
        checkbox.checked = allChecked;
    });

    updateAgreementValid();
});

// 필수 체크박스들의 변경 이벤트를 처리합니다.
var chk1 = document.getElementById("chk1");
var chk2 = document.getElementById("chk2");
var chk3 = document.getElementById("chk3");
chk1.addEventListener("change", updateAgreementValid);
chk2.addEventListener("change", updateAgreementValid);
chk3.addEventListener("change", updateAgreementValid);

// 필수 체크박스 상태에 따라 agreementValid 값을 업데이트합니다.
function updateAgreementValid() {
    var chk1Checked = chk1.checked;
    var chk2Checked = chk2.checked;
    var chk3Checked = chk3.checked;

    if (chk1Checked && chk2Checked && chk3Checked) {
        agreementValid.value = "1";
    } else {
        agreementValid.value = "0";
    }
    checkConditions();
}

// 초기 상태에서 필수 체크박스들을 체크한 경우 agreementValid 값을 1로 설정합니다.
if (chk1.checked && chk2.checked && chk3.checked) {
    agreementValid.value = "1";
    checkConditions();
}

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
//-------------------------------------- 집 주소 시작 --------------------------------
const addressSearchBox = document.querySelector("#address-search-box");
const addressBox = document.querySelector(".address-box");  
const activityAreaValid = document.querySelector("#activityAreaValid");
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
     activityAreaValid.value = "1";
 }
 // 클릭된 요소가 'address-confirm-btn' 아이디를 가진 경우 활동 영역 값을 설정하고 모달을 닫습니다.
 if (clickedElement.matches("#address-confirm-btn")) {
    document.querySelector("#activity_area").value = addressSearchBox.value;
    $('#activity-area-modal').modal('hide');
    activityAreaValid.value = "1";
    
 }
 checkConditions();
});
//-------------------------------------- 집 주소 끝 --------------------------------
//-------------------------------------- 주 활동지역start--------------------------------
const mainAreaIdSearchBox = document.querySelector("#main-area-id-search-box");
const mainAreaIdBox = document.querySelector(".main-area-id-box");   
const mainAreaIdValid = document.querySelector("#mainAreaIdValid");
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
       mainAreaIdValid.value = "1";
    }
    // 사용자가 확인 버튼 클릭시 활동지역을 activity_area 요소에 설정하고 모달 창을 닫음
    if (clickedElement.matches("#main-area-id-confirm-btn")) {
       document.querySelector("#main_area_id").value = mainAreaIdSearchBox.value;
       $('#main-area-modal').modal('hide');
       mainAreaIdValid.value = "1";
    }
    checkConditions();
});
//-------------------------------------- 활동지역end--------------------------------

// ------------------------------- 실시간 유효성 검사들 -------------------------------
//관심사 체크
document.addEventListener("DOMContentLoaded", function () {
    const interestCheckboxes = document.querySelectorAll('input[name="interests"]');
    const interestError = document.getElementById("interestError");
    const interestValid = document.querySelector("#interestValid"); 
    
    interestCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("change", function () {
            const checkedInterestCount = document.querySelectorAll(
                'input[name="interests"]:checked'
            ).length;

            if (checkedInterestCount === 0) {
                interestError.textContent = "최소 1개의 관심사를 선택해야 합니다.";
                interestValid.value = "0";
            }else if (checkedInterestCount > 1) { 
            	interestValid.value = "1";
            }else if (checkedInterestCount > 3) {
                interestError.textContent = "최대 3개의 관심사까지 선택 가능합니다.";
                interestValid.value = "1";
                this.checked = false; // 3개 이상 선택 시 체크 해제
            } else {
                interestError.textContent = "";
            }
            const selectedInterests = Array.from(interestCheckboxes)
                .filter((checkbox) => checkbox.checked)
                .map((checkbox) => checkbox.value)
                .join(", ");
            // 선택한 관심사를 쉼표로 구분된 문자열로 만들어서 input 필드에 설정
            document.querySelector('input[name="interest"]').value = selectedInterests;
            checkConditions();
        });
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
          const { available } = responseData;
          if (available) {
            guideError.style.display = "none";
            idValid.value = "1";
          } else {
            guideError.style.display = "inline";
            idValid.value = "0";
          } 
          checkConditions();
        }
      });
    }
  };
});

// 닉네임 실시간 검사
document.addEventListener("DOMContentLoaded", function () {
  const nicknameInput = document.querySelector("#nickname");
  const nicknameError = document.querySelector(".nickname.error");
  const nicknameRegMsg = document.querySelector(".nickname.reg");
  const nicknameValid = document.querySelector("#nicknameValid");
  const nicknameReg = /^[a-zA-Z0-9가-힣]{5,10}$/;

  nicknameInput.onkeyup = () => {
    const value = nicknameInput.value;

    if (!nicknameReg.test(value)) {
      nicknameRegMsg.style.display = "inline";
      nicknameError.style.display = "none";
      nicknameValid.value = "0";
    } else {
      nicknameRegMsg.style.display = "none";
      $.ajax({
        url: "${pageContext.request.contextPath}/member/checkNicknameDuplicate.do",
        data: {
          nickname: value},
        type: "GET",
        dataType: "json",
        success: function(responseData) {
          const {available} = responseData;
          if (available) {
            nicknameError.style.display = "none";
            nicknameValid.value = "1";
          } else {
            nicknameError.style.display = "inline";
            nicknameValid.value = "0";
          }
          checkConditions();
        }
      });
    }
  };
});


// 이메일 실시간검사 / 형식 , 중복 유효성 검사
//DOMContentLoaded 문서의 요소가 로드후 발생하는 이벤트
document.addEventListener("DOMContentLoaded", function () {
	  document.querySelector("#email").onkeyup = () => {
	    const emailInput = document.querySelector("#email");
	    const emailError = document.querySelector(".email.error");
	    const emailRegMsg = document.querySelector(".email.reg");
	    const emailValid = document.querySelector("#emailValid");
	    const emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	    var sendCodeButton = document.getElementById('sendCodeButton');
	    
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
	          checkConditions();
	        }
	      });
	    }
	  };
	});
	
// 비밀번호 검사
    const passwordInput = document.querySelector("#password");
    const passwordConfirmationInput = document.querySelector("#passwordConfirmation");
    const passwordError = document.querySelector(".password.error");
    const passwordConfirmationError = document.querySelector(".passwordConfirmation.error");
    const passwordValid= document.querySelector("#passwordValid");
    const passwordConfirmationValid = document.querySelector("#passwordConfirmationValid");

    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{9,}$/;

    passwordInput.addEventListener("input", () => {
        const password = passwordInput.value;
        if (!passwordPattern.test(password)) {
            passwordError.style.display = "inline";
            passwordValid.value = "0";
        } else {
            passwordError.style.display = "none";
            passwordValid.value = "1";
        }
        checkConditions();
    });

    passwordConfirmationInput.addEventListener("keyup", () => {
        const password = passwordInput.value;
        const passwordConfirmation = passwordConfirmationInput.value;
        if (password !== passwordConfirmation) {
            passwordConfirmationError.style.display = "inline";
            passwordConfirmationValid.value = "0";
        } else {
            passwordConfirmationError.style.display = "none";
            passwordConfirmationValid.value = "1";
        }
        checkConditions();
    });
	
// 핸드폰 유효성 검사
document.querySelector("#phone1").addEventListener("input", () => {
    combinePhoneNumbers();
});

document.querySelector("#phone2").addEventListener("input", () => {
    combinePhoneNumbers();
});

document.querySelector("#phone3").addEventListener("input", () => {
    combinePhoneNumbers();
});

function combinePhoneNumbers() {
    const sanitizedPhone1 = document.querySelector("#phone1").value;
    const sanitizedPhone2 = document.querySelector("#phone2").value;
    const sanitizedPhone3 = document.querySelector("#phone3").value;
    const phoneInput = document.querySelector("#phoneNo");
    const phoneNoValid = document.querySelector("#phoneNoValid");
    
    if (sanitizedPhone1.length !== 3 || sanitizedPhone2.length !== 4 || sanitizedPhone3.length !== 4) {
        document.querySelector(".phone.error").style.display = "inline";
        phoneNoValid.value = "0";
    } else {
        document.querySelector(".phone.error").style.display = "none";
        const combinedPhone = sanitizedPhone1 + sanitizedPhone2 + sanitizedPhone3;
        phoneInput.value = combinedPhone; 
        phoneNoValid.value = "1";
    }
    checkConditions();
}

// 이름 유효성 검사
        const nameInput = document.getElementById("name");
        const nameReg = document.querySelector(".name.reg");
        const nameValid = document.querySelector("#nameValid");
        nameInput.addEventListener("input", function () {
            const name = nameInput.value.trim();
            const isValid = /^[가-힣]{2,5}$/.test(name);
            if (!isValid) {
                nameReg.style.display = "block";
                nameValid.value = "0";
            } else {
                nameReg.style.display = "none";
                nameValid.value = "1";
            }
            checkConditions();
        });
</script>

<script>
//필요한 요소들을 가져옵니다.
var _nicknameValid = document.getElementById("nicknameValid");
var _nameValid = document.getElementById("nameValid");
var _passwordConfirmationValid = document.getElementById("passwordConfirmationValid");
var _passwordValid = document.getElementById("passwordValid");
var _idValid = document.getElementById("idValid");
var _emailValid = document.getElementById("emailValid");
var _emailCkValid = document.getElementById("emailCkValid");
var _phoneNoValid = document.getElementById("phoneNoValid"); // x
var _interestValid = document.getElementById("interestValid");
var _activityAreaValid = document.getElementById("activityAreaValid");
var _mainAreaIdValid = document.getElementById("mainAreaIdValid");
var _agreementValid = document.getElementById("agreementValid");

var enrollbtn = document.querySelector(".enrollbtn button[type='submit']");

function checkConditions() {
    const validConditions = [
        _idValid,
        _passwordValid,
        _passwordConfirmationValid,
        _nameValid,
        _nicknameValid,
        _emailCkValid,
        _phoneNoValid,
        _interestValid,
        _activityAreaValid,
        _mainAreaIdValid,
        _agreementValid,
    ];
    console.log(validConditions);
    const isValid = validConditions.every(tag => tag.value === "1" && tag.value !== "");
    
    if (isValid) {
    	enrollbtn.removeAttribute("disabled");
    } else {
    	enrollbtn.setAttribute("disabled", "disabled");
    }
}


</script>

 <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include> 
   