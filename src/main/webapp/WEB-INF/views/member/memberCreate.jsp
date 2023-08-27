
<%--진짜 회원가입이 될 창 지우지 마세요 --%>
 <%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="비비비" name="title" />
</jsp:include>

<div id="enroll-container" class="mx-auto text-center">

	<form:form name="memberCreateFrm" action="" method="POST">
		<table class="mx-auto w-75">
			<tr>
				<th>프로필 사진</th><!-- 만약 지정 안하면 기본값으로 들어감 -->
				<td>
		          	<figure class="figure">
					  <img src="${pageContext.request.contextPath}/resources/upload/member/profile/default.png" class="figure-img img-fluid rounded" alt="...">
					</figure>				
					<div class="custom-file">
						<input type="file" name="upFile" class="custom-file-input" id="inputGroupFile01"
						aria-describedby="inputGroupFileAddon01" multiple> <label
					class="custom-file-label" for="inputGroupFile01" >${profile.renamedFilename}</label>
				 	</div>
				</td>
				
			</tr>
			<tr>
				<th>아이디</th>
				<td>
					<div id="memberId-container">
						<input type="text" 
							   class="form-control" 
							   placeholder="4글자이상"
							   name="memberId" 
							   id="memberId"
							   value="honggd"
							   pattern="\w{4,}"
							   required>
						<span class="guide ok">이 아이디는 사용가능합니다.</span>
						<span class="guide error">이 아이디는 이미 사용중입니다.</span>
						<input type="hidden" id="idValid" value="0"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>패스워드</th><!--실기간 유효성 검사  -->
				<td>
					<input type="password" class="form-control" name="password" id="password" value="1234" required>
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
					<input type="text" class="form-control" name="name" id="name" value="홍길동" required>
				</td>
			</tr>
			<tr>
				<th>닉네임</th><!--실기간 유효성 검사  -->
				<td>	
					<input type="text" class="form-control" name="nickname" id="nickname" value="길똥구리" required>
				</td>
			</tr>
			<tr>
				<th>전화번호</th><!--실기간 유효성 검사 + 양식에 맞게 작성하게   -->
				<td>	
					<input type="text" class="form-control"  name="phoneNo" id="phoneNo" value="010-1111-1111">
				</td>
			</tr>	
			<tr>
				<th>생년월일</th><!--양식에 맞게  검  -->
				<td>	
					<input type="date" class="form-control" name="birthday" id="birthday" value="1999-09-09"/>
				</td>
			</tr> 
			<tr>
				<th>이메일</th><!--이메일은 이메일 인증이필요하기에 걍 두기  -->
				<td>	
					<input type="text" class="form-control"  name="email" id="email" value="honggd@naver.com">
				</td>
			</tr>
			<tr>
				<th>성별</th> <!-- 선택해서 하나의 값만 받을수 있게 만들기  -->
				<td>	
					<input type="text" class="form-control" name="gender" id="gender" value="M">
				</td>
			</tr>			
			<tr>
				<th>MBTI</th> <!-- 선택해서 하나의 값만 받을수 있게 만들기  -->
				<td>	
					<input type="text" class="form-control"  name="email" id="email" value="ENTP">
				</td>
			</tr>			
		
			<tr>
				<th>거주지</th> <!-- 필수값 지도 API 사용 + 상세 주소값 받아야함  -->
				<td>	
					<input type="text" class="form-control"  name="email" id="email" value="서울시 역삼동 구리230-1번지">
				</td>
			</tr>			
				<th>주활동지역</th><!-- 기본값으로 하나 들어가야함  + -->  
				<td>	
					<input type="text" class="form-control"  name="mainAreaId" id="mainAreaId" value="서울시 역삼동">
				</td>
			</tr>			
			<tr>
				<th>서브활동지역1</th><!--   추가 버튼을 누르면 하나씩 추가됨 +  들어가야함 -->  
				<td>	
					<input type="text" class="form-control"  name="sub1AreaId" id="sub1AreaId" value="서울시 역삼동">
				</td>
			</tr>
			<tr>
				<th>서브활동지역2</th>
				<td>	
					<input type="text" class="form-control" name="sub2AreaId" id="sub2AreaId" value="서울시 역삼동">
				</td>
			</tr>			
			<tr>
				<th>관심사</th><!-- 관심사도 목록중 3개를 받을수있음 / 하나만 받아도 가능하다.    -->  
				<td>	
					<input type="text" class="form-control" name="interest" id=interest value="운동/스포즈">
				</td>
			</tr>
									
		</table>
		<input type="submit" value="가입" >
	</form:form>
</div>
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


// 멤버 아이디 실시간 유효성 검사
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


// 실시간 유효성 검사로 바꾸끼
/* document.memberCreateFrm.onsubmit = (e) => {
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
}; */


</script>



 <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include> 
   
   
  <%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
   integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
   crossorigin="anonymous">
   
   <style>

  .step {
   display: none;
  }

  .step.active {
  display: block;
  }

body {
   min-height: 100vh;
   background: -webkit-gradient(linear, left bottom, right top, from(#92b5db),
      to(#1d466c));
   background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
   background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
   background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
   background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
}

.input-form {
   max-width: 680px;
   margin-top: 80px;
   padding: 32px;
   background: #fff;
   -webkit-border-radius: 10px;
   -moz-border-radius: 10px;
   border-radius: 10px;
   -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
   -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
   box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}
</style>
</head>

<body>


   <form:form name="memberCreateFrm" action="" method="POST" modelAttribute="member">
      <input type="hidden" name="_csrf" th:attr="value=${_csrf.token}" />
      
      <div id="step1" class="step active"> <!-- 아이디,이름,닉네임 받으 -->
    	 <div>1단계</div>
         <div class="col-md-6 mb-3">
            <label for="memberId">아이디</label> 
            <input type="memberId"
               class="form-control" id="memberId" name="memberId" value="Nokil"
               value="" required>
         </div>
         </div>
            <div class="col-md-6 mb-3">
            <label for="nickname">닉네임</label> <input type="text"
               class="form-control" id="nickname" name="nickname" value="Nokil"
               value="" required>
         </div>
         <div class="col-md-6 mb-3">
            <label for="name">이름</label> <input type="text" class="form-control"
               id="name" name="name" value="방식이" value="" required>
         </div>
      </div>
      
      <div id="step2" class="step"><!-- 비밀번호 확인 -->
         <div>2단계</div>
         <div class="col-md-6 mb-3">
            <label for="password">비밀번호</label> <input type="text"
               class="form-control" id="password" name="password" value="Json@!1"
               value="" required>
         </div>
         <div class="col-md-6 mb-3">
            <label for="passwordConfirmation">비밀번호 확인</label> <input type="text"
               class="form-control" id="passwordConfirmation"
               name="passwordConfirmation" value="Json@!1" value="" required>
      </div>
      
      <div id="step3" class="step"><!-- 이메일 확인 -->
      	<div>3단계</div>
         <div  class="col-md-6 mb-3">
            <label for="email">이메일</label> <input type="email"
               class="form-control" id="email" name="email"
               value="Jso2122n@naver.com" required>
         </div>
         <button>이메일 인증하기</button>
      </div>
      <div><!-- 전화번호 성별 생일 -->
         <div  class="col-md-6 mb-3">
               <label for="phoneNo">전화번호</label> <input type="text"
                  class="form-control" id="phoneNo" name="phoneNo"
                  value="010-9999-9999" required>
         </div>
         <div  class="col-md-6 mb-3">
               <label for="gender">성별</label> <select
                  class="custom-select d-block w-100" id="gender" name="gender">
                  <option value=""></option>
                  <option>M</option>
                  <option>F</option>
               </select>
         </div>
         <div  class="col-md-6 mb-3" >
               <label for="birthday">생일</label> <input type="date"
                  class="form-control" id="birthday" name="birthday"
                  value="2008-09-09" required>
         </div>
      </div>
      
      <div id="step4" class="step"> <!-- 가입 완료 버튼 -->
         <!--  8   -->
         <div  class="col-md-6 mb-3">
            <label for="address">나의 집주소</label> <input type="text"
               class="form-control" id="address" name="address" value="강남역"
               required>
         </div>
         <div  class="col-md-6 mb-3" >
            <label for="mainAreaId">주활동 지역</label> <input type="text"
               class="form-control" id="mainAreaId" name="main_area_id"
               placeholder="" required>
         </div>
         <!--                
          <label for="mainAreaId">서브 활동지역1</label>
               <input type="text" class="form-control" id="mainAreaId"  name = "main_area_id" placeholder="" required>
             </div>        
             <div class="mb-3">
               <label for="mainAreaId">서브 활동지역2</label>
               <input type="text" class="form-control" id="mainAreaId"  name = "main_area_id" placeholder="" required>
             </div>                       
           -->
      </div>
      
      <div id="step5" class="step"><!-- 엠비티아이  -->
         <!--  6   -->
         <div  class="col-md-6 mb-3">
            <label for="mbti">mbti</label> 
            <!-- <input type="text" class="form-control" id="mbti" name="mbti" value="entj" required> -->
         </div>
         <button>ISTJ</button>
         <button>ISFJ</button>
         <button>INFJ</button>
         <button>INTJ</button>
         <button>ISTP</button>
         <button>ISFP</button>
         <button>INTP</button>
         <button>INTP</button>
         <button>ESTJ</button>
         <button>ESFJ</button>
         <button>ENFJ</button>
         <button>ENTJ</button>
         <button>ESTP</button>
         <button>ESFP</button>
         <button>ENTP</button>
         <button>ENTP</button>
         <button>없음</button>
      </div>
      
      <div id="step6" class="step"><!-- 관심사   -->
         <div class="col-md-6 mb-3">
            <label for="interest">관심사</label> 
            <!-- <input type="text"class="form-control" id="interest" name="interest" placeholder=""required> -->
         </div>
         <button>차/오토바이</button>
         <button>게임/오락</button>
         <button>여행</button>
         <button>운동/스포츠</button>
         <button>댄스/무용</button>
         <button>봉사활동</button>
         <button>사교/인맥</button>
         <button>야구관람</button>
         <button>언어/회화</button>
         <button>요리/제조</button>
         <button>공연/축제</button>
         <button>애완동물</button>
         <button>음악/악기</button>
         <button>자유주제</button>
      </div>
      
      <div id="step7"  class="step" > <!-- 가입 완료 버튼 -->
         <!--  9   -->
         <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement"
               required> <label class="custom-control-label"
               for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
              <button class="btn btn-primary btn-lg btn-block" type="submit">가입 하기</button>
         </div>
      </div> 
        
    <div id="changeStep">
        <div id="changePrevious">
            <button type="button" onclick="previousStep()" id="previousButton" style="display: none;">이전</button>
        </div>
        <div id="changeNext">
            <button type="button" onclick="nextStep()" id="nextButton">다음</button>
        </div>
    </div>
      
      
   </form:form>


   <script>
   
   let currentStep = 1;
   const totalSteps = 7; // 총 단계 수

   function updateStepVisibility() {
       // 모든 단계를 숨김
       const steps = document.getElementsByClassName("step");
       for (let i = 0; i < steps.length; i++) {
           steps[i].classList.remove("active");
       }

       // 현재 단계만 보이도록 설정
       document.getElementById("step" + currentStep).classList.add("active");

       // 현재 단계가 1이면 이전 버튼을 숨깁니다.
       if (currentStep === 1) {
           document.getElementById("previousButton").style.display = "none";
       } else {
           document.getElementById("previousButton").style.display = "inline-block";
       }

       // 현재 단계가 마지막 단계면 다음 버튼을 숨깁니다.
       if (currentStep === totalSteps) {
           document.getElementById("nextButton").style.display = "none";
       } else {
           document.getElementById("nextButton").style.display = "inline-block";
       }
   }

   function previousStep() {
       if (currentStep > 1) {
           currentStep--;
           updateStepVisibility();
       }
   }

   function nextStep() {
       if (currentStep < totalSteps) {
           currentStep++;
           updateStepVisibility();
       }
   }

   // 페이지 로드 시 첫 번째 단계를 표시합니다.
   window.onload = () => {
       updateStepVisibility();
   };

      
   </script>


   <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
   integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
   crossorigin="anonymous">

  <style>
    body {
      min-height: 100vh;

      background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
      background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
    }

    .input-form {
      max-width: 680px;

      margin-top: 80px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
  </style>
</head>

<body>

 <form:form name="memberCreateFrm" action="" method="POST" modelAttribute="member">
  <div class="container">

    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
       
          <div class="row">
          
            <div class="col-md-6 mb-3">
              <label for="memberId">아이디</label>
              <input type="text" class="form-control" id="memberId"  value="honggddd"  name = "memberId"
              placeholder="" value="" required>
            </div>
            
             <div class="col-md-6 mb-3">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="name" name = "name"  value="방식이" value="" required>
            </div>
            
             <div class="col-md-6 mb-3">
              <label for="password">비밀번호</label>
              <input type="text" class="form-control" id="password" name = "password" value="Json@!1" value="" required>
              <div class="invalid-feedback">
                비밀번호 입력해주세요.
              </div>
            </div>
             
             <div class="col-md-6 mb-3">
              <label for="passwordConfirmation">비밀번호 확인</label>
              <input type="text" class="form-control" id="passwordConfirmation" name = "passwordConfirmation" value="Json@!1" value="" required>
            </div>
            
            <div class="col-md-6 mb-3">
              <label for="nickname">닉네임</label>
              <input type="text" class="form-control" id="nickname"  name = "nickname"  value="Nokil" value="" required>
            </div>
          </div>

          <div class="mb-3">
            <label for="email">이메일</label>
            <input type="email" class="form-control" id="email"   name = "email" value="Jso2122n@naver.com" required>
          </div>
          
           <div class="mb-3">
            <label for="phoneNo">전화번호</label>
            <input type="text" class="form-control" id="phoneNo"  name = "phoneNo" value="010-9999-9999" required>
          </div>

          <div class="mb-3">
            <label for="address">나의 집주소</label>
            <input type="text" class="form-control" id="address"  name = "address" value="강남역" required>
          </div>

          
          <div class="mb-3">
            <label for="mbti">mbti</label>
            <input type="text" class="form-control" id="mbti"  name = "mbti"  value="entj" required>
          </div>

          
       	<div class="col-md-6 mb-3">
		    <label for="birthday">생일</label>
		    <input type="date" class="form-control" name="birthday" id="birthday" value="1999-09-09"/>
		</div>

    	<div class="col-md-8 mb-3">
              <label for="gender">성별</label>
              <select class="custom-select d-block w-100" id="gender"   name = "gender"  >
                <option value=""></option>
                <option>M</option>
                <option>F</option>
              </select>
          </div>
          
          <hr class="mb-4">
          
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div>
          
          <div class="mb-4"></div>
          
          <button class="btn btn-primary btn-lg btn-block" type="submit">가입 완료</button>
      </div>
    </div>
  </div>
  
 </form:form>

  <script>
  document.memberCreateFrm.onsubmit = (e) => {
	const password = document.querySelector("#password");
	const passwordConfirmation = document.querySelector("#passwordConfirmation");
	const birthday = document.querySelector("#birthday");
	
	console.log(birthday);

		if(password.value !== passwordConfirmation.value) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
	};
  </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
 --%>
