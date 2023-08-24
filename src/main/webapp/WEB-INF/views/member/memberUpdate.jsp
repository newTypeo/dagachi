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
    h4.mb-3{
    	text-align : center;
    }
  </style>
</head>

<body>
 <form:form name="memberUpdateFrm"
  action="${pageContext.request.contextPath}/member/memberUpdate.do"
  method="POST"
  enctype="multipart/form-data">
  <div class="container">

	
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원 정보 수정</h4>
       
          	<figure class="figure">
			  <img src="${pageContext.request.contextPath}/resources/upload/member/profile/${profile.renamedFilename}" class="figure-img img-fluid rounded" alt="...">
			</figure>
		  <div class="custom-file">
			<input type="file" name="upFile" class="custom-file-input" id="inputGroupFile01"
			aria-describedby="inputGroupFileAddon01" multiple> <label
			class="custom-file-label" for="inputGroupFile01" >${profile.renamedFilename}</label>
		  </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="memberId">아이디</label>
              <input type="text" class="form-control" id="memberId"  name = "memberId" placeholder="${loginMember.memberId}" value="" readonly>
            </div>
            
             <div class="col-md-6 mb-3">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="name" name = "name"  value="${loginMember.name}" required>
            </div>
            
            <div class="col-md-6 mb-3">
              <label for="nickname">닉네임</label>
              <input type="text" class="form-control" id="nickname"  name = "nickname"  value="Nokil" value="" required>
            </div>
          </div>
          
           <div class="col-md-6 mb-3">
            <label for="phoneNo">전화번호</label>
            <input type="text" class="form-control" id="phoneNo"  name = "phoneNo" value="${loginMember.phoneNo}" required>
          </div>

          <div class="mb-3">
            <label for="address">나의 집주소</label>
            <input type="text" class="form-control" id="address"  name = "address" value="${loginMember.address}" required>
          </div>

          
          <div class="mb-3">
            <label for="mbti">mbti</label>
            <input type="text" class="form-control" id="mbti"  name = "mbti"  value="${loginMember.mbti }" required>
          </div>

          
       	<div class="col-md-6 mb-3">
		    <label for="birthday">생일</label>
		    <input type="date" class="form-control" name="birthday" id="birthday" value="${loginMember.birthday }"/>
		</div>

    	<div class="col-md-8 mb-3">
              <label for="gender">성별</label>
              <select class="custom-select d-block w-100" id="gender"   name = "gender"  >
                <option value = ""></option>
                <option value="M" ${loginMember.gender eq 'M' ? 'selected' : '' }>M</option>
                <option value="F" ${loginMember.gender eq 'F' ? 'selected' : '' }>F</option>
              </select>
          </div>
          
          <hr class="mb-4">
          
          <div class="mb-4"></div>
          
          <button type="submit" class="btn btn-primary btn-lg">&nbsp;&nbsp;&nbsp;&nbsp;수&nbsp;&nbsp;&nbsp;정&nbsp;&nbsp;&nbsp;&nbsp;</button>
		  <button type="button" class="btn btn-secondary btn-lg">&nbsp;&nbsp;&nbsp;&nbsp;취&nbsp;&nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;&nbsp;</button>
      </div>
    </div>
  </div>
  
 </form:form>

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
  </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>



