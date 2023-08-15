<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title"/>
</jsp:include>


<section id="club-board-sec" class="">
	<button type="button" class="btn btn-primary" onclick="location.href = '${pageContext.request.contextPath}/club/clubBoardCreate.do'">작성</button>


	<table>
	  <thead>
		  <tr>
		    <th>사진</th>
		    <th>제목</th>
		    <th>글쓴이</th>
		    <th>작성일자</th>
		  </tr>
	  </thead>
	  <tbody></tbody>
	</table>
	
</section>


<script>

/* document.querySelector("").addEventListener("click",()=>{
	
}); */
	
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>