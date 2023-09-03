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

			<div>
				<label for="address">나의 집주소</label>
				<input type="text" class="form-control11" id="address" name="address"
					value="${loginMember.address}" required>
			</div>


			<div>
				<label for="mbti">mbti</label>
				<input type="text" class="form-control11" id="mbti" name="mbti"
					value="${loginMember.mbti }" required>
			</div>


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
  </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>



