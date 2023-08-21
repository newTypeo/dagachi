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

<body></body>



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
         <button>이메일 인증하기(추후 추가 예정)</button>
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
            <label for="address">집주소</label> <input type="text"
               class="form-control" id="address" name="address" value="강남역"
               required>
         </div>
         
            <div  class="col-md-6 mb-3">
            <label for="address-add">집주소 상세</label> <input type="text"
               class="form-control" id="address-add" name="address-add" value="104동"
               required> 
         </div>
      <!--    <div  class="col-md-6 mb-3" >
            <label for="mainAreaId">주활동 지역</label> <input type="text"
               class="form-control" id="mainAreaId" name="main_area_id"
               placeholder="" required>
         </div> -->
         
			<label for="activity_area">주 활동지</label>
			<div class="input-group">
				<input type="text" class="form-control" id="activity_area" name="main_area_id" readonly aria-describedby="button-addon2">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
					data-target="#activity-area-modal" id="activity-area-search-btn">검색</button>
				</div>
			</div>
			  
          <label for="mainAreaId">서브 활동지역1</label>
               <input type="text" class="form-control" id="mainAreaId"  name = "main_area_id" placeholder="" required>
             </div>        
           <div class="mb-3">
               <label for="mainAreaId">서브 활동지역2</label>
               <input type="text" class="form-control" id="mainAreaId"  name = "main_area_id" placeholder="" required>
           </div>                       
          
      </div>
      
      <div id="step5" class="step"><!-- 엠비티아이  -->
         <!--  6   -->
         <div  class="col-md-6 mb-3">
         <fieldset>
            <label for="mbti">mbti</label> 
            <!-- <input type="text" class="form-control" id="mbti" name="mbti" value="entj" required> -->
         <div id= "category" class = "cat">
	         <ul>
	         	<li> 
				  <li><input type='checkbox' name='catg' value='ISFJ' onclick='getCheckboxValue()'/> ISFJ</li>
				  <li><input type='checkbox' name='catg' value='INTJ' onclick='getCheckboxValue()'/> INTJ</li>
		          <li><input type='checkbox' name='catg' value='ISTJ' onclick='getCheckboxValue()'/> ISTJ</li>
				  <li><input type='checkbox' name='catg' value='ISTJ' onclick='getCheckboxValue()'/> ISTJ</li>
				  <li><input type='checkbox' name='catg' value='ISTP' onclick='getCheckboxValue()'/> ISTP</li>
				  <li><input type='checkbox' name='catg' value='ISFP' onclick='getCheckboxValue()'/> ISFP</li>
				  <li><input type='checkbox' name='catg' value='INTP' onclick='getCheckboxValue()'/> INTP</li>
				  <li><input type='checkbox' name='catg' value='ESTJ' onclick='getCheckboxValue()'/> ESTJ</li>
				  <li><input type='checkbox' name='catg' value='ESFJ' onclick='getCheckboxValue()'/> ESFJ</li>
				  <li><input type='checkbox' name='catg' value='ENTJ' onclick='getCheckboxValue()'/> ENTJ</li>
				  <li><input type='checkbox' name='catg' value='ESTP' onclick='getCheckboxValue()'/> ESTP</li>
				  <li><input type='checkbox' name='catg' value='ESFP' onclick='getCheckboxValue()'/> ESFP</li>
				  <li><input type='checkbox' name='catg' value='ENTP' onclick='getCheckboxValue()'/> ENTP</li>
				  <li><input type='checkbox' name='catg' value='없음' onclick='getCheckboxValue()'/> 없음</li>
		        </ul>
		</div>
		
			</fieldset>
			<button type = "button" id = "selectb">선택</button>
			<div id = "selectCat"></div>
			</div>
		</div>
   

  <div id='result'></div>
      </div>
      
      <div id="step6" class="step"><!--관심사-->
         <div class="col-md-6 mb-3">
            <label for="interest">관심사</label> 
            <!-- <input type="text"class="form-control" id="interest" name="interest" placeholder=""required> -->
				<select class="form-control"
					id="interest" name="interest">
					<option disabled selected>-카테고리 선택-</option>
					<option>차/오토바이</option>
					<option>게임/오락</option>
					<option>여행</option>
					<option>운동/스포츠</option>
					<option>인문학/독서</option>
					<option>업종/직무</option>
					<option>언어/회화</option>
					<option>공연/축제</option>
					<option>음악/악기</option>
					<option>공예/만들기</option>
					<option>댄스/무용</option>
					<option>봉사활동</option>
					<option>사교/인맥</option>
					<option>사진/영상</option>
					<option>야구관람</option>
					<option>요리/제조</option>
					<option>애완동물</option>
					<option>자유주제</option>
				</select>
			</div>
			 
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
		        <button type="button" onclick="previousStep()" id="previousButton">이전</button>
		    </div>
		    <div id="changeNext">
		        <button type="button" onclick="nextStep()" id="nextButton">다음</button>
		    </div>
		</div>
		      
      <div class="modal modal-dialog modal-dialog-scrollable fade"
			id="activity-area-modal" data-backdrop="static" data-keyboard="false"
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
						<label for="address-search-box">주 활동지 : </label> <input
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
		</div>
	</div>
      
      
   </form:form>


 <script>

  const addressSearchBox = document.querySelector("#address-search-box");
  const addressBox = document.querySelector(".address-box");	

  addressSearchBox.onkeyup = (e) => {
  	$.ajax({
  		url : '${pageContext.request.contextPath}/club/findAddress.do',
  		data : { keyword : e.target.value },
  		method : "GET",
  		success(addressList) {
  			if (addressList == '') {
  				addressBox.innerHTML = '<p>검색 결과가 존재하지 않습니다.</p>';
  				return;
  			}
  			
  			addressBox.innerHTML = "";
  			addressList.forEach((address) => {
  				addressBox.innerHTML += `
  					<p class='address-checked'>\${address}</p>
  				`;
  			});
  		}
  	});
  }


  document.addEventListener('click', (e) => {
      const clickedElement = e.target;
      
      if (clickedElement.matches(".address-checked")) {
          addressSearchBox.value = e.target.innerHTML;
      }
      if (clickedElement.matches("#address-confirm-btn")) {
      	document.querySelector("#activity_area").value = addressSearchBox.value;
      	$('#activity-area-modal').modal('hide');
      }
  });
  
  
  //mbti 체크박스
	window.onload = function() {
		// 모든 input 요소 가져오기
		var allInputs = document.getElementsByTagName("input");
		var categories = document.getElementsByName("catg");
		var writeC = '';

		// 카테고리 선택을 누르면 카테고리를 기록
		document.getElementById("select").onclick = function() {
		    for (var i = 0; i < categories.length; i++) {
		        if (categories[i].checked) {
		            writeC += categories[i].value;
		        }
		    }
		    document.getElementById("selectCat").innerText = writeC;

		
		}

		// 카테고리 내 checkbox를 클릭하면 c() 함수 실행
		for (var i = 0; i < categories.length; i++) {
		    categories[i].onclick = c;
		}


	}
		  
</script>

   <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>