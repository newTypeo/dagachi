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

  <input type="hidden" name="_csrf" th:attr="value=${_csrf.token}" />
  
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

          
          <div class="mb-3">
            <label for="birthday">생일</label>
            <input type="date" class="form-control" id="birthday"  name = "birthday"  value="2008-09-09" required>
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