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
            <h5 class="modal-title" id="reportModalLabel">모임 신고</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
	          <span>신고 도메인 : </span>
	          <input type="text" class="form-control" name="domain" id="domain" value="${domain}" readonly/>
	          <br/><br/>
	          <span>신고자 : </span>
	          <input type="text" class="form-control" name="reporter" id="reporter" value="${memberId}" readonly/>
	          <br/><br/>
	          <span>신고 사유</span><br/>
	          <textarea name="reason" class="form-control" id="reason" placeholder="신고 내용을 입력해주세요." required style="resize:none;"></textarea>
          </div>
          <div class="modal-footer flex-column">
            <div class="d-flex justify-content-between w-100">
            </div>
            <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="clubReportSubmit()">확인</button>
          </div>
        </div>
      </div>
    </div>
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
		
		
		
		<!-- 관리자일 경우에 -->
		<c:if test = "${memberId eq 'admin'}">
			<button type="button" class="btn btn-danger" id="clubDisabled">모임 비활성화</button>
		</c:if>
		
	</nav>
	<form:form
		name="clubLikeFrm"
		action="${pageContext.request.contextPath}/club/clubLike.do"
		method="POST">
			<input type="hidden" id="memberId" name="memberId" value="${memberId}">
			<input type="hidden" id="domain" name="domain" value="${domain}">
	</form:form>
	

	<jsp:include page="/WEB-INF/views/club/clubLayout/clubLayoutType${layout.type}.jsp"></jsp:include>

	
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
</script>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>