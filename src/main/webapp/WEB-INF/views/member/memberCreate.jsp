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