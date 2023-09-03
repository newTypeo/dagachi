<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp">
	<jsp:param value="소모임 수정" name="title" />
</jsp:include>

<style>
.modal {
	top: -840px;
}

.modal-body {
	height: 400px;
}

#club-create-form-wrapper {
	margin: 0 auto 100px auto;
	width: 800px;
}

.address-checked {
	padding: 5px;
	margin: 0;
}

.address-checked:hover {
	background-color: #ddd;
	cursor: pointer;
}
#tagContainer {
	display: flex;
	background-color: lightskyblue;
	border-radius: 5px;
	margin-bottom: 20px;
}

.tagWrapper {
	height: 30px;
	margin: 5px;
	border: 2px solid white;
	position: relative;
	border-radius: 5px;
	display: flex;
}
.tagBox {
}
.cancelTagBox {
	width: 20px;
	cursor: pointer;
	text-align: center;
}
</style>

<span id="before-tag" style="display: none"><c:forEach items="${clubTagList}" var="clubTag">${clubTag.tag}!!</c:forEach></span>


<section id="club-create-sec" class="">
	<div id="update-btn-container">
		<div class="btn-group" role="group" aria-label="Basic example">
			<button type="button" class="btn btn-primary" id="club-update-btn">정보 수정</button>
			<button type="button" class="btn btn-primary" id="club-style-update">스타일 설정</button>
			<button type="button" class="btn btn-primary" id="club-title-update">타이틀 설정</button>
			<button type="button" class="btn btn-primary" id="club-member-manage">회원 관리</button>
		</div>
		<c:if test ="${memberRole eq 3}">
			<button type="button" class="btn btn-danger" id="clubDisabled">모임 해산</button>
		</c:if>
	</div>
	<div id="club-create-form-wrapper">
		<h3>소모임 정보수정</h3>
		<form:form name="clubUpdateFrm"
		action="${pageContext.request.contextPath}/club/${domain}/clubUpdate.do"
		enctype="multipart/form-data" method="post">
		
			<label for="club_name">소모임 이름</label>
			<div class="input-group">
				<input type="text" class="form-control" id="club_name" name="clubName" value = "${club.clubName}">
			</div>

			<label for="activity_area">주 활동지</label>
			<div class="input-group">
				<input type="text" class="form-control" id="activity_area" name="activityArea" readonly aria-describedby="button-addon2" value="${club.activityArea}">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
					data-target="#activity-area-modal" id="activity-area-search-btn" >검색</button>
				</div>
			</div>
			
			<div class="form-group">
				<label for="category">카테고리</label> <select class="form-control"
					id="category" name="category">
					<option disabled selected></option>
					<option value="차/오토바이" ${club.category eq '차/오토바이' ? 'selected' : ''}>차/오토바이</option>
					<option value="게임/오락" ${club.category eq '게임/오락' ? 'selected' : ''}>게임/오락</option>
					<option value="여행" ${club.category eq '여행' ? 'selected' : ''}>여행</option>
					<option value="운동/스포츠" ${club.category eq '운동/스포츠' ? 'selected' : ''}>운동/스포츠</option>
					<option value="인문학/독서" ${club.category eq '인문학/독서' ? 'selected' : ''}>인문학/독서</option>
					<option value="업종/직무" ${club.category eq '업종/직무' ? 'selected' : ''}>업종/직무</option>
					<option value="언어/회화" ${club.category eq '언어/회화' ? 'selected' : ''}>언어/회화</option>
					<option value="공연/축제" ${club.category eq '공연/축제' ? 'selected' : ''}>공연/축제</option>
					<option value="음악/악기" ${club.category eq '음악/악기' ? 'selected' : ''}>음악/악기</option>
					<option value="공예/만들기" ${club.category eq '공예/만들기' ? 'selected' : ''}>공예/만들기</option>
					<option value="댄스/무용" ${club.category eq '댄스/무용' ? 'selected' : ''}>댄스/무용</option>
					<option value="봉사활동" ${club.category eq '봉사활동' ? 'selected' : ''}>봉사활동</option>
					<option value="사교/인맥" ${club.category eq '사교/인맥' ? 'selected' : ''}>사교/인맥</option>
					<option value="사진/영상" ${club.category eq '사진/영상' ? 'selected' : ''}>사진/영상</option>
					<option value="야구관람" ${club.category eq '야구관람' ? 'selected' : ''}>야구관람</option>
					<option value="요리/제조" ${club.category eq '요리/제조' ? 'selected' : ''}>요리/제조</option>
					<option value="애완동물" ${club.category eq '애완동물' ? 'selected' : ''}>애완동물</option>
					<option value="자유주제" ${club.category eq '자유주제' ? 'selected' : ''}>자유주제</option>
				</select>
			</div>

			<div class="form-group">
				<label for="inputGroupFile01">소모임 프로필</label>
				<div class="custom-file">
					<input type="file" class="custom-file-input" id="inputGroupFile01"
						name="upFile" aria-describedby="inputGroupFileAddon01"> <label
						class="custom-file-label" for="inputGroupFile01">${clubProfile.renamedFilename}</label>
				</div>
			</div>
			
			<label for="tagInput">태그</label>
			<div class="input-group">
				 <input type="text" class="form-control" id="tagInput" name="tagInput">
				 <div class="input-group-append">
    			 	<button class="btn btn-outline-secondary" type="button" id="tagInputBtn">추가</button>
  				 </div>
			</div>
			<div id="tagContainer" class="bg-primary">
			</div>
			<input type="hidden" id="tags" name="tags" readonly/>
			
			

			<div class="form-group">
				<label for="domain">도메인</label> <input type="text"
					class="form-control" id="domain" name="domain" value="${club.domain}">
			</div>

			<div class="form-group">
				<label for="introduce">소개글</label>
				<textarea class="form-control" id="introduce" name="introduce"
					rows="3" >${club.introduce}</textarea>
			</div>
			<div class="form-group">
				<label for="enroll_question">가입질문</label>
				<textarea class="form-control" id="enroll_question"
					name="enrollQuestion" rows="3">${club.enrollQuestion}</textarea>
			</div>

			<button class="btn btn-primary" type="submit" style="float: right">소모임 수정</button>
		</form:form>




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



</section>


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

// tag 추가
const tagContainer = document.querySelector("#tagContainer");
const tagInput = document.querySelector("#tagInput");
const tags = document.querySelector("#tags");

const beforeTag = document.querySelector("#before-tag");
const beforeTagListWithBlank = beforeTag.innerHTML.split("!!");
const tagList = beforeTagListWithBlank.slice(0, beforeTagListWithBlank.length-1);
tags.value = tagList;
tagList.forEach((tag) => {
	tagContainer.insertAdjacentHTML('beforeend', `
			<div class="tagWrapper">
				<div class="tagBox">#\${tag}</div>
				<div class="cancelTagBox" onclick="cancelTag(this);">
					<span style="color: #555;"><i class="fa-solid fa-x"></i></span>
				</div>
			</div>`);
});

tagInputBtn.onclick = () => {
	if (!tagInput.value) {
		return false;
	}
	
	tagList.push(tagInput.value);
	
	console.log(tagList);
	tagContainer.insertAdjacentHTML('beforeend', `
			<div class="tagWrapper">
				<div class="tagBox">#\${tagInput.value}</div>
				<div class="cancelTagBox" onclick="cancelTag(this);">
					<span style="color: #555;"><i class="fa-solid fa-x"></i></span>
				</div>
			</div>`);
	
	
	
	tagContainer.value = "";
	tags.value = tagList;
	tagInput.value = "";
};
const cancelTag = (elem) => {
	console.log(elem.previousElementSibling.innerHTML.replace("#", ""));
	elem.parentElement.remove();
	
	const value = elem.previousElementSibling.innerHTML.replace("#", ""); // 삭제할 값을 지정
	const index = tagList.findIndex(element => element === value); // 삭제할 값과 일치하는 요소의 인덱스
	if (index !== -1) {
		tagList.splice(index, 1); // 해당 인덱스의 요소를 1개 삭제
	}
	console.log(tagList);
	tags.value = tagList;
}



//준한(모임 비활성화)
const domain = "<%= request.getAttribute("domain") %>"; 


document.querySelector("#club-update-btn").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubUpdate.do';
}

document.querySelector("#club-style-update").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubStyleUpdate.do';
}

document.querySelector("#club-title-update").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubTitleUpdate.do';
}

document.querySelector("#club-member-manage").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/manageMember.do';
}
</script>

<c:if test="${memberRole eq 3}">
	<script>
	//서버 사이드에서 domain 값을 가져와서 설정
	document.querySelector("#clubDisabled").onclick = (e) => {
	  const userConfirmation = confirm("정말 비활성화 하시겠습니까?");
	  if (userConfirmation) {
	      // 도메인 값을 사용하여 컨트롤러로 이동하는 코드를 추가
	      window.location.href = "${pageContext.request.contextPath}/club/" + domain + "/clubDisabled.do";
	      alert('모임이 성공적으로 비활성화 되었습니다.');
	  }
	};
	</script>
</c:if>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>