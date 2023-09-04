<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>

<style>

</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93a8b5c4b928b15af7b1a5137fba4962"></script>

<section id="club-board-sec" class="">

	<nav id="club-title" class="">
		<c:if test="${layout.title eq null}">
			<div id="default-title">
				<h2>${domain}</h2>
			</div>
		</c:if>
		
		<c:if test="${layout.title ne null}">
			<img src="${pageContext.request.contextPath}/resources/upload/club/title/${layout.title}">
		</c:if>
	</nav>
	
	<nav id="club-nav-bar" style="border-color: ${layout.pointColor}">
		<h5><a href="${pageContext.request.contextPath}/club/${domain}">🚩${clubName}</a></h5>
		<div class="fontColors">
			<ul>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">📢공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">🐳자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">✋가입인사</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">🎉정모후기</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubGallery.do">📷갤러리</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">📅일정</a></li>
			</ul>
		</div>
	</nav>

	<div id="schedule-content-container">	
		<form:form action="${pageContext.request.contextPath}/club/${domain}/scheduleCreate.do"
					method="post">
		<div id="schedule-create-container">
			<h3>새 일정 생성</h3>
			
			<label for="title">제목</label>	
			<div class="input-group">
			    <input type="text" id="title" name="title" class="form-control" placeholder="제목을 입력하세요" aria-label="Username" aria-describedby="basic-addon1">
			</div>
			
			<div id="date-input-container">
				<div>
					<label for="startDate">시작일</label>	
					<div class="input-group">
					    <input type="date" id="startDate" name="startDate" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
					</div>
				</div>
				<span> ~ </span>
				<div>
					<label for="endDate">종료일</label>	
					<div class="input-group">
					    <input type="date" id="endDate" name="endDate" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
					</div>
				</div>				
			</div>
			
			<div id="capacity-expence-container">
				<div>
					<label for="capacity">최대인원</label>	
					<div class="input-group">
					    <input type="number" id="capacity" name="capacity" class="form-control" placeholder="최대 인원을 입력하세요" aria-label="Username" aria-describedby="basic-addon1">
					    <div class="input-group-append">
							<span class="input-group-text" id="basic-addon2">명</span>
						</div>
					</div>
				</div>
				<div>
					<label for="expence">모임비</label>	
					<div class="input-group">
					    <input type="number" id="expence" name="expence" class="form-control" placeholder="모임비를 입력하세요" aria-label="Username" aria-describedby="basic-addon1">
					    <div class="input-group-append">
							<span class="input-group-text" id="basic-addon2">원</span>
						</div>
					</div>
				</div>
			</div>
			
			<label for="content">내용</label>	
			<div class="input-group">
			    <textarea id="content" name="content" class="form-control" aria-label="With textarea" style="height: 100px"></textarea>
			</div>
			
			<div id="place-create-container">
				<h5>장소</h5>
				<label for="address-name">장소명</label>	
				<div class="input-group">
			    	<input type="text" id="address-name" name="address-name" class="form-control" placeholder="장소 이름을 입력하세요" aria-describedby="basic-addon1">
				</div>
				<div id="address-input-container">
					<div id="address-input-container1">
						<label for="address-address">주소</label> <!-- 필수값 지도 API 사용 + 상세 주소값 받아야함  -->
	    	         	<div class="input-group address-input">
	        	            <input type="text" class="form-control" id="address-address" readonly aria-describedby="button-addon2" placeholder="주소를 입력해주세요" required>
	            	        <div class="input-group-append">
	                	    	<button class="btn btn-secondary" type="button" data-toggle="modal" 
	                	         data-target="#activity-area-modal" id="activity-area-search-btn" >검색</button>
	               			</div>
	                	</div>
					</div>
	                <div id="address-input-container2">
		                <label for="address-detail">상세주소</label>	
						<div class="input-group">
					    	<input type="text" id="address-detail" name="address-detail" class="form-control" placeholder="상세 주소를 입력하세요" aria-describedby="basic-addon1">
						</div>
	                </div>
				</div>
				<button class="btn" id="place-add-btn" type="button">장소 추가</button>
			</div>
			<input type="hidden" id="placesArr" name="placesArr"/>
			<input type="hidden" id="placesStartTimeArr" name="placesStartTimeArr"/>
			<div id="added-place-continer">
			</div>
			
		</div>
		<button id="scheduleCreateBtn2" class="btn">일정 등록</button>
		
		</form:form>
	</div>
	
	
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
      
      
</section>



<script>

document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";


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
    document.querySelector("#address-address").value = addressSearchBox.value;
    $('#activity-area-modal').modal('hide');
 }
});
//-------------------------------------- 집 주소 끝 --------------------------------


//---------- 장소 추가 버튼 이벤트 ---------------
const placeAddBtn = document.querySelector("#place-add-btn");
const placeContainer = document.querySelector("#added-place-continer");

placeAddBtn.addEventListener('click', () => {
	var addedPlaceDiv = document.querySelectorAll(".added-place");
	var addedNo = addedPlaceDiv.length;
	var aName = document.querySelector("#address-name").value;
	var aAddress = document.querySelector("#address-address").value;
	var aDetail = document.querySelector("#address-detail").value;
	
	if (!aName || !aAddress || !aDetail) {
		alert("입력값을 전부 입력해주세요");
		return false;
	}
	
	placeContainer.insertAdjacentHTML('beforeend', `
		<div class="added-place">
			<div class="updown-container">
				<div class="up-box" onclick="upPlace(this);">
					<i class="fa-solid fa-caret-up"></i>
				</div>
				<div class="down-box" onclick="downPlace(this);">
					<i class="fa-solid fa-caret-down"></i>
				</div>
			</div>
			<div>
				<span class="added-place-no"></span>
				<span class="added-place-name">\${aName}</span>	
				<br>
				<span>주소 : </span>
				<span class="added-place-address">\${aAddress}</span>
				<span>, </span>
				<span class="added-place-details">\${aDetail}</span>
			</div>
			<div class="cancle-container">
				<div class="cancle-box" onclick="canclePlace(this);">
					<i class="fa-solid fa-xmark fa-xl"></i>
				</div>
			</div>
			<div class="startTime-container">
				<span id="start-time">시작시간(필수)</span>
				<input type="datetime-local" id="added-place-startTime\${addedNo+1}" class="added-place-startTime" required/>
			</div>
		</div>
	`);
	
	document.querySelector(`#added-place-startTime\${addedNo+1}`).focus();
	
	numbering();
	addPlacesArr();
});

const canclePlace = (e) => {
	e.parentElement.parentElement.remove();
	numbering();
	addPlacesArr();
}

const numbering = () => {
	var addedPlaceNoSpan = document.querySelectorAll(".added-place-no");
	var index = 1;
	addedPlaceNoSpan.forEach((e) => {
		e.innerHTML = index + ".";
		index++;
	});
};
//=====================================
	
//================== 추가된 장소 위치 바꾸기
const upPlace = (e) => {
	var previousElem = e.parentElement.parentElement.previousElementSibling;
	if(!previousElem) {
		return false;
	};
	e.parentElement.parentElement.lastElementChild.lastElementChild.value = "";
	previousElem.lastElementChild.value = "";
	
	e.parentElement.parentElement.insertAdjacentHTML('afterend', 
		'<div class="added-place">' + previousElem.innerHTML + '</div>');
	
	previousElem.remove();
	numbering();
	addPlacesArr();
}

const downPlace = (e) => {
	var nextElem = e.parentElement.parentElement.nextElementSibling;
	if(!nextElem) {
		return false;
	};
	e.parentElement.parentElement.lastElementChild.lastElementChild.value = "";
	nextElem.lastElementChild.value = "";
	
	e.parentElement.parentElement.insertAdjacentHTML('beforebegin', 
		'<div class="added-place">' + nextElem.innerHTML + '</div>');
	nextElem.remove();
	numbering();
	addPlacesArr();
}
 
//=============== 입력값들 배열에 저장
const placesArr = document.querySelector("#placesArr");
const addPlacesArr = () => {
	var placesVar = [];
	var placesSequence = [];
	var placesName = [];
	var placesAddress = [];
	var placesDetails = [];
	
	document.querySelectorAll(".added-place-no").forEach((elem) => {
		placesSequence.push(elem.innerHTML.split(".")[0]);
	});
	document.querySelectorAll(".added-place-name").forEach((elem) => {
		placesName.push(elem.innerHTML);
	});
	document.querySelectorAll(".added-place-address").forEach((elem) => {
		placesAddress.push(elem.innerHTML);
	});
	document.querySelectorAll(".added-place-details").forEach((elem) => {
		placesDetails.push(elem.innerHTML);
	});
	
	placesVar = [placesSequence, placesName, placesAddress, placesDetails];
	placesArr.value = placesVar;
};


const placesStartTimeArr = document.querySelector("#placesStartTimeArr");
scheduleCreateBtn2.addEventListener('click', (e) => {
	var placesStartTime = [];
	if(!document.querySelector(".added-place")) {
		alert("최소 한개의 장소를 추가해주세요.");
		e.preventDefault();
		return false;
	};
	
	document.querySelectorAll(".added-place-startTime").forEach((elem) => {
		placesStartTime.push(elem.value);
	});
	placesStartTimeArr.value = placesStartTime;
});

</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
