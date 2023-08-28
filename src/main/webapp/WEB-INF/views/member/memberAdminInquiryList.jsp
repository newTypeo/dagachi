<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
    /* 가운데 정렬을 위한 스타일 */
    #reportInquiryListTable {
       background-color: #fff;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  width: 100%;
  text-align: center;
  magin: 0 auto;
    }

    /* 각 열 사이 여백을 주기 위한 스타일 */
    #reportInquiryListTable td {
        padding: 8px; /* 원하는 여백 크기로 조정 가능 */
    }
	#admin-report-inquiry-list-sec {
	    text-align: center; /* 수평 가운데 정렬 */
	}
	


</style>


<section id="admin-report-inquiry-list-sec" class="p-2 report-inquiry-list">
	<h1>QnA</h1>
	<a href="${pageContext.request.contextPath}/member/memberAdminInquiry.do">문의하기</a>
			
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
							            <c:if test="${inquiry.open == 1}"><td>🔒</td></c:if>
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
							            <td colspan="5">
							                <div id="response-${vs.index}" style="display: none;">
							              		<c:if test="${inquiry.open == 0}">
										           <c:if test="${empty inquiry.response}">
											             문의 내용 : ${inquiry.content}</br>
											             아직 답변이 달리지 않았습니다.
										            </c:if>
									                <c:if test="${not empty inquiry.response}">
									         	        문의 내용 :  ${inquiry.content} </br>
									                	문의 답변 :  ${inquiry.response}</br>
									                    문의 답변 일자 : <fmt:parseDate value="${inquiry.responseAt}" var="responseAt" pattern="yyyy-MM-dd"></fmt:parseDate>
									                    <fmt:formatDate value="${responseAt}" pattern="yy/MM/dd"/>
									                </c:if>
								                </c:if>
								               <!--  // 여기에 권한 추가해야함 -->
									            <c:if test="${inquiry.open == 1}">
									            		권한이 없습니다.
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
