<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="소모임 생성" name="title" />
</jsp:include>

<style>
.modal {
	top: -840px;
}

.modal-body {
	height: 400px;
}

#club-create-form-wrapper {
	margin: 50px auto;
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
}

.tagWrapper {
	height: 30px;
	margin: 5px;
	border: 2px solid white;
	position: relative;
	display: flex;
}
.tagBox {
}
.cancelTagBox {
	width: 30px;
	cursor: pointer;
}
</style>

<section id="club-create-sec" class="">

	<div id="club-create-form-wrapper">
		<h1>소모임 생성</h1>
		<form:form name="clubCreateFrm"
		action="${pageContext.request.contextPath}/club/clubCreate.do"
		enctype="multipart/form-data" method="post">
		
			<label for="club_name">소모임 이름</label>
			<div class="input-group">
				<input type="text" class="form-control" id="club_name" name="clubName">
			</div>

			<label for="activity_area">주 활동지</label>
			<div class="input-group">
				<input type="text" class="form-control" id="activity_area" name="activityArea" readonly aria-describedby="button-addon2">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button" data-toggle="modal" 
					data-target="#activity-area-modal" id="activity-area-search-btn">검색</button>
				</div>
			</div>
			
			<div class="form-group">
				<label for="category">카테고리</label> <select class="form-control"
					id="category" name="category">
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

			<div class="form-group">
				<label for="inputGroupFile01">소모임 프로필</label>
				<div class="custom-file">
					<input type="file" class="custom-file-input" id="inputGroupFile01"
						name="upFile" aria-describedby="inputGroupFileAddon01"> <label
						class="custom-file-label" for="inputGroupFile01">Choose
						file</label>
				</div>
			</div>
			
			<label for="tagInput">태그</label>
			<div class="input-group">
				 <input type="text" class="form-control" id="tagInput" name="tagInput">
				 <div class="input-group-append">
    			 	<button class="btn btn-outline-secondary" type="button" id="tagInputBtn">추가</button>
  				 </div>
			</div>
			<div id="tagContainer" class="bg-primary"></div>
			<input type="text" id="tags" name="tags" readonly>
			

			<div class="form-group">
				<label for="domain">도메인</label> <input type="text"
					class="form-control" id="domain" name="domain">
			</div>

			<div class="form-group">
				<label for="introduce">소개글</label>
				<textarea class="form-control" id="introduce" name="introduce"
					rows="3"></textarea>
			</div>
			<div class="form-group">
				<label for="enroll_question">가입질문</label>
				<textarea class="form-control" id="enroll_question"
					name="enrollQuestion" rows="3"></textarea>
			</div>

			<button class="btn btn-primary" type="submit">소모임 생성</button>
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
const tagList = [];
const tagContainer = document.querySelector("#tagContainer");
const tagInput = document.querySelector("#tagInput");
const tags = document.querySelector("#tags");

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
					<span style="color: #555;">X</span>
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


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>