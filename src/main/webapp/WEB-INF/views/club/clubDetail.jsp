<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>
             


<section>
<!-- Modal -->
    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="reportModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="reportModalLabel"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
	          <span>신고 도메인 : </span>
	          <input type="text" name="domain" id="domain" value="${domain}" readonly/>
	          <br/><br/>
	          <span>신고자 : </span>
	          <input type="text" name="reporter" id="reporter" value="${memberId}" readonly/>
	          <br/><br/><br/>
	          <span>신고 사유</span><br/>
	          <textarea name="reason" id="reason" placeholder="신고 내용을 입력해주세요." required style="resize:none;"></textarea>
          </div>
          <div class="modal-footer flex-column">
            <div class="d-flex justify-content-between w-100">
            </div>
            <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="clubReportSubmit()">확인</button>
          </div>
        </div>
      </div>
    </div>

	<button 
		class="btn btn-outline-success my-2 my-sm-0" 
		type="button" 
		onclick="location.href = '${pageContext.request.contextPath}/club/${domain}/clubEnroll.do'">
		가입신청하기
	</button>
	
	
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
	
	<nav id="club-button">
		<!-- 방장일 경우에 -->
		<c:if test ="${memberRole eq 3}">
			<button type="button" class="btn btn-success" id="club-update-btn">모임 정보 수정</button>
			<button type="button" class="btn btn-danger" id="clubDisabled">모임 삭제</button>
			<button type="button" class="btn btn-warning" id="club-style-update">모임 스타일 설정</button>
			<button type="button" class="btn btn-info" id="club-title-update">모임 타이틀 설정</button>
		</c:if>
		
		<button type="button" class="btn btn-danger" id="clubReport">🚨</button>
		
		<!-- 관리자일 경우에 -->
		<c:if test = "${memberId eq 'admin'}">
			<button type="button" class="btn btn-danger" id="clubDisabled">모임 비활성화</button>
		</c:if>
		
		<a href ="${pageContext.request.contextPath}/club/${domain}/clubMemberList.do">모임내 회원조회</a>
			<button type="button" class="btn btn-danger" id="clubLike" onclick="clubLike()">❤️</button>
	</nav>
	<form:form
		name="clubLikeFrm"
		action="${pageContext.request.contextPath}/club/clubLike.do"
		method="POST">
			<input type="hidden" id="memberId" name="memberId" value="${memberId}">
			<input type="hidden" id="domain" name="domain" value="${domain}">
	</form:form>
	<nav>
		<h3>메뉴 바</h3>
		<a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do">게시판</a>
		<a href="${pageContext.request.contextPath}/club/${domain}/chatRoom.do">채팅</a>
		<a href="${pageContext.request.contextPath}/club/${domain}/manageMember.do">회원관리</a>
	</nav>
	

	<jsp:include page="/WEB-INF/views/club/clubLayout/clubLayoutType${layout.type}.jsp"></jsp:include>

	
</section>
	<div>
	
	</div>

<script>
// 창환(모임 신고)
document.querySelector("#clubReport").onclick = () => {
	const frm = document.clubReportFrm;
	$("#reportModal")
	.modal()
	.on('shown.bs.modal', () => {
	});
};

// 창환(모임 신고)
const clubReportSubmit = () => {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	const domain = document.querySelector('#domain').value;
	const reporter = document.querySelector('#reporter').value;
	const reason = document.querySelector('#reason').value;
	
	if(reason == null || reason == '') {
		alert('신고 내용을 입력해주세요');
		return;
	}
	
	$.ajax({
		url : '${pageContext.request.contextPath}/club/${domain}/clubReport.do',
		method : "post",
		data : { domain, reporter, reason },
		beforeSend(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success(response) {
			console.log(response);
		}
	});
	
	
	document.querySelector('#reason').value = ''; // 신고사유 초기화
};


// 준한(모임 비활성화)
	const domain = "<%= request.getAttribute("domain") %>"; 
	// 서버 사이드에서 domain 값을 가져와서 설정
    document.querySelector("#clubDisabled").onclick = (e) => {
        const userConfirmation = confirm("정말 비활성화 하시겠습니까?");
        if (userConfirmation) {
            // 도메인 값을 사용하여 컨트롤러로 이동하는 코드를 추가
            window.location.href = "${pageContext.request.contextPath}/club/" + domain + "/clubDisabled.do";
            alert('모임이 성공적으로 비활성화 되었습니다.');
        }
    };
  
document.querySelector("#club-update-btn").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubUpdate.do';
}

document.querySelector("#club-style-update").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubStyleUpdate.do';
}

document.querySelector("#club-title-update").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/'+domain+'/clubTitleUpdate.do';
}

console.log('${layout}');
document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});
console.log("${layout.font}")
document.body.style.fontFamily = "${layout.font}";
</script>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>
<script>
// 모임 좋아요 (현우)
	const clubLike = () => {
		console.log("함수 연결이 잘 되었늬?")
		const clubLikeFrm = document.clubLikeFrm;
		console.log(clubLikeFrm);
		clubLikeFrm.submit();
	}

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>