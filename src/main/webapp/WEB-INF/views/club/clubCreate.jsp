<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="소모임 생성" name="title" />
</jsp:include>

<style>
.modal {
	top: -440px;
}
.modal-body {
	height: 400px;
}
#club-create-form-wrapper {
	margin: 0 auto;
	width: 800px;
	height: 700px;
}
.address-checked {
	padding: 5px;
	margin: 0;
}
.address-checked:hover {
	background-color: #ddd;
	cursor: pointer;
}

</style>

<section id="club-create-sec" class="">

	<div id="club-create-form-wrapper">
		<h1>소모임 생성</h1>
		<form>
			<div class="form-group">
				<label for="club_name">소모임 이름</label> <input type="text"
					class="form-control" id="club_name" name="club_name">
			</div>
			<div class="form-group">
				<label for="activity_area">주 활동지</label>
				<div id="activity-area-search-btn" class="btn btn-primary"
					data-toggle="modal" data-target="#activity-area-modal">검색</div>
				<input type="text" class="form-control" id="activity_area"
					name="activity_area" readonly>
			</div>
			<div class="form-group">
				<label for="catetory">카테고리</label> <select
					class="form-control" id="catetory" name="catetory">
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
				<label for="domain">도메인</label> <input type="text"
					class="form-control" id="domain" name="domain">
			</div>
			<div class="form-group">
				<label for="exampleFormControlTextarea1">소개글</label>
				<textarea class="form-control" id="exampleFormControlTextarea1"
					rows="3"></textarea>
			</div>
		</form>
		
		<div
			class="modal modal-dialog modal-dialog-scrollable fade"
			id="activity-area-modal" data-backdrop="static" data-keyboard="false"
			tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
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
						<label for="address">주 활동지 : </label> <input
							id="address-search-box" name="address"
							placeholder="ex) 강남구 역삼동 or 역삼동" />
						<div class="address-box"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
						<button id="address-confirm-btn" type="button" class="btn btn-primary">확인</button>
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


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>