<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
h1{
	margin-top: 30px;
	margin-left: 390px;
}
* {
  box-sizing: border-box;
  font-family: 'IBM Plex Sans KR', sans-serif;
  font-style: normal;
}
#reportInquiryListTable {
    background-color: #fff;
	padding: 20px;
	border-radius: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	width: 70%;
	text-align: center;
}

#reportInquiryListTable td {
    padding: 8px; 
}
#admin-report-inquiry-list-sec {
	 hight : 3000px;
 	transform: translate(182px, 10px);
}
.gray-text {
    color: gray; 
}
 .oneList:hover {
}
.button {
	margin-bottom: 15px;
    display: inline-block;
    padding: 10px 20px; /* 패딩을 조절하여 버튼 크기를 조절하세요 */
    background-color: #2990D0;/* 배경 색상 설정 */
    color: #fff; /* 텍스트 색상 설정 */
    border-radius: 10px; /* 둥글게 깍아주는 CSS 속성 */
    text-decoration: none; /* 링크 텍스트에 밑줄 제거 */
    font-size: 18px; /* 텍스트 크기 설정 */
    font-weight: bold; /* 텍스트 굵기 설정 */
    transition: background-color 0.3s ease; /* 호버 효과를 위한 전환 효과 */
}

.button:hover {
    background-color: #005dbf; /* 호버 시 배경 색상 변경 */ 
}

</style>

<section id="admin-report-inquiry-list-sec" class="p-2 report-inquiry-list">
	<h1>📢Q&A📢</h1>
	<a href="${pageContext.request.contextPath}/member/memberAdminInquiry.do"  class="button"> 문의하기</a>
	<div id="report-inquiry-list-wrapper">
				<table id="reportInquiryListTable">
					<thead>
						<tr>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty inquiry}">
							<tr>
								<td colspan="7">조회된 문의가 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${not empty inquiry}">
							<c:forEach items="${inquiry}" var="inquiry" varStatus="vs">
							        <tr class ="oneList">
							            <c:if test="${inquiry.open == 1}"><td>🔐</td></c:if>
							            <c:if test="${inquiry.open == 0}"><td>🔓</td></c:if>
							            <td>${inquiry.inquiryId}</td>
										<c:choose>
										    <c:when test="${inquiry.type == 1}">
										        <td>회원 정보 문의</td>
										    </c:when>
										    <c:when test="${inquiry.type == 2}">
										        <td>소모임 관련 문의</td>
										    </c:when>
										    <c:when test="${inquiry.type == 3}">
										        <td>결제 문의</td>
										    </c:when>
										    <c:when test="${inquiry.type == 4}">
										        <td>신고 문의</td>
										    </c:when>
										    <c:otherwise>
										        <td>알 수 없는 문의</td>
										    </c:otherwise>
										</c:choose>		
						
							            <td class="toggle-title" data-toggle-target="#response-${vs.index}">
							                <span style="cursor: pointer;">${inquiry.title}</span>
							            </td>
							            <td>${inquiry.writer}</td>
							            <td>
							                <fmt:parseDate value="${inquiry.createdAt}" var="createdAt" pattern="yyyy-MM-dd"></fmt:parseDate>
							                <fmt:formatDate value="${createdAt}" pattern="yy/MM/dd"/>
							            </td>
							            </tr>
							            <tr class ="twoList">
							            <td colspan="6">
							                <div id="response-${vs.index}" style="display: none; background-color: lightgray ; ">
							              		<c:if test="${inquiry.open == 0}">
										           <c:if test="${empty inquiry.response}">
											             </br>문의 내용 : ${inquiry.content}</br></br>
											           <span  class="gray-text" >아직 답변이 달리지 않았습니다.</span></br></br>
										            </c:if>
									                <c:if test="${not empty inquiry.response}">
									         	        문의 내용 :  ${inquiry.content} </br></br>
									                	문의 답변 :  ${inquiry.response}</br></br>
									                    문의 답변 일자 : <fmt:formatDate value="${inquiry.responseAt}" pattern="yy/MM/dd"/>
									                </c:if>
								                </c:if>
								               <!--  // 여기에 권한 추가해야함 -->
									            <c:if test="${inquiry.open == 1}">
									            		</br><span  class="gray-text" >권한이 없습니다.</span></br></br>
									            </c:if>								                
								              </div>							            
							            </td>
							        </tr>
							        
							</c:forEach>
						</c:if>
					</tbody>
				</table>
	</div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $(".toggle-title").click(function() {
            var targetId = $(this).data("toggle-target");
            $(targetId).toggle();
        });
    });
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
