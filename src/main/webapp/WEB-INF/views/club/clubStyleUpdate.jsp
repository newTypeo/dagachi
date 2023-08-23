<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>


<section id="layout-update" class="">
	<form:form action="${pageContext.request.contextPath}/club/${domain}/clubStyleUpdate.do" method="POST">
		<h3>소모임 스타일 수정</h3>
		<br>
		<h5>레이아웃</h5>
		<div id="layout-select-container" class="lsc">
			<div id="layout-select-container-left" class="lscl">
				<div>
					<h1>img</h1>
				</div>
			</div>
			<div id="layout-select-container-right" class="lscr type-select-box">
				<label> 
					<input type="radio" name="type" value="0">
					Option 1
				</label> 
				<label> 
					<input type="radio" name="type" value="1">
					Option 2
				</label> 
				<label> 
					<input type="radio" name="type" value="2">
					Option 3
				</label>
				<label> 
					<input type="radio" name="type" value="3">
					Option 4
				</label>
			</div>
		</div>
		<br>
		<h5>폰트</h5>
		<div class="lsc">
			<div class="lscl">
				<div class="font-box" style="font-family: '${layout.font}'">
					<p>모두 다 같이 가치있게, 다가치</p>
					<p>Everyone is valuable</p>
				</div>
			</div>
			<div class="lscr font-select-box">
				<label style="font-family: IBM Plex Sans KR;"> 
					<input type="radio" name="font" value="IBM Plex Sans KR">
					IBM Plex Sans KR
				</label><br>
				<label style="font-family: Do Hyeon;"> 
					<input type="radio" name="font" value="Do Hyeon">
					Do Hyeon
				</label><br>
				<label style="font-family: Hahmlet;"> 
					<input type="radio" name="font" value="Hahmlet">
					Hahmlet
				</label><br>
				<label style="font-family: Jua;"> 
					<input type="radio" name="font" value="Jua">
					Jua
				</label><br>
				<label style="font-family: Noto Sans KR;"> 
					<input type="radio" name="font" value="Noto Sans KR">
					Noto Sans KR
				</label><br>
				<label style="font-family: Orbit;"> 
					<input type="radio" name="font" value="Orbit">
					Orbit
				</label>
			</div>
		</div>
		<br>
		<div id="color-select-continer">
			<div>
				<h5>배경색</h5>
				<label>현재 색상 : 
					<input type="color" value="${layout.backgroundColor}" disabled/>
				</label>
				<label>변경 색상 : 
					<input type="color" name="backgroundColor" value="${layout.backgroundColor}"/>
				</label>
			</div>
			
			<div>
				<h5>글자색</h5>
				<label>현재 색상 : 
					<input type="color" value="${layout.fontColor}" disabled/>
				</label>
				<label>변경 색상 : 
					<input type="color" name="fontColor" value="${layout.fontColor}"/>
				</label>
			</div>
			
			<div>
				<h5>포인트색</h5>
				<label>현재 색상 : 
					<input type="color" value="${layout.pointColor}" disabled/>
				</label>
				<label>변경 색상 : 
					<input type="color" name="pointColor" value="${layout.pointColor}"/>
				</label>
			</div>
			<div class="btn btn-primary" onclick="toDefault();">기본값으로 변경</div>
		</div>
		<div class="submit-box">
			<button type="submit" class="btn btn-primary">수정</button>
			<div class="btn btn-primary" onclick="window.history.back();">취소</div>
		</div>
	</form:form>
</section>

<script>
const typeSelectBox = document.querySelector(".type-select-box");
const typeSelectOptions = document.querySelectorAll('input[name="type"]');
typeSelectOptions.forEach((e) => {
	if (e.value == '${layout.type}') {
		e.checked = true;
	}
});

const fontSelectBox = document.querySelector(".font-select-box");
const fontBox = document.querySelector(".font-box");
const fontSelectOptions = document.querySelectorAll('input[name="font"]');

fontSelectBox.addEventListener('change', (e) => {
	fontBox.style.fontFamily = e.target.value;
});

fontSelectOptions.forEach((e) => {
	if (e.value == '${layout.font}') {
		e.checked = true;
	}
});

const colorInputs = document.querySelectorAll("#color-select-continer input");

const toDefault = () => {
	typeSelectOptions[0].checked = "true";
	fontSelectOptions[0].checked = "true";
	colorInputs[1].value = "#ffffff";  
	colorInputs[3].value = "#000000";
	colorInputs[5].value = "#000000";
};

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>